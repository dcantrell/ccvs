/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS 1.4 kit.
 * 
 * Print Log Information
 * 
 * Prints the RCS "log" (rlog) information for the specified files.  With no
 * argument, prints the log information for all the files in the directory
 * (recursive by default).
 */

#include "cvs.h"

#ifndef lint
static const char rcsid[] = "$CVSid: @(#)log.c 1.44 94/09/30 $";
USE(rcsid)
#endif

static Dtype log_dirproc PROTO((char *dir, char *repository, char *update_dir));
static int log_fileproc PROTO((char *file, char *update_dir, char *repository,
			 List * entries, List * srcfiles));
static void log_option_with_arg PROTO((char *name, char **var, char *opt));

static char options[PATH_MAX];

static const char *const log_usage[] =
{
    "Usage: %s %s [-l] [rlog-options] [files...]\n",
    "\t-l\tLocal directory only, no recursion.\n",
    NULL
};

int
cvslog (argc, argv)
    int argc;
    char **argv;
{
    int i;
    int numopt = 1;
    int err = 0;
    int local = 0;
    char *dates_opt = 0;
    char *revisions_opt = 0;
    char *states_opt = 0;
    char *who_opt = 0;

    if (argc == -1)
	usage (log_usage);

    /*
     * All 'log' command options except -l are passed directly on to 'rlog'
     */
    options[0] = '\0';			/* Assume none */
    for (i = 1; i < argc; i++)
    {
	if (argv[i][0] == '-' || argv[i][0] == '\0')
	{
	    numopt++;
	    switch (argv[i][1])
	    {
		case 'l':
		    local = 1;
		    break;
		case 'd':
		    log_option_with_arg ("date list", 
					 &dates_opt, argv[i]);
		    break;
		case 'r':
		    log_option_with_arg ("revision list",
					 &revisions_opt, argv[i]);
		    break;
		case 's':
		    log_option_with_arg ("state list",
					 &states_opt, argv[i]);
		    break;
		case 'w':
		    log_option_with_arg ("user list",
					 &who_opt, argv[i]);
		    break;
		default:
		    (void) strcat (options, " ");
		    (void) strcat (options, argv[i]);
		    break;
	    }
	}
    }
    argc -= numopt;
    argv += numopt;

    if (client_active) {
	/* We're the local client.  Fire up the remote server.  */
	start_server ();
	
	ign_setup ();

	if (local)
	    if (fprintf (to_server, "Argument -l\n") < 0)
		error (1, errno, "writing to server");
	send_option_string (options);
	if (dates_opt) send_arg (dates_opt);
	if (revisions_opt) send_arg (revisions_opt);
	if (states_opt) send_arg (states_opt);
	if (who_opt) send_arg (who_opt);

#if 0
/* FIXME:  We shouldn't have to send current files to get log entries, but it
   doesn't work yet and I haven't debugged it.  So send the files --
   it's slower but it works.  gnu@cygnus.com  Apr94  */
	send_file_names (argc, argv);
#else
	send_files (argc, argv, local, 0);
#endif

	if (fprintf (to_server, "log\n") < 0)
	    error (1, errno, "writing to server");
        err = get_responses_and_close ();
	return err;
    }

    err = start_recursion (log_fileproc, (int (*) ()) NULL, log_dirproc,
			   (int (*) ()) NULL, argc, argv, local,
			   W_LOCAL | W_REPOS | W_ATTIC, 0, 1,
			   (char *) NULL, 1, 0);
    return (err);
}


/* Append an option to the options string.  */
static void
log_option_with_arg (name, var, opt)
     char *name;
     char **var;
     char *opt;
{
  if (*var)
    error (1, 0, "only one %s can be specified", name);
  *var = opt;
  if (! client_active)
    {
      (void) strcat (options, " ");
      (void) strcat (options, opt);
    }
}

/*
 * Do an rlog on a file
 */
/* ARGSUSED */
static int
log_fileproc (file, update_dir, repository, entries, srcfiles)
    char *file;
    char *update_dir;
    char *repository;
    List *entries;
    List *srcfiles;
{
    Node *p;
    RCSNode *rcsfile;
    int retcode = 0;

    p = findnode (srcfiles, file);
    if (p == NULL || (rcsfile = (RCSNode *) p->data) == NULL)
    {
	/* no rcs file.  What *do* we know about this file? */
	p = findnode (entries, file);
	if (p != NULL)
	{
	    Entnode *e;
	    
	    e = (Entnode *) p->data;
	    if (e->version[0] == '0' || e->version[1] == '\0')
	    {
		if (!really_quiet)
		    error (0, 0, "%s has been added, but not committed",
			   file);
		return(0);
	    }
	}
	
	if (!really_quiet)
	    error (0, 0, "nothing known about %s", file);
	
	return (1);
    }

#ifdef CVSDEA
    /* Print information on dead revisions.  Printing them at the
       start rather than with each revision is cheesy, but no more so
       than printing the symbolic tags at the start.  */
    {
	char *deafilename;
	FILE *deafile;
	int ch;
	deafilename = xmalloc (strlen (repository) + sizeof (CVSDEA) +
			       strlen (file) + 80);
	sprintf (deafilename, "%s/%s/%s", repository, CVSDEA, file);
	deafile = fopen (deafilename, "r");
	if (deafile == NULL)
	{
	    if (errno != ENOENT)
		error (0, errno, "cannot read %s", deafilename);
	}
	else
	{
	    int printed = 0;
	    while (1)
	    {
		ch = getc (deafile);
		if (ferror (deafile))
		    error (1, errno, "cannot read %s", deafilename);
		if (feof (deafile))
		    break;
		if (!printed)
		{
		    printed = 1;
		    printf ("Dead revisions: ");
		}
		if (ch == '\012')
		    putc (' ', stdout);
		else
		    putc (ch, stdout);
	    }
	    if (printed)
		putc ('\n', stdout);
	    if (fclose (deafile) == EOF)
		error (0, errno, "cannot close %s", deafilename);
	}
	free (deafilename);
    }
#endif /* CVSDEA */

    run_setup ("%s%s %s", Rcsbin, RCS_RLOG, options);
    run_arg (rcsfile->path);
    if ((retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_REALLY)) == -1)
    {
	error (1, errno, "fork failed for rlog on %s", file);
    }
    return (retcode);
}

/*
 * Print a warm fuzzy message
 */
/* ARGSUSED */
static Dtype
log_dirproc (dir, repository, update_dir)
    char *dir;
    char *repository;
    char *update_dir;
{
    if (!isdir (dir))
	return (R_SKIP_ALL);

    if (!quiet)
	error (0, 0, "Logging %s", update_dir);
    return (R_PROCESS);
}
