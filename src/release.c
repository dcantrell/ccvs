/*
 * Release: "cancel" a checkout in the history log.
 * 
 * - Don't allow release if anything is active - Don't allow release if not
 * above or inside repository. - Don't allow release if ./CVS/Repository is
 * not the same as the directory specified in the module database.
 * 
 * - Enter a line in the history log indicating the "release". - If asked to,
 * delete the local working directory.
 */

#include "cvs.h"

#ifndef lint
static const char rcsid[] = "$CVSid: @(#)release.c 1.23 94/09/21 $";
USE(rcsid);
#endif

static void release_delete PROTO((char *dir));

static const char *const release_usage[] =
{
    "Usage: %s %s [-d] modules...\n",
    "\t-d\tDelete the given directory.\n",
    NULL
};

static short delete;

int
release (argc, argv)
    int argc;
    char **argv;
{
#if 1 /* KFF_TESTING */

    FILE *fp;
    register int i, c;
    char *repository, *srepos;
    char line[PATH_MAX], update_cmd[PATH_MAX];
    char *thisarg;
    int arg_start_idx;

#ifdef SERVER_SUPPORT
    if (!server_active)
      {
#endif /* SERVER_SUPPORT */
        if (argc == -1)
          usage (release_usage);
        optind = 1;
        while ((c = getopt (argc, argv, "Qdq")) != -1)
          {
            switch (c)
              {
              case 'Q':
              case 'q':
#ifdef SERVER_SUPPORT
		/* The CVS 1.5 client sends these options (in addition to
		   Global_option requests), so we must ignore them.  */
		if (!server_active)
#endif
                  error (1, 0,
                         "-q or -Q must be specified before \"%s\"",
                         command_name);
		break;
              case 'd':
		delete++;
		break;
              case '?':
              default:
		usage (release_usage);
		break;
              }
          }
        argc -= optind;
        argv += optind;
#ifdef SERVER_SUPPORT
      }
#endif /* SERVER_SUPPORT */

    /* We're going to run "cvs -n -q update" and check its output; if
     * the output is sufficiently unalarming, then we release with no
     * questions asked.  Else we prompt, then maybe release.
     */
    /* Construct the update command. */
    sprintf (update_cmd, "%s -n -q -d %s update",
             program_name, CVSroot);

#ifdef CLIENT_SUPPORT
    /* Start the server; we'll close it after looping. */
    if (client_active)
      {
	start_server ();
	ign_setup ();
      }
#endif /* CLIENT_SUPPORT */

    /* On the server, argv[0] is "Dummy argument", but on the client,
     * it means something.  So the initializer of the `for' loop is
     * different depending which side we're on.
     */
#ifdef SERVER_SUPPORT
    if (server_active)
      arg_start_idx = 1;
    else
      arg_start_idx = 0;
#endif /* SERVER_SUPPORT */

    for (i = arg_start_idx; i < argc; i++)
    {
      thisarg = argv[i];
        
#ifdef SERVER_SUPPORT
      if (server_active)
      {
        /* Just log the release -- all the interesting stuff happened
         * on the client.
         */
        history_write ('F', thisarg, "", thisarg, "");	/* F == Free */
      }
      else
      {
#endif /* SERVER_SUPPORT */
        
        /*
         * If we are in a repository, do it.  Else if we are in the parent of
         * a directory with the same name as the module, "cd" into it and
         * look for a repository there.
         */
        if (isdir (thisarg))
        {
          if (chdir (thisarg) < 0)
          {
            if (!really_quiet)
              error (0, 0, "can't chdir to: %s", thisarg);
            continue;
          }
          if (!isdir (CVSADM))
          {
            if (!really_quiet)
              error (0, 0, "no repository module: %s", thisarg);
            continue;
          }
	}
	else
        {
          if (!really_quiet)
            error (0, 0, "no such directory: %s", thisarg);
          continue;
	}

	repository = Name_Repository ((char *) NULL, (char *) NULL);
	srepos = Short_Repository (repository);
        
	if (!really_quiet)
	{
          /* The "release" command piggybacks on "update", which
           * does the real work of finding out if anything is not
           * up-to-date with the repository.  Then "release" prompts
           * the user, telling her how many files have been
           * modified, and asking if she still wants to do the
           * release.
           *
           * This is "popen()" instead of "Popen()" since we
           * wouldn't want the `noexec' flag to stop it.
           */
          fp = popen (update_cmd, "r");
          c = 0;

          /* FIXME: If the update exited with an error, then we just
           * want to complain and go on to the next arg.  Especially,
           * we do not want to delete the local copy, since it's
           * obviously not what the user thinks it is.  However, right
           * now we go ahead and prompt the user anyway, though at
           * least they'll see the error messages from "cvs update"
           * and get suspicious.
           */

          while (fgets (line, sizeof (line), fp))
          {
            if (strchr ("MARCZ", *line))
              c++;
            (void) printf (line);
          }

          (void) pclose (fp);
          (void) printf ("You have [%d] altered files in this repository.\n",
                         c);
          (void) printf ("Are you sure you want to release %smodule `%s': ",
                         delete ? "(and delete) " : "", thisarg);
          c = !yesno ();
          if (c)			/* "No" */
          {
            (void) fprintf (stderr, "** `%s' aborted by user choice.\n",
                            command_name);
            free (repository);
            continue;
          }
	}

#ifdef CLIENT_SUPPORT
        if (client_active)
        {
          if (fprintf (to_server, "Argument %s\n", thisarg) < 0)
	    error (1, errno, "writing to server");
          if (fprintf (to_server, "release\n") < 0)
	    error (1, errno, "writing to server");
        }
        else
        {
#endif /* CLIENT_SUPPORT */
          history_write ('F', thisarg, "", thisarg, ""); /* F == Free */
#ifdef CLIENT_SUPPORT
        } /* else client not active */
#endif /* CLIENT_SUPPORT */
        
        free (repository);
        if (delete) release_delete (thisarg);
        
#ifdef CLIENT_SUPPORT
        if (client_active)
          return get_responses_and_close ();
        else
#endif /* CLIENT_SUPPORT */
          return (0);
        
#ifdef SERVER_SUPPORT
      } /* else server not active */
#endif  /* SERVER_SUPPORT */
    }   /* `for' loop */
}





#else /* else not KFF_TESTING */

    FILE *fp;
    register int i, c;
    register char *cp;
    int margc;
    DBM *db;
    datum key, val;
    char *repository, *srepos;
    char **margv, *modargv[MAXFILEPERDIR], line[PATH_MAX];

    if (argc == -1)
	usage (release_usage);
    optind = 1;
    while ((c = getopt (argc, argv, "Qdq")) != -1)
    {
	switch (c)
	{
	    case 'Q':
	    case 'q':
#ifdef SERVER_SUPPORT
		/* The CVS 1.5 client sends these options (in addition to
		   Global_option requests), so we must ignore them.  */
		if (!server_active)
#endif
		    error (1, 0,
			   "-q or -Q must be specified before \"%s\"",
			   command_name);
		break;
	    case 'd':
		delete++;
		break;
	    case '?':
	    default:
		usage (release_usage);
		break;
	}
    }
    argc -= optind;
    argv += optind;

#ifdef CLIENT_SUPPORT
    if (client_active) {
	/* We're the client side.  Fire up the remote server.  */
	start_server ();
	
	ign_setup ();

	if (delete)
	    send_arg("-d");

	if (fprintf (to_server, "release\n") < 0)
	    error (1, errno, "writing to server");
        return get_responses_and_close ();
    }
#endif

    if (!(db = open_module ()))
	return (1);
    for (i = 0; i < argc; i++)
    {

	/*
	 * If we are in a repository, do it.  Else if we are in the parent of
	 * a directory with the same name as the module, "cd" into it and
	 * look for a repository there.
	 */
        /* KFF: The above should probably read:
	/*
	 * If we are in a working copy, do it.  Else if we are in the
         * parent of a directory with the same name as the module,
         * "cd" into it and look for a working copy there.
	 */
        /* KFF: Furthermore, the open_module() call above and the
         * popen("cvs update") should be known to be working and their
         * responses should be in hand when we run the other stuff
         * below...
         */
	if (isdir (argv[i]))
	{
	    if (chdir (argv[i]) < 0)
	    {
		if (!really_quiet)
		    error (0, 0, "can't chdir to: %s", argv[i]);
		continue;
	    }
	    if (!isdir (CVSADM))
	    {
		if (!really_quiet)
		    error (0, 0, "no repository module: %s", argv[i]);
		continue;
	    }
	}
	else
	{
	    if (!really_quiet)
		error (0, 0, "no such directory/module: %s", argv[i]);
	    continue;
	}

	repository = Name_Repository ((char *) NULL, (char *) NULL);
	srepos = Short_Repository (repository);

	/* grab module entry from database and check against short repos */
	key.dptr = argv[i];
	key.dsize = strlen (key.dptr);
	val = dbm_fetch (db, key);
	if (!val.dptr)
	{
	    error (0, 0, "no such module name: %s", argv[i]);
	    continue;
	}
	val.dptr[val.dsize] = '\0';
	if ((cp = strchr (val.dptr, '#')) != NULL) /* Strip out a comment */
	{
	    do
	    {
		*cp-- = '\0';
	    } while (isspace (*cp));
	}
	(void) sprintf (line, "%s %s", key.dptr, val.dptr);
	line2argv (&margc, modargv, line);
	margv = modargv;

	optind = 1;
	while (getopt (margc, margv, CVSMODULE_OPTS) != -1)
	     /* do nothing */ ;
	margc -= optind;
	margv += optind;

	if (margc < 1)
	{
	    error (0, 0, "modules file missing directory for key %s value %s",
		   key.dptr, val.dptr);
	    continue;
	}
	if (fncmp (*margv, srepos))
	{
	    error (0, 0, "repository mismatch: module[%s], here[%s]",
		   *margv, srepos);
	    free (repository);
	    continue;
	}

	if (!really_quiet)
	{

	    /*
	     * Now see if there is any reason not to allow a "Release" This
	     * is "popen()" instead of "Popen()" since we don't want "-n" to
	     * stop it.
	     */
	    fp = popen ("cvs -n -q update", "r");
	    c = 0;
	    while (fgets (line, sizeof (line), fp))
	    {
		if (strchr ("MARCZ", *line))
		    c++;
		(void) printf (line);
	    }
	    (void) pclose (fp);
	    (void) printf ("You have [%d] altered files in this repository.\n",
			   c);
	    (void) printf ("Are you sure you want to release %smodule `%s': ",
			   delete ? "(and delete) " : "", argv[i]);
	    c = !yesno ();
	    if (c)			/* "No" */
	    {
		(void) fprintf (stderr, "** `%s' aborted by user choice.\n",
				command_name);
		free (repository);
		continue;
	    }
	}

	/*
	 * So, we've passed all the tests, go ahead and release it. First,
	 * log the release, then attempt to delete it.
	 */
	history_write ('F', argv[i], "", argv[i], "");	/* F == Free */
	free (repository);

	if (delete)
	    release_delete (argv[i]);
    }
    close_module (db);
    return (0);
}
#endif /* KFF_TESTING */

/* We want to "rm -r" the repository, but let us be a little paranoid. */
static void
release_delete (dir)
    char *dir;
{
    struct stat st;
    ino_t ino;
    int retcode = 0;

    (void) stat (".", &st);
    ino = st.st_ino;
    (void) chdir ("..");
    (void) stat (dir, &st);
    if (ino != st.st_ino)
    {
	error (0, 0,
	       "Parent dir on a different disk, delete of %s aborted", dir);
	return;
    }
    /*
     * XXX - shouldn't this just delete the CVS-controlled files and, perhaps,
     * the files that would normally be ignored and leave everything else?
     */
    run_setup ("%s -fr", RM);
    run_arg (dir);
    if ((retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL)) != 0)
	error (0, retcode == -1 ? errno : 0, 
	       "deletion of module %s failed.", dir);
}
