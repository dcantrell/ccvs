/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS 1.4 kit.
 * 
 * Print Log Information
 * 
 * This line exists solely to test some pcl-cvs/ChangeLog stuff.  You
 * can delete it, if indeed it's still here when you read it.  -Karl
 *
 * Prints the RCS "log" (rlog) information for the specified files.  With no
 * argument, prints the log information for all the files in the directory
 * (recursive by default).
 */

#include "cvs.h"

static Dtype log_dirproc PROTO ((void *callerdat, char *dir,
				 char *repository, char *update_dir));
static int log_fileproc PROTO ((void *callerdat, struct file_info *finfo));
static int log_symbol PROTO ((Node *, void *));
static int log_count PROTO ((Node *, void *));
static void log_tree PROTO ((RCSNode *, const char *));
static void log_abranch PROTO ((RCSNode *, const char *));
static void log_version PROTO ((RCSNode *, RCSVers *, int));
static int log_branch PROTO ((Node *, void *));

static const char *const log_usage[] =
{
    "Usage: %s %s [-l] [rlog-options] [files...]\n",
    "\t-l\tLocal directory only, no recursion.\n",
    NULL
};

/* This structure is used to pass information through start_recursion.  */
struct log_data
{
    /* Nonzero if we need to invoke rlog (because we were passed
       options we don't understand).  */
    int dorlog;
    /* Nonzero if the -N option was seen, meaning that tag information
       should not be printed.  */
    int notags;
    /* Argument count and vector for rlog, if dorlog is set.  */
    int argc;
    char **argv;
};

int
cvslog (argc, argv)
    int argc;
    char **argv;
{
    int c;
    int err = 0;
    int local = 0;
    struct log_data log_data;

    if (argc == -1)
	usage (log_usage);

    log_data.dorlog = 0;
    log_data.notags = 0;

    /*
     * All 'log' command options except -l are passed directly on to 'rlog'.
     * If we see nothing but -N, we don't invoke 'rlog', but just
     * handle the printing ourselves.
     */
    opterr = 0;
    optind = 1;
    while ((c = getopt (argc, argv, "lN")) != -1)
    {
	switch (c)
	{
	    case 'l':
		local = 1;
		break;
	    case 'N':
		log_data.notags = 1;
		break;
	    case '?':
	    default:
		/* We got an unrecognized option.  We have to invoke
		   rlog directly.  */
		log_data.dorlog = 1;
		log_data.argc = argc;
		log_data.argv = argv;
		break;
	}
    }
    opterr = 1;

    wrap_setup ();

#ifdef CLIENT_SUPPORT
    if (client_active)
    {
	int i;

	/* We're the local client.  Fire up the remote server.  */
	start_server ();
	
	ign_setup ();

	for (i = 1; i < argc && argv[i][0] == '-'; i++)
	  send_arg (argv[i]);

	send_file_names (argc - i, argv + i, SEND_EXPAND_WILD);
/* FIXME:  We shouldn't have to send current files to get log entries, but it
   doesn't work yet and I haven't debugged it.  So send the files --
   it's slower but it works.  gnu@cygnus.com  Apr94  */
	send_files (argc - i, argv + i, local, 0);

	send_to_server ("log\012", 0);
        err = get_responses_and_close ();
	return err;
    }
#endif

    err = start_recursion (log_fileproc, (FILESDONEPROC) NULL, log_dirproc,
			   (DIRLEAVEPROC) NULL, (void *) &log_data,
			   argc - optind, argv + optind, local,
			   W_LOCAL | W_REPOS | W_ATTIC, 0, 1,
			   (char *) NULL, 1);
    return (err);
}


/*
 * Do an rlog on a file
 */
/* ARGSUSED */
static int
log_fileproc (callerdat, finfo)
    void *callerdat;
    struct file_info *finfo;
{
    struct log_data *log_data = (struct log_data *) callerdat;
    Node *p;
    RCSNode *rcsfile;
    int retcode = 0;
    char buf[50];

    if ((rcsfile = finfo->rcs) == NULL)
    {
	/* no rcs file.  What *do* we know about this file? */
	p = findnode (finfo->entries, finfo->file);
	if (p != NULL)
	{
	    Entnode *e;
	    
	    e = (Entnode *) p->data;
	    if (e->version[0] == '0' || e->version[1] == '\0')
	    {
		if (!really_quiet)
		    error (0, 0, "%s has been added, but not committed",
			   finfo->file);
		return(0);
	    }
	}
	
	if (!really_quiet)
	    error (0, 0, "nothing known about %s", finfo->file);
	
	return (1);
    }

    /* Invoke rlog if we were given any options we don't understand.
       FIXME: We should eventually understand all options here, and
       never invoke rlog.  */
    if (log_data->dorlog)
    {
	run_setup ("%s%s -x,v/", Rcsbin, RCS_RLOG);
	{
	    int ac = log_data->argc;
	    char **av = log_data->argv;
	    int i;

	    for (i = 1; i < ac && av[i][0] == '-'; i++)
		if (av[i][1] != 'l')
		    run_arg (av[i]);
	}
	run_arg (rcsfile->path);

	if (*finfo->update_dir)
	{
	    char *workfile = xmalloc (strlen (finfo->update_dir)
				      + strlen (finfo->file)
				      + 2);
	    sprintf (workfile, "%s/%s", finfo->update_dir, finfo->file);
	    run_arg (workfile);
	    free (workfile);
	}

	if ((retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_REALLY)) == -1)
	{
	    error (1, errno, "fork failed for rlog on %s", finfo->file);
	}
	return (retcode);
    }

    /* The output here is intended to be exactly compatible with the
       output of rlog.  I'm not sure whether this code should be here
       or in rcs.c; I put it here because it is specific to the log
       function, even though it uses information gathered by the
       functions in rcs.c.  */

    RCS_fully_parse (rcsfile);

    cvs_output ("\n", 1);

    cvs_output ("RCS file: ", 0);
    cvs_output (rcsfile->path, 0);

    cvs_output ("\nWorking file: ", 0);
    if (finfo->update_dir[0] == '\0')
	cvs_output (finfo->file, 0);
    else
    {
	cvs_output (finfo->update_dir, 0);
	cvs_output ("/", 0);
	cvs_output (finfo->file, 0);

    }

    cvs_output ("\nhead:", 0);
    if (rcsfile->head != NULL)
    {
	cvs_output (" ", 1);
	cvs_output (rcsfile->head, 0);
    }

    cvs_output ("\nbranch:", 0);
    if (rcsfile->branch != NULL)
    {
	cvs_output (" ", 1);
	cvs_output (rcsfile->branch, 0);
    }

    cvs_output ("\nlocks:", 0);
    if (rcsfile->other != NULL)
    {
	p = findnode (rcsfile->other, "strict");
	if (p != NULL)
	    cvs_output (" strict", 0);
	p = findnode (rcsfile->other, "locks");
	if (p != NULL && p->data != NULL)
	{
	    char *f, *cp;

	    f = xstrdup (p->data);
	    cp = f;
	    while (*cp != '\0')
	    {
		char *cp2, *locker, *version;
		RCSVers *vnode;

		locker = cp;

		cp2 = strchr (cp, ':');
		if (cp2 == NULL)
		{
		    error (0, 0, "warning: bad locks field in RCS file `%s'",
			   finfo->fullname);
		    break;
		}

		*cp2 = '\0';

		cvs_output ("\n\t", 2);
		cvs_output (cp, cp2 - cp);
		cvs_output (": ", 2);

		cp = cp2 + 1;
		while (isspace (*cp) && *cp != '\0')
		    ++cp;

		version = cp;

		cp2 = cp;
		while (! isspace (*cp2) && *cp2 != '\0')
		    ++cp2;

		cvs_output (cp, cp2 - cp);

		if (*cp2 == '\0')
		    cp = cp2;
		else
		{
		    *cp2 = '\0';
		    cp = cp2 + 1;
		    while (isspace (*cp) && *cp != '\0')
			++cp;
		}

		p = findnode (rcsfile->versions, version);
		if (p == NULL)
		    error (0, 0,
			   "warning: lock for missing version `%s' in `%s'",
			   version, finfo->fullname);
		else
		{
		    vnode = (RCSVers *) p->data;
		    p = getnode ();
		    p->type = RCSFIELD;
		    p->key = xstrdup (";locker");
		    p->data = xstrdup (locker);
		    if (addnode (vnode->other, p) != 0)
		    {
			error (0, 0,
			       "warning: duplicate lock for `%s' in `%s'",
			       version, finfo->fullname);
			freenode (p);
		    }
		}
	    }

	    free (f);
	}
    }

    cvs_output ("\naccess list:", 0);
    if (rcsfile->other != NULL)
    {
	p = findnode (rcsfile->other, "access");
	if (p != NULL && p->data != NULL)
	{
	    const char *cp;

	    cp = p->data;
	    while (*cp != '\0')
	    {
		const char *cp2;

		cvs_output ("\n\t", 2);
		cp2 = cp;
		while (! isspace (*cp2) && *cp2 != '\0')
		    ++cp2;
		cvs_output (cp, cp2 - cp);
		cp = cp2;
		while (isspace (*cp) && *cp != '\0')
		    ++cp;
	    }
	}
    }

    if (! log_data->notags)
    {
	List *syms;

	cvs_output ("\nsymbolic names:", 0);
	syms = RCS_symbols (rcsfile);
	walklist (syms, log_symbol, NULL);
    }

    cvs_output ("\nkeyword substitution: ", 0);
    if (rcsfile->expand == NULL)
	cvs_output ("kv", 2);
    else
	cvs_output (rcsfile->expand, 0);

    cvs_output ("\ntotal revisions: ", 0);
    sprintf (buf, "%d", walklist (rcsfile->versions, log_count, NULL));
    cvs_output (buf, 0);
    cvs_output (";\tselected revisions: ", 0);
    cvs_output (buf, 0);

    cvs_output ("\n", 1);

    cvs_output ("description:\n", 0);
    if (rcsfile->other != NULL)
    {
	p = findnode (rcsfile->other, "desc");
	if (p != NULL)
	    cvs_output (p->data, 0);
    }

    if (rcsfile->head != NULL)
    {
	p = findnode (rcsfile->versions, rcsfile->head);
	if (p == NULL)
	    error (1, 0, "can not find head revision in `%s'",
		   finfo->fullname);
	while (p != NULL)
	{
	    RCSVers *vers;

	    vers = (RCSVers *) p->data;
	    log_version (rcsfile, vers, 1);
	    if (vers->next == NULL)
		p = NULL;
	    else
	    {
		p = findnode (rcsfile->versions, vers->next);
		if (p == NULL)
		    error (1, 0, "can not find next revision `%s' in `%s'",
			   vers->next, finfo->fullname);
	    }
	}

	log_tree (rcsfile, rcsfile->head);
    }

    cvs_output("\
=============================================================================\n",
	       0);

    return 0;
}

/*
 * Output a single symbol.  This is called via walklist.
 */
/*ARGSUSED*/
static int
log_symbol (p, closure)
    Node *p;
    void *closure;
{
    cvs_output ("\n\t", 2);
    cvs_output (p->key, 0);
    cvs_output (": ", 2);
    cvs_output (p->data, 0);
    return 0;
}

/*
 * Count the number of entries on a list.  This is called via walklist.
 */
/*ARGSUSED*/
static int
log_count (p, closure)
    Node *p;
    void *closure;
{
    return 1;
}

/*
 * Print the list of changes, not including the trunk, in reverse
 * order for each branch.
 */
static void
log_tree (rcs, ver)
    RCSNode *rcs;
    const char *ver;
{
    Node *p;
    RCSVers *vnode;

    p = findnode (rcs->versions, ver);
    if (p == NULL)
	error (1, 0, "missing version `%s' in RCS file `%s'",
	       ver, rcs->path);
    vnode = (RCSVers *) p->data;
    if (vnode->next != NULL)
	log_tree (rcs, vnode->next);
    if (vnode->branches != NULL)
    {
	Node *head, *branch;

	/* We need to do the branches in reverse order.  This breaks
           the List abstraction, but so does most of the branch
           manipulation in rcs.c.  */
	head = vnode->branches->list;
	for (branch = head->prev; branch != head; branch = branch->next)
	{
	    log_abranch (rcs, branch->key);
	    log_tree (rcs, branch->key);
	}
    }
}

/*
 * Log the changes for a branch, in reverse order.
 */
static void
log_abranch (rcs, ver)
    RCSNode *rcs;
    const char *ver;
{
    Node *p;
    RCSVers *vnode;

    p = findnode (rcs->versions, ver);
    if (p == NULL)
	error (1, 0, "missing version `%s' in RCS file `%s'",
	       ver, rcs->path);
    vnode = (RCSVers *) p->data;
    if (vnode->next != NULL)
	log_abranch (rcs, vnode->next);
    log_version (rcs, vnode, 0);
}

/*
 * Print the log output for a single version.
 */
static void
log_version (rcs, ver, trunk)
    RCSNode *rcs;
    RCSVers *ver;
    int trunk;
{
    Node *p;
    int year, mon, mday, hour, min, sec;
    char buf[100];
    Node *padd, *pdel;

    cvs_output ("----------------------------\nrevision ", 0);
    cvs_output (ver->version, 0);

    p = findnode (ver->other, ";locker");
    if (p != NULL)
    {
	cvs_output ("\tlocked by: ", 0);
	cvs_output (p->data, 0);
	cvs_output (";", 1);
    }

    cvs_output ("\ndate: ", 0);
    (void) sscanf (ver->date, SDATEFORM, &year, &mon, &mday, &hour, &min,
		   &sec);
    if (year < 1900)
	year += 1900;
    sprintf (buf, "%04d/%02d/%02d %02d:%02d:%02d", year, mon, mday,
	     hour, min, sec);
    cvs_output (buf, 0);

    cvs_output (";  author: ", 0);
    cvs_output (ver->author, 0);

    cvs_output (";  state: ", 0);
    p = findnode (ver->other, "state");
    cvs_output (p->data, 0);
    cvs_output (";", 1);

    if (! trunk)
    {
	padd = findnode (ver->other, ";add");
	pdel = findnode (ver->other, ";delete");
    }
    else if (ver->next == NULL)
    {
	padd = NULL;
	pdel = NULL;
    }
    else
    {
	Node *nextp;
	RCSVers *nextver;

	nextp = findnode (rcs->versions, ver->next);
	if (nextp == NULL)
	    error (1, 0, "missing version `%s' in `%s'", ver->next,
		   rcs->path);
	nextver = (RCSVers *) nextp->data;
	pdel = findnode (nextver->other, ";add");
	padd = findnode (nextver->other, ";delete");
    }

    if (padd != NULL)
    {
	cvs_output ("  lines: +", 0);
	cvs_output (padd->data, 0);
	cvs_output (" -", 2);
	cvs_output (pdel->data, 0);
    }

    if (ver->branches != NULL)
    {
	cvs_output ("\nbranches:", 0);
	walklist (ver->branches, log_branch, (void *) NULL);
    }

    cvs_output ("\n", 1);

    p = findnode (ver->other, "log");
    if (p == NULL || p->data[0] == '\0')
	cvs_output ("*** empty log message ***\n", 0);
    else
    {
	/* FIXME: Technically, the log message could contain a null
           byte.  */
	cvs_output (p->data, 0);
	if (p->data[strlen (p->data) - 1] != '\n')
	    cvs_output ("\n", 1);
    }
}

/*
 * Output a branch version.  This is called via walklist.
 */
/*ARGSUSED*/
static int
log_branch (p, closure)
    Node *p;
    void *closure;
{
    cvs_output ("  ", 2);
    if ((numdots (p->key) & 1) == 0)
	cvs_output (p->key, 0);
    else
    {
	char *f, *cp;

	f = xstrdup (p->key);
	cp = strrchr (f, '.');
	*cp = '\0';
	cvs_output (f, 0);
	free (f);
    }
    cvs_output (";", 1);
    return 0;
}

/*
 * Print a warm fuzzy message
 */
/* ARGSUSED */
static Dtype
log_dirproc (callerdat, dir, repository, update_dir)
    void *callerdat;
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
