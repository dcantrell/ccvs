/*
 * Release: "cancel" a checkout in the history log.
 * 
 * - Enter a line in the history log indicating the "release". - If asked to,
 * delete the local working directory.
 */

#include "cvs.h"
#include "getline.h"

static void release_delete PROTO((char *dir));

static const char *const release_usage[] =
{
    "Usage: %s %s [-d] directories...\n",
    "\t-d\tDelete the given directory.\n",
    "(Specify the --help global option for a list of other help options)\n",
    NULL
};

#ifdef SERVER_SUPPORT
static int release_server PROTO ((int argc, char **argv));

/* This is the server side of cvs release.  */
static int
release_server (argc, argv)
    int argc;
    char **argv;
{
    int i;

    /* Note that we skip argv[0].  */
    for (i = 1; i < argc; ++i)
	history_write ('F', argv[i], "", argv[i], "");
    return 0;
}

#endif /* SERVER_SUPPORT */

/* There are various things to improve about this implementation:

   1.  Using run_popen to run "cvs update" could be replaced by a
   fairly simple start_recursion/classify_file loop--a win for
   portability, performance, and cleanliness.  In particular, there is
   no particularly good way to find the right "cvs".

   2.  The fact that "cvs update" contacts the server slows things down;
   it undermines the case for using "cvs release" rather than "rm -rf".
   However, for correctly printing "? foo" and correctly handling
   CVSROOTADM_IGNORE, we currently need to contact the server.

   3.  Would be nice to take processing things on the client side one step
   further, and making it like edit/unedit in terms of working well if
   disconnected from the network, and then sending a delayed
   notification.

   4.  Having separate network turnarounds for the "Notify" request
   which we do as part of unedit, and for the "release" itself, is slow
   and unnecessary.  */

int
release (argc, argv)
    int argc;
    char **argv;
{
    FILE *fp;
    int i, c;
    char *repository;
    char *line = NULL;
    size_t line_allocated = 0;
    char *update_cmd;
    char *thisarg;
    int arg_start_idx;
    int err = 0;
    short delete_flag = 0;

#ifdef SERVER_SUPPORT
    if (server_active)
	return release_server (argc, argv);
#endif

    /* Everything from here on is client or local.  */
    if (argc == -1)
	usage (release_usage);
    optind = 0;
    while ((c = getopt (argc, argv, "+Qdq")) != -1)
    {
	switch (c)
	{
	    case 'Q':
	    case 'q':
		error (1, 0,
		       "-q or -Q must be specified before \"%s\"",
		       command_name);
		break;
	    case 'd':
		delete_flag++;
		break;
	    case '?':
	    default:
		usage (release_usage);
		break;
	}
    }
    argc -= optind;
    argv += optind;

    /* We're going to run "cvs -n -q update" and check its output; if
     * the output is sufficiently unalarming, then we release with no
     * questions asked.  Else we prompt, then maybe release.
     */
    /* Construct the update command. */
    update_cmd = xmalloc (strlen (program_path)
			  + strlen (CVSroot_original)
			  + 20);
    sprintf (update_cmd, "%s -n -q -d %s update",
             program_path, CVSroot_original);

#ifdef CLIENT_SUPPORT
    /* Start the server; we'll close it after looping. */
    if (client_active)
    {
	start_server ();
	ign_setup ();
    }
#endif /* CLIENT_SUPPORT */

    arg_start_idx = 0;

    for (i = arg_start_idx; i < argc; i++)
    {
	thisarg = argv[i];

        if (isdir (thisarg))
        {
	    if (CVS_CHDIR (thisarg) < 0)
	    {
		if (!really_quiet)
		    error (0, errno, "can't chdir to: %s", thisarg);
		continue;
	    }
	    if (!isdir (CVSADM))
	    {
		if (!really_quiet)
		    error (0, 0, "no repository directory: %s", thisarg);
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

	if (!really_quiet)
	{
	    /* The "release" command piggybacks on "update", which
	       does the real work of finding out if anything is not
	       up-to-date with the repository.  Then "release" prompts
	       the user, telling her how many files have been
	       modified, and asking if she still wants to do the
	       release.  */
	    fp = run_popen (update_cmd, "r");
	    c = 0;

	    while (getline (&line, &line_allocated, fp) >= 0)
	    {
		if (strchr ("MARCZ", *line))
		    c++;
		(void) printf (line);
	    }

	    /* If the update exited with an error, then we just want to
	       complain and go on to the next arg.  Especially, we do
	       not want to delete the local copy, since it's obviously
	       not what the user thinks it is.  */
	    if ((pclose (fp)) != 0)
	    {
		error (0, 0, "unable to release `%s'", thisarg);
		continue;
	    }

	    printf ("You have [%d] altered files in this repository.\n",
		    c);
	    printf ("Are you sure you want to release %sdirectory `%s': ",
		    delete_flag ? "(and delete) " : "", thisarg);
	    c = !yesno ();
	    if (c)			/* "No" */
	    {
		(void) fprintf (stderr, "** `%s' aborted by user choice.\n",
				command_name);
		free (repository);
		continue;
	    }
	}

	if (1
#ifdef CLIENT_SUPPORT
	    && !(client_active
		 && (!supported_request ("noop")
		     || !supported_request ("Notify")))
#endif
	    )
	{
	    /* We are chdir'ed into the directory in question.  
	       So don't pass args to unedit.  */
	    int argc = 1;
	    char *argv[3];
	    argv[0] = "dummy";
	    argv[1] = NULL;
	    err += unedit (argc, argv);
	}

#ifdef CLIENT_SUPPORT
        if (client_active)
        {
	    send_to_server ("Argument ", 0);
	    send_to_server (thisarg, 0);
	    send_to_server ("\012", 1);
	    send_to_server ("release\012", 0);
	}
        else
#endif /* CLIENT_SUPPORT */
        {
	    history_write ('F', thisarg, "", thisarg, ""); /* F == Free */
        }

        free (repository);
        if (delete_flag) release_delete (thisarg);

#ifdef CLIENT_SUPPORT
        if (client_active)
	    err += get_server_responses ();
#endif /* CLIENT_SUPPORT */
    }

#ifdef CLIENT_SUPPORT
    if (client_active)
    {
	/* Unfortunately, client.c doesn't offer a way to close
	   the connection without waiting for responses.  The extra
	   network turnaround here is quite unnecessary other than
	   that....  */
	send_to_server ("noop\012", 0);
	err += get_responses_and_close ();
    }
#endif /* CLIENT_SUPPORT */

    free (update_cmd);
    if (line != NULL)
	free (line);
    return err;
}


/* We want to "rm -r" the working directory, but let us be a little
   paranoid.  */
static void
release_delete (dir)
    char *dir;
{
    struct stat st;
    ino_t ino;

    (void) CVS_STAT (".", &st);
    ino = st.st_ino;
    (void) CVS_CHDIR ("..");
    (void) CVS_STAT (dir, &st);
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
    if (unlink_file_dir (dir) < 0)
	error (0, errno, "deletion of directory %s failed", dir);
}
