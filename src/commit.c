/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS 1.4 kit.
 * 
 * Commit Files
 * 
 * "commit" commits the present version to the RCS repository, AFTER
 * having done a test on conflicts.
 *
 * The call is: cvs commit [options] files...
 * 
 */

#include "cvs.h"

#ifndef lint
static char rcsid[] = "$CVSid: @(#)commit.c 1.101 94/10/07 $";
USE(rcsid)
#endif

static Dtype check_direntproc PROTO((char *dir, char *repos, char *update_dir));
static int check_fileproc PROTO((char *file, char *update_dir, char *repository,
			   List * entries, List * srcfiles));
static int check_filesdoneproc PROTO((int err, char *repos, char *update_dir));
static int checkaddfile PROTO((char *file, char *repository, char *tag,
			 List *srcfiles)); 
static Dtype commit_direntproc PROTO((char *dir, char *repos, char *update_dir));
static int commit_dirleaveproc PROTO((char *dir, int err, char *update_dir));
static int commit_fileproc PROTO((char *file, char *update_dir, char *repository,
			    List * entries, List * srcfiles));
static int commit_filesdoneproc PROTO((int err, char *repository, char *update_dir));
static int finaladd PROTO((char *file, char *revision, char *tag,
			   char *options, char *update_dir,
			   char *repository, List *entries));
static int findmaxrev PROTO((Node * p, void *closure));
static int fsortcmp PROTO((Node * p, Node * q));
static int lock_RCS PROTO((char *user, char *rcs, char *rev, char *repository));
static int lock_filesdoneproc PROTO((int err, char *repository, char *update_dir));
static int lockrcsfile PROTO((char *file, char *repository, char *rev));
static int precommit_list_proc PROTO((Node * p, void *closure));
static int precommit_proc PROTO((char *repository, char *filter));
static int remove_file PROTO((char *file, char *repository, char *tag,
			char *message, List *entries, List *srcfiles));
static void fix_rcs_modes PROTO((char *rcs, char *user));
static void fixaddfile PROTO((char *file, char *repository));
static void fixbranch PROTO((char *file, char *repository, char *branch));
static void unlockrcs PROTO((char *file, char *repository));
static void ci_delproc PROTO((Node *p));
static void masterlist_delproc PROTO((Node *p));
static void locate_rcs PROTO((char *file, char *repository, char *rcs));
#ifdef CVSDEA
static char *ci_new_rev PROTO((char *rev, char *msg, char *rcs));
static void mark_dead PROTO((char *file, char *repository, char *new_rev));
#endif

struct commit_info
{
    Ctype status;			/* as returned from Classify_File() */
    char *rev;				/* a numeric rev, if we know it */
    char *tag;				/* any sticky tag, or -r option */
    char *options;			/* Any sticky -k option */
};
struct master_lists
{
    List *ulist;			/* list for Update_Logfile */
    List *cilist;			/* list with commit_info structs */
};

static int force_ci = 0;
static int got_message;
static int run_module_prog = 1;
static int aflag;
static char *tag;
static char *write_dirtag;
static char *logfile;
static List *mulist;
static List *locklist;
static char *message;

static const char *const commit_usage[] =
{
    "Usage: %s %s [-nRlf] [-m msg | -F logfile] [-r rev] files...\n",
    "\t-n\tDo not run the module program (if any).\n",
    "\t-R\tProcess directories recursively.\n",
    "\t-l\tLocal directory only (not recursive).\n",
    "\t-f\tForce the file to be committed; disables recursion.\n",
    "\t-F file\tRead the log message from file.\n",
    "\t-m msg\tLog message.\n",
    "\t-r rev\tCommit to this branch or trunk revision.\n",
    NULL
};

int
commit (argc, argv)
    int argc;
    char *argv[];
{
    int c;
    int err = 0;
    int local = 0;

    if (argc == -1)
	usage (commit_usage);

#ifdef CVS_BADROOT
    /*
     * For log purposes, do not allow "root" to commit files.  If you look
     * like root, but are really logged in as a non-root user, it's OK.
     */
    if (geteuid () == (uid_t) 0)
    {
	struct passwd *pw;

	if ((pw = (struct passwd *) getpwnam (getcaller ())) == NULL)
	    error (1, 0, "you are unknown to this system");
	if (pw->pw_uid == (uid_t) 0)
	    error (1, 0, "cannot commit files as 'root'");
    }
#endif /* CVS_BADROOT */

    optind = 1;
    while ((c = getopt (argc, argv, "nlRm:fF:r:")) != -1)
    {
	switch (c)
	{
	    case 'n':
		run_module_prog = 0;
		break;
	    case 'm':
#ifdef FORCE_USE_EDITOR
		use_editor = TRUE;
#else
		use_editor = FALSE;
#endif
		if (message)
		{
		    free (message);
		    message = NULL;
		}

		message = xstrdup(optarg);
		break;
	    case 'r':
		if (tag)
		    free (tag);
		tag = xstrdup (optarg);
		break;
	    case 'l':
		local = 1;
		break;
	    case 'R':
		local = 0;
		break;
	    case 'f':
		force_ci = 1;
		local = 1;		/* also disable recursion */
		break;
	    case 'F':
#ifdef FORCE_USE_EDITOR
		use_editor = TRUE;
#else
		use_editor = FALSE;
#endif
		logfile = optarg;
		break;
	    case '?':
	    default:
		usage (commit_usage);
		break;
	}
    }
    argc -= optind;
    argv += optind;

    /* numeric specified revision means we ignore sticky tags... */
    if (tag && isdigit (*tag))
    {
	aflag = 1;
	/* strip trailing dots */
	while (tag[strlen (tag) - 1] == '.')
	    tag[strlen (tag) - 1] = '\0';
    }

    /* some checks related to the "-F logfile" option */
    if (logfile)
    {
	int n, logfd;
	struct stat statbuf;

	if (message)
	    error (1, 0, "cannot specify both a message and a log file");

	if ((logfd = open (logfile, O_RDONLY)) < 0)
	    error (1, errno, "cannot open log file %s", logfile);

	if (fstat(logfd, &statbuf) < 0)
	    error (1, errno, "cannot find size of log file %s", logfile);

	message = xmalloc (statbuf.st_size + 1);

	if ((n = read (logfd, message, statbuf.st_size + 1)) < 0)
	    error (1, errno, "cannot read log message from %s", logfile);

	(void) close (logfd);
	message[n] = '\0';
    }

    if (client_active) 
    {
	/*
	 * Do this now; don't ask for a log message if we can't talk to the
	 * server.  But if there is a syntax error in the options, give
	 * an error message without connecting.
	 */
	start_server ();
	
	ign_setup ();

	/*
	 * We do this once, not once for each directory as in normal CVS.
	 * The protocol is designed this way.  This is a feature.
	 *
	 * We could provide the lists of changed, modified, etc. files,
	 * however.  Our failure to do so is just laziness, not design.
	 */
	if (use_editor)
	    do_editor (".", &message, (char *)NULL, (List *)NULL);

	/* We always send some sort of message, even if empty.  */
	option_with_arg ("-m", message);

	if (local)
	    if (fprintf (to_server, "Argument -l\n") < 0)
		error (1, errno, "writing to server");
	if (force_ci)
	    if (fprintf (to_server, "Argument -f\n") < 0)
		error (1, errno, "writing to server");
	if (!run_module_prog)
	    if (fprintf (to_server, "Argument -n\n") < 0)
		error (1, errno, "writing to server");
	option_with_arg ("-r", tag);

	send_files (argc, argv, local, 0);

	if (fprintf (to_server, "ci\n") < 0)
	    error (1, errno, "writing to server");
	return get_responses_and_close ();
    }

    /* XXX - this is not the perfect check for this */
    if (argc <= 0)
	write_dirtag = tag;

    /*
     * Run the recursion processor to find all the dirs to lock and lock all
     * the dirs
     */
    locklist = getlist ();
    err = start_recursion ((int (*) ()) NULL, lock_filesdoneproc,
			   (Dtype (*) ()) NULL, (int (*) ()) NULL, argc,
			   argv, local, W_LOCAL, aflag, 0, (char *) NULL, 0,
			   0);
    sortlist (locklist, fsortcmp);
    if (Writer_Lock (locklist) != 0)
	error (1, 0, "lock failed - giving up");

    /*
     * Set up the master update list
     */
    mulist = getlist ();

    /*
     * Run the recursion processor to verify the files are all up-to-date
     */
    err = start_recursion (check_fileproc, check_filesdoneproc,
			   check_direntproc, (int (*) ()) NULL, argc,
			   argv, local, W_LOCAL, aflag, 0, (char *) NULL, 1,
			   0);
    if (err)
    {
	Lock_Cleanup ();
	error (1, 0, "correct above errors first!");
    }

    /*
     * Run the recursion processor to commit the files
     */
    if (noexec == 0)
	err = start_recursion (commit_fileproc, commit_filesdoneproc,
			       commit_direntproc, commit_dirleaveproc,
			       argc, argv, local, W_LOCAL, aflag, 0,
			       (char *) NULL, 1, 0);

    /*
     * Unlock all the dirs and clean up
     */
    Lock_Cleanup ();
    dellist (&mulist);
    dellist (&locklist);
    return (err);
}

/*
 * compare two lock list nodes (for sort)
 */
static int
fsortcmp (p, q)
    Node *p, *q;
{
    return (strcmp (p->key, q->key));
}

/*
 * Create a list of repositories to lock
 */
/* ARGSUSED */
static int
lock_filesdoneproc (err, repository, update_dir)
    int err;
    char *repository;
    char *update_dir;
{
    Node *p;

    p = getnode ();
    p->type = LOCK;
    p->key = xstrdup (repository);
    /* FIXME-KRP: this error condition should not simply be passed by. */
    if (p->key == NULL || addnode (locklist, p) != 0)
	freenode (p);
    return (err);
}

/*
 * Check to see if a file is ok to commit and make sure all files are
 * up-to-date
 */
/* ARGSUSED */
static int
check_fileproc (file, update_dir, repository, entries, srcfiles)
    char *file;
    char *update_dir;
    char *repository;
    List *entries;
    List *srcfiles;
{
    Ctype status;
    char *xdir;
    Node *p;
    List *ulist, *cilist;
    Vers_TS *vers;
    struct commit_info *ci;
    int save_noexec, save_quiet, save_really_quiet;

    save_noexec = noexec;
    save_quiet = quiet;
    save_really_quiet = really_quiet;
    noexec = quiet = really_quiet = 1;

    /* handle specified numeric revision specially */
    if (tag && isdigit (*tag))
    {
	/* If the tag is for the trunk, make sure we're at the head */
	if (numdots (tag) < 2)
	{
	    status = Classify_File (file, (char *) NULL, (char *) NULL,
				    (char *) NULL, 1, aflag, repository,
				    entries, srcfiles, &vers, update_dir, 0);
	    if (status == T_UPTODATE || status == T_MODIFIED ||
		status == T_ADDED)
	    {
		Ctype xstatus;

		freevers_ts (&vers);
		xstatus = Classify_File (file, tag, (char *) NULL,
					 (char *) NULL, 1, aflag, repository,
					 entries, srcfiles, &vers, update_dir,
					 0);
		if (xstatus == T_REMOVE_ENTRY)
		    status = T_MODIFIED;
		else if (status == T_MODIFIED && xstatus == T_CONFLICT)
		    status = T_MODIFIED;
		else
		    status = xstatus;
	    }
	}
	else
	{
	    char *xtag, *cp;

	    /*
	     * The revision is off the main trunk; make sure we're
	     * up-to-date with the head of the specified branch.
	     */
	    xtag = xstrdup (tag);
	    if ((numdots (xtag) & 1) != 0)
	    {
		cp = strrchr (xtag, '.');
		*cp = '\0';
	    }
	    status = Classify_File (file, xtag, (char *) NULL,
				    (char *) NULL, 1, aflag, repository,
				    entries, srcfiles, &vers, update_dir, 0);
	    if ((status == T_REMOVE_ENTRY || status == T_CONFLICT)
		&& (cp = strrchr (xtag, '.')) != NULL)
	    {
		/* pluck one more dot off the revision */
		*cp = '\0';
		freevers_ts (&vers);
		status = Classify_File (file, xtag, (char *) NULL,
					(char *) NULL, 1, aflag, repository,
					entries, srcfiles, &vers, update_dir,
					0);
		if (status == T_UPTODATE || status == T_REMOVE_ENTRY)
		    status = T_MODIFIED;
	    }
	    /* now, muck with vers to make the tag correct */
	    free (vers->tag);
	    vers->tag = xstrdup (tag);
	    free (xtag);
	}
    }
    else
	status = Classify_File (file, tag, (char *) NULL, (char *) NULL,
				1, 0, repository, entries, srcfiles, &vers,
				update_dir, 0);
    noexec = save_noexec;
    quiet = save_quiet;
    really_quiet = save_really_quiet;

    /*
     * If the force-commit option is enabled, and the file in question
     * appears to be up-to-date, just make it look modified so that
     * it will be committed.
     */
    if (force_ci && status == T_UPTODATE)
	status = T_MODIFIED;

    switch (status)
    {
	case T_CHECKOUT:
	case T_PATCH:
	case T_NEEDS_MERGE:
	case T_CONFLICT:
	case T_REMOVE_ENTRY:
	    if (update_dir[0] == '\0')
		error (0, 0, "Up-to-date check failed for `%s'", file);
	    else
		error (0, 0, "Up-to-date check failed for `%s/%s'",
		       update_dir, file);
	    freevers_ts (&vers);
	    return (1);
	case T_MODIFIED:
	case T_ADDED:
	case T_REMOVED:
	    /*
	     * some quick sanity checks; if no numeric -r option specified:
	     *	- can't have a sticky date
	     *	- can't have a sticky tag that is not a branch
	     * Also,
	     *	- if status is T_REMOVED, can't have a numeric tag
	     *	- if status is T_ADDED, rcs file must not exist
	     *	- if status is T_ADDED, can't have a non-trunk numeric rev
	     *	- if status is T_MODIFIED and a Conflict marker exists, don't
	     *    allow the commit if timestamp is identical or if we find
	     *    an RCS_MERGE_PAT in the file.
	     */
	    if (!tag || !isdigit (*tag))
	    {
		if (vers->date)
		{
		    if (update_dir[0] == '\0')
			error (0, 0,
			       "cannot commit with sticky date for file `%s'",
			       file);
		    else
			error
			  (0, 0,
			   "cannot commit with sticky date for file `%s/%s'",
			   update_dir, file);
		    freevers_ts (&vers);
		    return (1);
		}
		if (status == T_MODIFIED && vers->tag &&
		    !RCS_isbranch (file, vers->tag, srcfiles))
		{
		    if (update_dir[0] == '\0')
			error (0, 0,
			       "sticky tag `%s' for file `%s' is not a branch",
			       vers->tag, file);
		    else
			error
			  (0, 0,
			   "sticky tag `%s' for file `%s/%s' is not a branch",
			   vers->tag, update_dir, file);
		    freevers_ts (&vers);
		    return (1);
		}
	    }
	    if (status == T_MODIFIED && !force_ci && vers->ts_conflict)
	    {
		char *filestamp;
		int retcode;

		/*
		 * We found a "conflict" marker.
		 *
		 * If the timestamp on the file is the same as the
		 * timestamp stored in the Entries file, we block the commit.
		 */
		if (server_active)
		    retcode = vers->ts_conflict[0] != '=';
		else {
		filestamp = time_stamp (file);
		retcode = strcmp (vers->ts_conflict, filestamp);
		free (filestamp);
		}
		if (retcode == 0)
		{
		    if (update_dir[0] == '\0')
			error (0, 0,
			  "file `%s' had a conflict and has not been modified",
			       file);
		    else
			error (0, 0,
		       "file `%s/%s' had a conflict and has not been modified",
			       update_dir, file);
		    freevers_ts (&vers);
		    return (1);
		}

		/*
		 * If the timestamps differ, look for Conflict indicators
		 * in the file to see if we should block the commit anyway
		 */
		run_setup ("%s -s", GREP);
		run_arg (RCS_MERGE_PAT);
		run_arg (file);
		retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL);
		    
		if (retcode == -1)
		{
		    if (update_dir[0] == '\0')
			error (1, errno,
			       "fork failed while examining conflict in `%s'",
			       file);
		    else
			error (1, errno,
			     "fork failed while examining conflict in `%s/%s'",
			       update_dir, file);
		}
		else if (retcode == 0)
		{
		    if (update_dir[0] == '\0')
			error (0, 0,
			       "file `%s' still contains conflict indicators",
			       file);
		    else
			error (0, 0,
			     "file `%s/%s' still contains conflict indicators",
			       update_dir, file);
		    freevers_ts (&vers);
		    return (1);
		}
	    }

	    if (status == T_REMOVED && vers->tag && isdigit (*vers->tag))
	    {
		if (update_dir[0] == '\0')
		    error (0, 0,
	"cannot remove file `%s' which has a numeric sticky tag of `%s'",
			   file, vers->tag);
		else
		    error (0, 0,
	"cannot remove file `%s/%s' which has a numeric sticky tag of `%s'",
			   update_dir, file, vers->tag);
		freevers_ts (&vers);
		return (1);
	    }
	    if (status == T_ADDED)
	    {
		char rcs[PATH_MAX];

#ifdef DEATH_SUPPORT
		/* Don't look in the attic; if it exists there we will
		   move it back out in checkaddfile.  */
		sprintf(rcs, "%s/%s%s", repository, file, RCSEXT);
#else
		locate_rcs (file, repository, rcs);
#endif
		if (isreadable (rcs))
		{
		    if (update_dir[0] == '\0')
			error (0, 0,
		"cannot add file `%s' when RCS file `%s' already exists",
			       file, rcs);
		    else
			error (0, 0,
		"cannot add file `%s/%s' when RCS file `%s' already exists",
			       update_dir, file, rcs);
		    freevers_ts (&vers);
		    return (1);
		}
		if (vers->tag && isdigit (*vers->tag) &&
		    numdots (vers->tag) > 1)
		{
		    if (update_dir[0] == '\0')
			error (0, 0,
		"cannot add file `%s' with revision `%s'; must be on trunk",
			       file, vers->tag);
		    else
			error (0, 0,
		"cannot add file `%s/%s' with revision `%s'; must be on trunk",
			       update_dir, file, vers->tag);
		    freevers_ts (&vers);
		    return (1);
		}
	    }

	    /* done with consistency checks; now, to get on with the commit */
	    if (update_dir[0] == '\0')
		xdir = ".";
	    else
		xdir = update_dir;
	    if ((p = findnode (mulist, xdir)) != NULL)
	    {
		ulist = ((struct master_lists *) p->data)->ulist;
		cilist = ((struct master_lists *) p->data)->cilist;
	    }
	    else
	    {
		struct master_lists *ml;

		ulist = getlist ();
		cilist = getlist ();
		p = getnode ();
		p->key = xstrdup (xdir);
		p->type = UPDATE;
		ml = (struct master_lists *)
		    xmalloc (sizeof (struct master_lists));
		ml->ulist = ulist;
		ml->cilist = cilist;
		p->data = (char *) ml;
		p->delproc = masterlist_delproc;
		(void) addnode (mulist, p);
	    }

	    /* first do ulist, then cilist */
	    p = getnode ();
	    p->key = xstrdup (file);
	    p->type = UPDATE;
	    p->delproc = update_delproc;
	    p->data = (char *) status;
	    (void) addnode (ulist, p);

	    p = getnode ();
	    p->key = xstrdup (file);
	    p->type = UPDATE;
	    p->delproc = ci_delproc;
	    ci = (struct commit_info *) xmalloc (sizeof (struct commit_info));
	    ci->status = status;
	    if (vers->tag)
		if (isdigit (*vers->tag))
		    ci->rev = xstrdup (vers->tag);
		else
		    ci->rev = RCS_whatbranch (file, vers->tag, srcfiles);
	    else
		ci->rev = (char *) NULL;
	    ci->tag = xstrdup (vers->tag);
	    ci->options = xstrdup(vers->options);
	    p->data = (char *) ci;
	    (void) addnode (cilist, p);
	    break;
	case T_UNKNOWN:
	    if (update_dir[0] == '\0')
		error (0, 0, "nothing known about `%s'", file);
	    else
		error (0, 0, "nothing known about `%s/%s'", update_dir, file);
	    freevers_ts (&vers);
	    return (1);
	case T_UPTODATE:
	    break;
	default:
	    error (0, 0, "CVS internal error: unknown status %d", status);
	    break;
    }

    freevers_ts (&vers);
    return (0);
}

/*
 * Print warm fuzzies while examining the dirs
 */
/* ARGSUSED */
static Dtype
check_direntproc (dir, repos, update_dir)
    char *dir;
    char *repos;
    char *update_dir;
{
    if (!quiet)
	error (0, 0, "Examining %s", update_dir);

    return (R_PROCESS);
}

/*
 * Walklist proc to run pre-commit checks
 */
static int
precommit_list_proc (p, closure)
    Node *p;
    void *closure;
{
    if (p->data == (char *) T_ADDED || p->data == (char *) T_MODIFIED ||
	p->data == (char *) T_REMOVED)
    {
	run_arg (p->key);
    }
    return (0);
}

/*
 * Callback proc for pre-commit checking
 */
static List *ulist;
static int
precommit_proc (repository, filter)
    char *repository;
    char *filter;
{
    /* see if the filter is there, only if it's a full path */
    if (filter[0] == '/')
    {
    	char *s, *cp;
	
	s = xstrdup (filter);
	for (cp = s; *cp; cp++)
	    if (isspace (*cp))
	    {
		*cp = '\0';
		break;
	    }
	if (!isfile (s))
	{
	    error (0, errno, "cannot find pre-commit filter `%s'", s);
	    free (s);
	    return (1);			/* so it fails! */
	}
	free (s);
    }

    run_setup ("%s %s", filter, repository);
    (void) walklist (ulist, precommit_list_proc, NULL);
    return (run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL|RUN_REALLY));
}

/*
 * Run the pre-commit checks for the dir
 */
/* ARGSUSED */
static int
check_filesdoneproc (err, repos, update_dir)
    int err;
    char *repos;
    char *update_dir;
{
    int n;
    Node *p;

    /* find the update list for this dir */
    p = findnode (mulist, update_dir);
    if (p != NULL)
	ulist = ((struct master_lists *) p->data)->ulist;
    else
	ulist = (List *) NULL;

    /* skip the checks if there's nothing to do */
    if (ulist == NULL || ulist->list->next == ulist->list)
	return (err);

    /* run any pre-commit checks */
    if ((n = Parse_Info (CVSROOTADM_COMMITINFO, repos, precommit_proc, 1)) > 0)
    {
	error (0, 0, "Pre-commit check failed");
	err += n;
    }

    return (err);
}

/*
 * Do the work of committing a file
 */
static int maxrev;
static char sbranch[PATH_MAX];

/* ARGSUSED */
static int
commit_fileproc (file, update_dir, repository, entries, srcfiles)
    char *file;
    char *update_dir;
    char *repository;
    List *entries;
    List *srcfiles;
{
    Node *p;
    int err = 0;
    List *ulist, *cilist;
    struct commit_info *ci;
    char rcs[PATH_MAX];

    if (update_dir[0] == '\0')
	p = findnode (mulist, ".");
    else
	p = findnode (mulist, update_dir);

    /*
     * if p is null, there were file type command line args which were
     * all up-to-date so nothing really needs to be done
     */
    if (p == NULL)
	return (0);
    ulist = ((struct master_lists *) p->data)->ulist;
    cilist = ((struct master_lists *) p->data)->cilist;

    /*
     * At this point, we should have the commit message unless we were called
     * with files as args from the command line.  In that latter case, we
     * need to get the commit message ourselves
     */
    if (use_editor && !got_message)
      {
	got_message = 1;
	do_editor (update_dir, &message, repository, ulist);
      }

    p = findnode (cilist, file);
    if (p == NULL)
	return (0);

    ci = (struct commit_info *) p->data;
    if (ci->status == T_MODIFIED)
    {
	if (lockrcsfile (file, repository, ci->rev) != 0)
	{
	    unlockrcs (file, repository);
	    err = 1;
	    goto out;
	}
    }
    else if (ci->status == T_ADDED)
    {
	if (checkaddfile (file, repository, ci->tag, srcfiles) != 0)
	{
	    fixaddfile (file, repository);
	    err = 1;
	    goto out;
	}

#ifdef DEATH_SUPPORT
	/* adding files with a tag, now means adding them on a branch.
	   Since the branch test was done in check_fileproc for
	   modified files, we need to stub it in again here. */

	if (ci->tag) {
	    locate_rcs (file, repository, rcs);
	    ci->rev = RCS_whatbranch (file, ci->tag, srcfiles);
	    err = Checkin ('A', file, update_dir, repository, rcs, ci->rev,
			   ci->tag, ci->options, message, entries);
	    if (err != 0)
	    {
		unlockrcs (file, repository);
		fixbranch (file, repository, sbranch);
	    }

	    ci->status = T_UPTODATE;
	}
#endif /* DEATH_SUPPORT */
    }

    /*
     * Add the file for real
     */
    if (ci->status == T_ADDED)
    {
	char *xrev = (char *) NULL;

	if (ci->rev == NULL)
	{
	    /* find the max major rev number in this directory */
	    maxrev = 0;
	    (void) walklist (entries, findmaxrev, NULL);
	    if (maxrev == 0)
		maxrev = 1;
	    xrev = xmalloc (20);
	    (void) sprintf (xrev, "%d", maxrev);
	}

	/* XXX - an added file with symbolic -r should add tag as well */
	err = finaladd (file, ci->rev ? ci->rev : xrev, ci->tag, ci->options,
			update_dir, repository, entries);
	if (xrev)
	    free (xrev);
    }
    else if (ci->status == T_MODIFIED)
    {
	locate_rcs (file, repository, rcs);
	err = Checkin ('M', file, update_dir, repository,
		       rcs, ci->rev, ci->tag,
		       ci->options, message, entries);
	if (err != 0)
	{
	    unlockrcs (file, repository);
	    fixbranch (file, repository, sbranch);
	}
    }
    else if (ci->status == T_REMOVED)
    {
	err = remove_file (file, repository, ci->tag, message,
			   entries, srcfiles);
	if (server_active) {
	    server_scratch_entry_only ();
	    server_updated (file, update_dir, repository,
			    /* Doesn't matter, it won't get checked.  */
			    SERVER_UPDATED, (struct stat *) NULL,
			    (unsigned char *) NULL);
	}
    }

out:
    if (err != 0)
    {
	/* on failure, remove the file from ulist */
	p = findnode (ulist, file);
	if (p)
	    delnode (p);
    }

    return (err);
}

/*
 * Log the commit and clean up the update list
 */
/* ARGSUSED */
static int
commit_filesdoneproc (err, repository, update_dir)
    int err;
    char *repository;
    char *update_dir;
{
    char *xtag = (char *) NULL;
    Node *p;
    List *ulist;

    p = findnode (mulist, update_dir);
    if (p == NULL)
	return (err);

    ulist = ((struct master_lists *) p->data)->ulist;

    got_message = 0;

    /* see if we need to specify a per-directory or -r option tag */
    if (tag == NULL)
	ParseTag (&xtag, (char **) NULL);

    Update_Logfile (repository, message, tag ? tag : xtag, (FILE *) 0, ulist);
    if (xtag)
	free (xtag);

    if (err == 0 && run_module_prog)
    {
	char *cp;
	FILE *fp;
	char line[MAXLINELEN];
	char *repository;

	/* It is not an error if Checkin.prog does not exist.  */
	if ((fp = fopen (CVSADM_CIPROG, "r")) != NULL)
	{
	    if (fgets (line, sizeof (line), fp) != NULL)
	    {
		if ((cp = strrchr (line, '\n')) != NULL)
		    *cp = '\0';
		repository = Name_Repository ((char *) NULL, update_dir);
		run_setup ("%s %s", line, repository);
		(void) printf ("%s %s: Executing '", program_name,
			       command_name);
		run_print (stdout);
		(void) printf ("'\n");
		(void) run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL);
		free (repository);
	    }
	    (void) fclose (fp);
	}
    }

    return (err);
}

/*
 * Get the log message for a dir and print a warm fuzzy
 */
/* ARGSUSED */
static Dtype
commit_direntproc (dir, repos, update_dir)
    char *dir;
    char *repos;
    char *update_dir;
{
    Node *p;
    List *ulist;
    char *real_repos;

    /* find the update list for this dir */
    p = findnode (mulist, update_dir);
    if (p != NULL)
	ulist = ((struct master_lists *) p->data)->ulist;
    else
	ulist = (List *) NULL;

    /* skip the files as an optimization */
    if (ulist == NULL || ulist->list->next == ulist->list)
	return (R_SKIP_FILES);

    /* print the warm fuzzy */
    if (!quiet)
	error (0, 0, "Committing %s", update_dir);

    /* get commit message */
    if (use_editor)
    {
	got_message = 1;
	real_repos = Name_Repository (dir, update_dir);
	do_editor (update_dir, &message, real_repos, ulist);
	free (real_repos);
    }
    return (R_PROCESS);
}

/*
 * Process the post-commit proc if necessary
 */
/* ARGSUSED */
static int
commit_dirleaveproc (dir, err, update_dir)
    char *dir;
    int err;
    char *update_dir;
{
    /* update the per-directory tag info */
    if (err == 0 && write_dirtag != NULL)
    {
	WriteTag ((char *) NULL, write_dirtag, (char *) NULL);
	if (server_active)
	    server_set_sticky (update_dir, Name_Repository (dir, update_dir),
			       write_dirtag, (char *) NULL);
    }

    return (err);
}

/*
 * find the maximum major rev number in an entries file
 */
static int
findmaxrev (p, closure)
    Node *p;
    void *closure;
{
    char *cp;
    int thisrev;
    Entnode *entdata;

    entdata = (Entnode *) p->data;
    cp = strchr (entdata->version, '.');
    if (cp != NULL)
	*cp = '\0';
    thisrev = atoi (entdata->version);
    if (cp != NULL)
	*cp = '.';
    if (thisrev > maxrev)
	maxrev = thisrev;
    return (0);
}

/*
 * Actually remove a file by moving it to the attic
 * XXX - if removing a ,v file that is a relative symbolic link to
 * another ,v file, we probably should add a ".." component to the
 * link to keep it relative after we move it into the attic.
 */
static int
remove_file (file, repository, tag, message, entries, srcfiles)
    char *file;
    char *repository;
    char *tag;
    char *message;
    List *entries;
    List *srcfiles;
{
    mode_t omask;
    int retcode;
    char rcs[PATH_MAX];
    char *tmp;

#ifdef DEATH_SUPPORT
    int branch;
    char *lockflag;
    char *corev;
    char *rev;
    Node *p;
    RCSNode *rcsfile;

    corev = NULL;
    rev = NULL;
    lockflag = 0;
#endif /* DEATH_SUPPORT */

    retcode = 0;

    locate_rcs (file, repository, rcs);

#ifdef DEATH_SUPPORT
    branch = 0;
    if (tag && !(branch = RCS_isbranch (file, tag, srcfiles)))
#else
    if (tag)
#endif
    {
	/* a symbolic tag is specified; just remove the tag from the file */
	if ((retcode = RCS_deltag (rcs, tag)) != 0) 
	{
	    if (!quiet)
		error (0, retcode == -1 ? errno : 0,
		       "failed to remove tag `%s' from `%s'", tag, rcs);
	    return (1);
	}
	Scratch_Entry (entries, file);
	return (0);
    }

#ifdef DEATH_SUPPORT
    /* we are removing the file from either the head or a branch */
    /* commit a new, dead revision. */
    rev = NULL;
    lockflag = "-l";
    if (branch)
    {
	char *branchname;

	rev = RCS_whatbranch (file, tag, srcfiles);
	if (rev == NULL)
	{
	    error (0, 0, "cannot find branch \"%s\".", tag);
	    return (1);
	}
	
	p = findnode (srcfiles, file);
	if (p == NULL)
	{
	    error (0, 0, "boy, I'm confused.");
	    return (1);
	}
	rcsfile = (RCSNode *) p->data;
	branchname = RCS_getbranch (rcsfile, rev, 1);
	if (branchname == NULL)
	{
	    /* no revision exists on this branch.  use the previous
	       revision but do not lock. */
	    corev = RCS_gettag (rcsfile, tag, 1);
	    lockflag = "";
	} else
	{
	    corev = xstrdup (rev);
	    free (branchname);
	}
    }
    
    /* if removing without a tag or a branch, then make sure the default
       branch is the trunk. */
    if (!tag && !branch)
    {
        if (RCS_setbranch (rcs, NULL) != 0) 
	{
	    error (0, 0, "cannot change branch to default for %s",
		   rcs);
	    return (1);
	}
    }

    if (server_active) {
	/* If this is the server, there will be a file sitting in the
	   temp directory which is the kludgy way in which server.c
	   tells time_stamp that the file is no longer around.  Remove
	   it so we can create temp files with that name (ignore errors).  */
	unlink_file (file);
    }

    /* check something out.  Generally this is the head.  If we have a
       particular rev, then name it.  except when creating a branch,
       lock the rev we're checking out.  */
    run_setup ("%s%s %s %s%s %s", Rcsbin, RCS_CO,
	       lockflag,
	       rev ? "-r" : "",
	       rev ? corev : "", rcs); 
    if ((retcode = run_exec (RUN_TTY, RUN_TTY, DEVNULL, RUN_NORMAL))
	!= 0) {
	if (!quiet)
	    error (0, retcode == -1 ? errno : 0,
		   "failed to check out `%s'", rcs);
	return (1);
    }

    if (corev != NULL)
	free (corev);

#ifdef CVSDEA
    {
	char *new_rev;
	new_rev = ci_new_rev (rev, message, rcs);
	if (new_rev == NULL)
	    return 1;
	mark_dead (file, repository, new_rev);
	free (new_rev);
    }
#else
#ifdef DEATH_STATE
    run_setup ("%s%s -f -sdead %s%s", Rcsbin, RCS_CI, rev ? "-r" : "",
#else
    run_setup ("%s%s -K %s%s", Rcsbin, RCS_CI, rev ? "-r" : "",
#endif
	       rev ? rev : ""); 
    run_args ("-m%s", message);
    run_arg (rcs);
    if ((retcode = run_exec (RUN_TTY, RUN_TTY, DEVNULL, RUN_NORMAL))
	!= 0) {
	if (!quiet)
	    error (0, retcode == -1 ? errno : 0,
		   "failed to commit dead revision for `%s'", rcs);
	return (1);
    }
#endif /* CVSDEA */

    if (rev != NULL)
	free (rev);

    if (!branch)
#else /* No DEATH_SUPPORT */
    else
#endif /* No DEATH_SUPPORT */
    {
	/* this was the head; really move it into the Attic */
	tmp = xmalloc(strlen(repository) + 
		      sizeof('/') +
		      sizeof(CVSATTIC) +
		      sizeof('/') +
		      strlen(file) +
		      sizeof(RCSEXT) + 1);
	(void) sprintf (tmp, "%s/%s", repository, CVSATTIC);
	omask = umask (2);
	(void) mkdir (tmp, 0777);
	(void) umask (omask);
	(void) sprintf (tmp, "%s/%s/%s%s", repository, CVSATTIC, file, RCSEXT);
	
#ifdef DEATH_SUPPORT
	if (strcmp (rcs, tmp) != 0
	    && rename (rcs, tmp) == -1
	    && (isreadable (rcs) || !isreadable (tmp)))
	{
	    /* FIXME: should free tmp.  */
	    return (1);
	}
	free(tmp);
    }

    Scratch_Entry (entries, file);
    return (0);
#else /* No DEATH_SUPPORT */

	if ((strcmp (rcs, tmp) == 0 || rename (rcs, tmp) != -1) ||
	    (!isreadable (rcs) && isreadable (tmp)))
 	{
	    Scratch_Entry (entries, file);
	    /* FIXME: should free tmp.  */
	    return (0);
	}
	/* FIXME: should free tmp.  */
    }
    return (1);
#endif /* No DEATH_SUPPORT */
}

/*
 * Do the actual checkin for added files
 */
static int
finaladd (file, rev, tag, options, update_dir, repository, entries)
    char *file;
    char *rev;
    char *tag;
    char *options;
    char *update_dir;
    char *repository;
    List *entries;
{
    int ret;
    char tmp[PATH_MAX];
    char rcs[PATH_MAX];

    locate_rcs (file, repository, rcs);
    ret = Checkin ('A', file, update_dir, repository, rcs, rev, tag, options,
		   message, entries);
    if (ret == 0)
    {
	(void) sprintf (tmp, "%s/%s%s", CVSADM, file, CVSEXT_OPT);
	(void) unlink_file (tmp);
	(void) sprintf (tmp, "%s/%s%s", CVSADM, file, CVSEXT_LOG);
	(void) unlink_file (tmp);
    }
    else
	fixaddfile (file, repository);
    return (ret);
}

/*
 * Unlock an rcs file
 */
static void
unlockrcs (file, repository)
    char *file;
    char *repository;
{
    char rcs[PATH_MAX];
    int retcode = 0;

    locate_rcs (file, repository, rcs);

    if ((retcode = RCS_unlock (rcs, NULL)) != 0)
	error (retcode == -1 ? 1 : 0, retcode == -1 ? errno : 0,
	       "could not unlock %s", rcs);
}

/*
 * remove a partially added file.  if we can parse it, leave it alone.
 */
static void
fixaddfile (file, repository)
    char *file;
    char *repository;
{
    RCSNode *rcsfile;
    char rcs[PATH_MAX];
    int save_really_quiet;

    locate_rcs (file, repository, rcs);
    save_really_quiet = really_quiet;
    really_quiet = 1;
    if ((rcsfile = RCS_parsercsfile (rcs)) == NULL)
	(void) unlink_file (rcs);
    else
	freercsnode (&rcsfile);
    really_quiet = save_really_quiet;
}

/*
 * put the branch back on an rcs file
 */
static void
fixbranch (file, repository, branch)
    char *file;
    char *repository;
    char *branch;
{
    char rcs[PATH_MAX];
    int retcode = 0;

    if (branch != NULL && branch[0] != '\0')
    {
	locate_rcs (file, repository, rcs);
	if ((retcode = RCS_setbranch (rcs, branch)) != 0)
	    error (retcode == -1 ? 1 : 0, retcode == -1 ? errno : 0,
		   "cannot restore branch to %s for %s", branch, rcs);
    }
}

/*
 * do the initial part of a file add for the named file.  if adding
 * with a tag, put the file in the Attic and point the symbolic tag
 * at the committed revision.
 */

static int
checkaddfile (file, repository, tag, srcfiles)
    char *file;
    char *repository;
    char *tag;
    List *srcfiles;
{
    FILE *fp;
    char *cp;
    char rcs[PATH_MAX];
    char fname[PATH_MAX];
    mode_t omask;
    int retcode = 0;
#ifdef DEATH_SUPPORT
    int newfile = 0;
#endif

    if (tag)
    {
	(void) sprintf(rcs, "%s/%s", repository, CVSATTIC);
	omask = umask (2);
	if (mkdir (rcs, 0777) != 0 && errno != EEXIST)
	    error (1, errno, "cannot make directory `%s'", rcs);;
	(void) umask (omask);
	(void) sprintf (rcs, "%s/%s/%s%s", repository, CVSATTIC, file, RCSEXT);
    }
    else
	locate_rcs (file, repository, rcs);

#ifdef DEATH_SUPPORT
    if (isreadable(rcs))
    {
	/* file has existed in the past.  Prepare to resurrect. */
	char oldfile[PATH_MAX];
	char *rev;
	Node *p;
	RCSNode *rcsfile;

	if (tag == NULL)
	{
	    /* we are adding on the trunk, so move the file out of the
	       Attic. */
	    strcpy (oldfile, rcs);
	    sprintf (rcs, "%s/%s%s", repository, file, RCSEXT);
	    
	    if (strcmp (oldfile, rcs) == 0
		|| rename (oldfile, rcs) != 0
		|| isreadable (oldfile)
		|| !isreadable (rcs))
	    {
		error (0, 0, "failed to move `%s' out of the attic.",
		       file);
		return (1);
	    }
	}

	p = findnode (srcfiles, file);
	if (p == NULL)
	{
	    error (0, 0, "could not find parsed rcsfile %s", file);
	    return (1);
	}

	rcsfile = (RCSNode *) p->data;
	rev = RCS_getversion (rcsfile, tag, NULL, 1);
	/* and lock it */
	if (lock_RCS (file, rcs, rev, repository)) {
	    error (0, 0, "cannot lock `%s'.", rcs);
	    free (rev);
	    return (1);
	}

	free (rev);
    } else {
	/* this is the first time we have ever seen this file; create
	   an rcs file.  */
	run_setup ("%s%s -i", Rcsbin, RCS);

	(void) sprintf (fname, "%s/%s%s", CVSADM, file, CVSEXT_LOG);
	/* If the file does not exist, no big deal.  In particular, the
	   server does not (yet at least) create CVSEXT_LOG files.  */
	if (isfile (fname))
	    run_args ("-t%s/%s%s", CVSADM, file, CVSEXT_LOG);

	(void) sprintf (fname, "%s/%s%s", CVSADM, file, CVSEXT_OPT);
	fp = fopen (fname, "r");
	/* If the file does not exist, no big deal.  In particular, the
	   server does not (yet at least) create CVSEXT_OPT files.  */
	if (fp == NULL)
	{
	    if (errno != ENOENT)
		error (1, errno, "cannot open %s", fname);
	}
	else
	{
	    while (fgets (fname, sizeof (fname), fp) != NULL)
	    {
		if ((cp = strrchr (fname, '\n')) != NULL)
		    *cp = '\0';
		if (*fname)
		    run_arg (fname);
	    }
	    (void) fclose (fp);
	}
	run_arg (rcs);
	if ((retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL)) != 0)
	{
	    error (retcode == -1 ? 1 : 0, retcode == -1 ? errno : 0,
		   "could not create %s", rcs);
	    return (1);
	}
	newfile = 1;
    }

    /* when adding a file for the first time, and using a tag, we need
       to create a dead revision on the trunk.  */
    if (tag && newfile)
    {
	char tmp[PATH_MAX];
	
	/* move the new file out of the way. */
	(void) sprintf (fname, "%s/%s%s", CVSADM, CVSPREFIX, file);
	rename_file (file, fname);
	copy_file (DEVNULL, file);
	
	/* commit a dead revision. */
	(void) sprintf (tmp, "-mfile %s was initially added on branch %s.", file, tag);
#ifdef CVSDEA
	{
	    char *new_rev;
	    new_rev = ci_new_rev (NULL, tmp, rcs);
	    if (new_rev == NULL)
		return 1;
	    mark_dead (file, repository, new_rev);
	    free (new_rev);
	}
#else
#ifdef DEATH_STATE
	run_setup ("%s%s -q -f -sdead", Rcsbin, RCS_CI);
#else
	run_setup ("%s%s -q -K", Rcsbin, RCS_CI);
#endif
	run_arg (tmp);
	run_arg (rcs);
	if ((retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL)) != 0)
	{
	    error (retcode == -1 ? 1 : 0, retcode == -1 ? errno : 0,
		   "could not create initial dead revision %s", rcs);
	    return (1);
	}
#endif /* CVSDEA */

	/* put the new file back where it was */
	rename_file (fname, file);
	
	/* and lock it once again. */
	if (lock_RCS (file, rcs, NULL, repository)) {
	    error (0, 0, "cannot lock `%s'.", rcs);
	    return (1);
	}
    }

    if (tag != NULL)
    {
	/* when adding with a tag, we need to stub a branch, if it
	   doesn't already exist.  */
	Node *p;
	RCSNode *rcsfile;

	rcsfile = RCS_parse (file, repository);
	if (rcsfile == NULL)
	{
	    error (0, 0, "could not read %s", rcs);
	    return (1);
	}
	
	if (!RCS_nodeisbranch (tag, rcsfile)) {
	    /* branch does not exist.  Stub it.  */
	    char *head;
	    char *magicrev;
	    
	    head = RCS_getversion (rcsfile, NULL, NULL, 0);
	    magicrev = RCS_magicrev (rcsfile, head);
	    if ((retcode = RCS_settag(rcs, tag, magicrev)) != 0)
	    {
		error (retcode == -1 ? 1 : 0, retcode == -1 ? errno : 0,
		       "could not stub branch %s for %s", tag, rcs);
		return (1);
	    }
	    
	    freercsnode (&rcsfile);
	    
	    /* reparse the file, then add it to our list. */
	    rcsfile = RCS_parse (file, repository);
	    if (rcsfile == NULL)
	    {
		error (0, 0, "could not reparse %s", rcs);
		return (1);
	    }

	    free (head);
	    free (magicrev);
	}
	else
	{
	    /* lock the branch. (stubbed branches need not be locked.)  */
	    if (lock_RCS (file, rcs, NULL, repository)) {
		error (0, 0, "cannot lock `%s'.", rcs);
		return (1);
	    }
	}	    

	/* add (replace) this rcs file to our list */
	p = findnode (srcfiles, file);

	if (p != NULL)
	  freercsnode((RCSNode **) &p->data);

	delnode(p);

	RCS_addnode (file, rcsfile, srcfiles);
    }
#else /* No DEATH_SUPPORT */
    run_setup ("%s%s -i", Rcsbin, RCS);
    run_args ("-t%s/%s%s", CVSADM, file, CVSEXT_LOG);
    (void) sprintf (fname, "%s/%s%s", CVSADM, file, CVSEXT_OPT);
    fp = open_file (fname, "r");
    while (fgets (fname, sizeof (fname), fp) != NULL)
    {
	if ((cp = strrchr (fname, '\n')) != NULL)
	    *cp = '\0';
	if (*fname)
	    run_arg (fname);
    }
    (void) fclose (fp);
    run_arg (rcs);
    if ((retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL)) != 0)
    {
	error (retcode == -1 ? 1 : 0, retcode == -1 ? errno : 0,
	       "could not create %s", rcs);
	return (1);
    }
#endif /* No DEATH_SUPPORT */

    fix_rcs_modes (rcs, file);
    return (0);
}

/*
 * Lock the rcs file ``file''
 */
static int
lockrcsfile (file, repository, rev)
    char *file;
    char *repository;
    char *rev;
{
    char rcs[PATH_MAX];

    locate_rcs (file, repository, rcs);
    if (lock_RCS (file, rcs, rev, repository) != 0)
	return (1);
    else
	return (0);
}

/*
 * Attempt to place a lock on the RCS file; returns 0 if it could and 1 if it
 * couldn't.  If the RCS file currently has a branch as the head, we must
 * move the head back to the trunk before locking the file, and be sure to
 * put the branch back as the head if there are any errors.
 */
static int
lock_RCS (user, rcs, rev, repository)
    char *user;
    char *rcs;
    char *rev;
    char *repository;
{
    RCSNode *rcsfile;
    char *branch = NULL;
    int err = 0;

    /*
     * For a specified, numeric revision of the form "1" or "1.1", (or when
     * no revision is specified ""), definitely move the branch to the trunk
     * before locking the RCS file.
     * 
     * The assumption is that if there is more than one revision on the trunk,
     * the head points to the trunk, not a branch... and as such, it's not
     * necessary to move the head in this case.
     */
    if (rev == NULL || (rev && isdigit (*rev) && numdots (rev) < 2))
    {
	if ((rcsfile = RCS_parsercsfile (rcs)) == NULL)
	{
	    /* invalid rcs file? */
	    err = 1;
	}
	else
	{
	    /* rcsfile is valid */
	    branch = xstrdup (rcsfile->branch);
	    freercsnode (&rcsfile);
	    if (branch != NULL)
	    {
		if (RCS_setbranch (rcs, NULL) != 0)
		{
		    error (0, 0, "cannot change branch to default for %s",
			   rcs);
		    if (branch)
			free (branch);
		    return (1);
		}
	    }
	    err = RCS_lock(rcs, NULL);
	}
    }
    else
    {
	(void) RCS_lock(rcs, rev);
    }

    if (err == 0)
    {
	if (branch)
	{
	    (void) strcpy (sbranch, branch);
	    free (branch);
	}
	else
	    sbranch[0] = '\0';
	return (0);
    }

    /* try to restore the branch if we can on error */
    if (branch != NULL)
	fixbranch (user, repository, branch);

    if (branch)
	free (branch);
    return (1);
}

/*
 * Called when "add"ing files to the RCS respository, as it is necessary to
 * preserve the file modes in the same fashion that RCS does.  This would be
 * automatic except that we are placing the RCS ,v file very far away from
 * the user file, and I can't seem to convince RCS of the location of the
 * user file.  So we munge it here, after the ,v file has been successfully
 * initialized with "rcs -i".
 */
static void
fix_rcs_modes (rcs, user)
    char *rcs;
    char *user;
{
    struct stat sb;

    if (stat (user, &sb) != -1)
	(void) chmod (rcs, (int) sb.st_mode & ~0222);
}

/*
 * free an UPDATE node's data (really nothing to do)
 */
void
update_delproc (p)
    Node *p;
{
    p->data = (char *) NULL;
}

/*
 * Free the commit_info structure in p.
 */
static void
ci_delproc (p)
    Node *p;
{
    struct commit_info *ci;

    ci = (struct commit_info *) p->data;
    if (ci->rev)
	free (ci->rev);
    if (ci->tag)
	free (ci->tag);
    if (ci->options)
	free (ci->options);
    free (ci);
}

/*
 * Free the commit_info structure in p.
 */
static void
masterlist_delproc (p)
    Node *p;
{
    struct master_lists *ml;

    ml = (struct master_lists *) p->data;
    dellist (&ml->ulist);
    dellist (&ml->cilist);
    free (ml);
}

/*
 * Find an RCS file in the repository.
 */
static void
locate_rcs (file, repository, rcs)
    char *file;
    char *repository;
    char *rcs;
{
    (void) sprintf (rcs, "%s/%s%s", repository, file, RCSEXT);
    if (!isreadable (rcs))
    {
	(void) sprintf (rcs, "%s/%s/%s%s", repository, CVSATTIC, file, RCSEXT);
	if (!isreadable (rcs))
	    (void) sprintf (rcs, "%s/%s%s", repository, file, RCSEXT);
    }
}

#ifdef CVSDEA
/* Run RCS_CI and return a malloc'd array containing the numeric
   revision for the new revision.  */
static char *
ci_new_rev (rev, msg, rcs)
    char *rev;
    char *msg;
    char *rcs;
{
    int retcode;
    char *tmpdir;
    RCSNode *rcsnode;

    int retval_alloced;
    int retval_used;
    char *retval;

    tmpdir = getenv ("TMPDIR");
    if (tmpdir == NULL || tmpdir[0] == '\0') 
      tmpdir = "/tmp";

    run_setup ("%s%s -f %s%s", Rcsbin, RCS_CI, rev ? "-r" : "",
	       rev ? rev : ""); 
    run_args ("-m%s",
	      (message == NULL
	       || *message == '\0'
	       || strcmp(message, "\n") == 0) ?
	      "*** empty log message ***\n" : message);
    run_arg (rcs);
    if ((retcode = run_exec (RUN_TTY, RUN_TTY, DEVNULL, RUN_NORMAL))
	!= 0) {
	if (!quiet)
	    error (0, retcode == -1 ? errno : 0,
		   "failed to commit dead revision for `%s'", rcs);
	return NULL;
    }

    rcsnode = RCS_parsercsfile (rcs);
    retval =
      rev == NULL ? RCS_head (rcsnode) : RCS_getbranch (rcsnode, rev, 0);
    freercsnode (&rcsnode);
    return retval;
}

static void
mark_dead (file, repository, new_rev)
    char *file;
    char *repository;
    char *new_rev;
{
    mode_t omask;
    char *deafilename = xmalloc (sizeof (CVSDEA) + strlen (repository)
				 + strlen (file) + 80);
    FILE *deafile;

    /* Make the CVSDEA directory if we need to.  */
    sprintf (deafilename, "%s/%s", repository, CVSDEA);
    omask = umask (2);
    if (mkdir (deafilename, 0777) != 0 && errno != EEXIST)
	error (1, errno, "cannot make directory `%s'", deafilename);
    (void) umask (omask);

    /* Now add NEW_REV to the revisions in the CVSDEA file for this file.  */
    sprintf (deafilename, "%s/%s/%s", repository, CVSDEA, file);
    deafile = open_file (deafilename, "a");
    if (fprintf (deafile, "%s\n", new_rev) < 0)
	error (1, errno, "cannot write %s", deafilename);
    if (fclose (deafile) == EOF)
	error (1, errno, "cannot close %s", deafilename);
    free (deafilename);
}
#endif
