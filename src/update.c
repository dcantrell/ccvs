/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 * 
 * "update" updates the version in the present directory with respect to the RCS
 * repository.  The present version must have been created by "checkout". The
 * user can keep up-to-date by calling "update" whenever he feels like it.
 * 
 * The present version can be committed by "commit", but this keeps the version
 * in tact.
 * 
 * Arguments following the options are taken to be file names to be updated,
 * rather than updating the entire directory.
 * 
 * Modified or non-existent RCS files are checked out and reported as U
 * <user_file>
 * 
 * Modified user files are reported as M <user_file>.  If both the RCS file and
 * the user file have been modified, the user file is replaced by the result
 * of rcsmerge, and a backup file is written for the user in .#file.version.
 * If this throws up irreconcilable differences, the file is reported as C
 * <user_file>, and as M <user_file> otherwise.
 * 
 * Files added but not yet committed are reported as A <user_file>. Files
 * removed but not yet committed are reported as R <user_file>.
 * 
 * If the current directory contains subdirectories that hold concurrent
 * versions, these are updated too.  If the -d option was specified, new
 * directories added to the repository are automatically created and updated
 * as well.
 */

#include "cvs.h"
#include "savecwd.h"
#ifdef SERVER_SUPPORT
#include "md5.h"
#endif
#include "watch.h"
#include "fileattr.h"
#include "edit.h"
#include "getline.h"

static int checkout_file PROTO ((struct file_info *finfo, Vers_TS *vers_ts,
				 int adding));
#ifdef SERVER_SUPPORT
static int patch_file PROTO ((struct file_info *finfo,
			      Vers_TS *vers_ts, 
			      int *docheckout, struct stat *file_info,
			      unsigned char *checksum));
static void patch_file_write PROTO ((void *, const char *, size_t));
#endif
static int merge_file PROTO ((struct file_info *finfo, Vers_TS *vers));
static int scratch_file PROTO((struct file_info *finfo));
static Dtype update_dirent_proc PROTO ((void *callerdat, char *dir,
					char *repository, char *update_dir,
					List *entries));
static int update_dirleave_proc PROTO ((void *callerdat, char *dir,
					int err, char *update_dir,
					List *entries));
static int update_fileproc PROTO ((void *callerdat, struct file_info *));
static int update_filesdone_proc PROTO ((void *callerdat, int err,
					 char *repository, char *update_dir,
					 List *entries));
static int write_letter PROTO((char *file, int letter, char *update_dir));
#ifdef SERVER_SUPPORT
static void join_file PROTO ((struct file_info *finfo, Vers_TS *vers_ts));
#else
static void join_file PROTO ((struct file_info *finfo, Vers_TS *vers_ts));
#endif

static char *options = NULL;
static char *tag = NULL;
static char *date = NULL;
/* This is a bit of a kludge.  We call WriteTag at the beginning
   before we know whether nonbranch is set or not.  And then at the
   end, once we have the right value for nonbranch, we call WriteTag
   again.  I don't know whether the first call is necessary or not.
   rewrite_tag is nonzero if we are going to have to make that second
   call.  */
static int rewrite_tag;
static int nonbranch;

static char *join_rev1, *date_rev1;
static char *join_rev2, *date_rev2;
static int aflag = 0;
static int force_tag_match = 1;
static int update_build_dirs = 0;
static int update_prune_dirs = 0;
static int pipeout = 0;
#ifdef SERVER_SUPPORT
static int patches = 0;
static int rcs_diff_patches = 0;
#endif
static List *ignlist = (List *) NULL;
static time_t last_register_time;
static const char *const update_usage[] =
{
    "Usage: %s %s [-APdflRp] [-k kopt] [-r rev|-D date] [-j rev]\n",
    "    [-I ign] [-W spec] [files...]\n",
    "\t-A\tReset any sticky tags/date/kopts.\n",
    "\t-P\tPrune empty directories.\n",
    "\t-d\tBuild directories, like checkout does.\n",
    "\t-f\tForce a head revision match if tag/date not found.\n",
    "\t-l\tLocal directory only, no recursion.\n",
    "\t-R\tProcess directories recursively.\n",
    "\t-p\tSend updates to standard output (avoids stickiness).\n",
    "\t-k kopt\tUse RCS kopt -k option on checkout.\n",
    "\t-r rev\tUpdate using specified revision/tag (is sticky).\n",
    "\t-D date\tSet date to update from (is sticky).\n",
    "\t-j rev\tMerge in changes made between current revision and rev.\n",
    "\t-I ign\tMore files to ignore (! to reset).\n",
    "\t-W spec\tWrappers specification line.\n",
    "(Specify the --help global option for a list of other help options)\n",
    NULL
};

/*
 * update is the argv,argc based front end for arg parsing
 */
int
update (argc, argv)
    int argc;
    char **argv;
{
    int c, err;
    int local = 0;			/* recursive by default */
    int which;				/* where to look for files and dirs */

    if (argc == -1)
	usage (update_usage);

    ign_setup ();
    wrap_setup ();

    /* parse the args */
    optind = 0;
    while ((c = getopt (argc, argv, "+ApPflRQqduk:r:D:j:I:W:")) != -1)
    {
	switch (c)
	{
	    case 'A':
		aflag = 1;
		break;
	    case 'I':
		ign_add (optarg, 0);
		break;
	    case 'W':
		wrap_add (optarg, 0);
		break;
	    case 'k':
		if (options)
		    free (options);
		options = RCS_check_kflag (optarg);
		break;
	    case 'l':
		local = 1;
		break;
	    case 'R':
		local = 0;
		break;
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
		update_build_dirs = 1;
		break;
	    case 'f':
		force_tag_match = 0;
		break;
	    case 'r':
		tag = optarg;
		break;
	    case 'D':
		date = Make_Date (optarg);
		break;
	    case 'P':
		update_prune_dirs = 1;
		break;
	    case 'p':
		pipeout = 1;
		noexec = 1;		/* so no locks will be created */
		break;
	    case 'j':
		if (join_rev2)
		    error (1, 0, "only two -j options can be specified");
		if (join_rev1)
		    join_rev2 = optarg;
		else
		    join_rev1 = optarg;
		break;
	    case 'u':
#ifdef SERVER_SUPPORT
		if (server_active)
		{
		    patches = 1;
		    rcs_diff_patches = server_use_rcs_diff ();
		}
		else
#endif
		    usage (update_usage);
		break;
	    case '?':
	    default:
		usage (update_usage);
		break;
	}
    }
    argc -= optind;
    argv += optind;

#ifdef CLIENT_SUPPORT
    if (client_active) 
    {
	int pass;

	/* The first pass does the regular update.  If we receive at least
	   one patch which failed, we do a second pass and just fetch
	   those files whose patches failed.  */
	pass = 1;
	do
	{
	    int status;

	    start_server ();

	    if (local)
		send_arg("-l");
	    if (update_build_dirs)
		send_arg("-d");
	    if (pipeout)
		send_arg("-p");
	    if (!force_tag_match)
		send_arg("-f");
	    if (aflag)
		send_arg("-A");
	    if (update_prune_dirs)
		send_arg("-P");
	    client_prune_dirs = update_prune_dirs;
	    option_with_arg ("-r", tag);
	    if (options && options[0] != '\0')
		send_arg (options);
	    if (date)
		client_senddate (date);
	    if (join_rev1)
		option_with_arg ("-j", join_rev1);
	    if (join_rev2)
		option_with_arg ("-j", join_rev2);
	    wrap_send ();

	    /* If the server supports the command "update-patches", that means
	       that it knows how to handle the -u argument to update, which
	       means to send patches instead of complete files.

	       We don't send -u if failed_patches != NULL, so that the
	       server doesn't try to send patches which will just fail
	       again.  At least currently, the client also clobbers the
	       file and tells the server it is lost, which also will get
	       a full file instead of a patch, but it seems clean to omit
	       -u.  */
	    if (failed_patches == NULL)
	    {
		if (supported_request ("update-patches"))
		    send_arg ("-u");
	    }

	    if (failed_patches == NULL)
	    {
		send_file_names (argc, argv, SEND_EXPAND_WILD);
		/* If noexec, probably could be setting SEND_NO_CONTENTS.
		   Same caveats as for "cvs status" apply.  */
		send_files (argc, argv, local, aflag,
			    update_build_dirs ? SEND_BUILD_DIRS : 0);
	    }
	    else
	    {
		int i;

		(void) printf ("%s client: refetching unpatchable files\n",
			       program_name);

		if (toplevel_wd != NULL
		    && CVS_CHDIR (toplevel_wd) < 0)
		{
		    error (1, errno, "could not chdir to %s", toplevel_wd);
		}

		for (i = 0; i < failed_patches_count; i++)
		    (void) unlink_file (failed_patches[i]);
		send_file_names (failed_patches_count, failed_patches, 0);
		send_files (failed_patches_count, failed_patches, local,
			    aflag, update_build_dirs ? SEND_BUILD_DIRS : 0);
	    }

	    failed_patches = NULL;
	    failed_patches_count = 0;

	    send_to_server ("update\012", 0);

	    status = get_responses_and_close ();

	    /* If there are any conflicts, the server will return a
               non-zero exit status.  If any patches failed, we still
               want to run the update again.  We use a pass count to
               avoid an endless loop.  */

	    /* Notes: (1) assuming that status != 0 implies a
	       potential conflict is the best we can cleanly do given
	       the current protocol.  I suppose that trying to
	       re-fetch in cases where there was a more serious error
	       is probably more or less harmless, but it isn't really
	       ideal.  (2) it would be nice to have a testsuite case for the
	       conflict-and-patch-failed case.  */

	    if (status != 0
		&& (failed_patches == NULL || pass > 1))
	    {
		return status;
	    }

	    ++pass;
	} while (failed_patches != NULL);

	return 0;
    }
#endif

    if (tag != NULL)
	tag_check_valid (tag, argc, argv, local, aflag, "");
    if (join_rev1 != NULL)
        tag_check_valid_join (join_rev1, argc, argv, local, aflag, "");
    if (join_rev2 != NULL)
        tag_check_valid_join (join_rev2, argc, argv, local, aflag, "");

    /*
     * If we are updating the entire directory (for real) and building dirs
     * as we go, we make sure there is no static entries file and write the
     * tag file as appropriate
     */
    if (argc <= 0 && !pipeout)
    {
	if (update_build_dirs)
	{
	    if (unlink_file (CVSADM_ENTSTAT) < 0 && ! existence_error (errno))
		error (1, errno, "cannot remove file %s", CVSADM_ENTSTAT);
#ifdef SERVER_SUPPORT
	    if (server_active)
		server_clear_entstat (".", Name_Repository (NULL, NULL));
#endif
	}

	/* keep the CVS/Tag file current with the specified arguments */
	if (aflag || tag || date)
	{
	    WriteTag ((char *) NULL, tag, date, 0,
		      ".", Name_Repository (NULL, NULL));
	    rewrite_tag = 1;
	    nonbranch = 0;
	}
    }

    /* look for files/dirs locally and in the repository */
    which = W_LOCAL | W_REPOS;

    /* look in the attic too if a tag or date is specified */
    if (tag != NULL || date != NULL || joining())
	which |= W_ATTIC;

    /* call the command line interface */
    err = do_update (argc, argv, options, tag, date, force_tag_match,
		     local, update_build_dirs, aflag, update_prune_dirs,
		     pipeout, which, join_rev1, join_rev2, (char *) NULL);

    /* free the space Make_Date allocated if necessary */
    if (date != NULL)
	free (date);

    return (err);
}

/*
 * Command line interface to update (used by checkout)
 */
int
do_update (argc, argv, xoptions, xtag, xdate, xforce, local, xbuild, xaflag,
	   xprune, xpipeout, which, xjoin_rev1, xjoin_rev2, preload_update_dir)
    int argc;
    char **argv;
    char *xoptions;
    char *xtag;
    char *xdate;
    int xforce;
    int local;
    int xbuild;
    int xaflag;
    int xprune;
    int xpipeout;
    int which;
    char *xjoin_rev1;
    char *xjoin_rev2;
    char *preload_update_dir;
{
    int err = 0;
    char *cp;

    /* fill in the statics */
    options = xoptions;
    tag = xtag;
    date = xdate;
    force_tag_match = xforce;
    update_build_dirs = xbuild;
    aflag = xaflag;
    update_prune_dirs = xprune;
    pipeout = xpipeout;

    /* setup the join support */
    join_rev1 = xjoin_rev1;
    join_rev2 = xjoin_rev2;
    if (join_rev1 && (cp = strchr (join_rev1, ':')) != NULL)
    {
	*cp++ = '\0';
	date_rev1 = Make_Date (cp);
    }
    else
	date_rev1 = (char *) NULL;
    if (join_rev2 && (cp = strchr (join_rev2, ':')) != NULL)
    {
	*cp++ = '\0';
	date_rev2 = Make_Date (cp);
    }
    else
	date_rev2 = (char *) NULL;

    /* call the recursion processor */
    err = start_recursion (update_fileproc, update_filesdone_proc,
			   update_dirent_proc, update_dirleave_proc, NULL,
			   argc, argv, local, which, aflag, 1,
			   preload_update_dir, 1);

    /* see if we need to sleep before returning */
    if (last_register_time)
    {
	time_t now;

	(void) time (&now);
	if (now == last_register_time)
	    sleep (1);			/* to avoid time-stamp races */
    }

    return (err);
}

/*
 * This is the callback proc for update.  It is called for each file in each
 * directory by the recursion code.  The current directory is the local
 * instantiation.  file is the file name we are to operate on. update_dir is
 * set to the path relative to where we started (for pretty printing).
 * repository is the repository. entries and srcfiles are the pre-parsed
 * entries and source control files.
 * 
 * This routine decides what needs to be done for each file and does the
 * appropriate magic for checkout
 */
static int
update_fileproc (callerdat, finfo)
    void *callerdat;
    struct file_info *finfo;
{
    int retval;
    Ctype status;
    Vers_TS *vers;
    int resurrecting;

    resurrecting = 0;

    status = Classify_File (finfo, tag, date, options, force_tag_match,
			    aflag, &vers, pipeout);

    /* Keep track of whether TAG is a branch tag.
       Note that if it is a branch tag in some files and a nonbranch tag
       in others, treat it as a nonbranch tag.  It is possible that case
       should elicit a warning or an error.  */
    if (rewrite_tag
	&& tag != NULL
	&& finfo->rcs != NULL)
    {
	char *rev = RCS_getversion (finfo->rcs, tag, NULL, 1, NULL);
	if (rev != NULL
	    && !RCS_nodeisbranch (finfo->rcs, tag))
	    nonbranch = 1;
	if (rev != NULL)
	    free (rev);
    }

    if (pipeout)
    {
	/*
	 * We just return success without doing anything if any of the really
	 * funky cases occur
	 * 
	 * If there is still a valid RCS file, do a regular checkout type
	 * operation
	 */
	switch (status)
	{
	    case T_UNKNOWN:		/* unknown file was explicitly asked
					 * about */
	    case T_REMOVE_ENTRY:	/* needs to be un-registered */
	    case T_ADDED:		/* added but not committed */
		retval = 0;
		break;
	    case T_CONFLICT:		/* old punt-type errors */
		retval = 1;
		break;
	    case T_UPTODATE:		/* file was already up-to-date */
	    case T_NEEDS_MERGE:		/* needs merging */
	    case T_MODIFIED:		/* locally modified */
	    case T_REMOVED:		/* removed but not committed */
	    case T_CHECKOUT:		/* needs checkout */
#ifdef SERVER_SUPPORT
	    case T_PATCH:		/* needs patch */
#endif
		retval = checkout_file (finfo, vers, 0);
		break;

	    default:			/* can't ever happen :-) */
		error (0, 0,
		       "unknown file status %d for file %s", status, finfo->file);
		retval = 0;
		break;
	}
    }
    else
    {
	switch (status)
	{
	    case T_UNKNOWN:		/* unknown file was explicitly asked
					 * about */
	    case T_UPTODATE:		/* file was already up-to-date */
		retval = 0;
		break;
	    case T_CONFLICT:		/* old punt-type errors */
		retval = 1;
		(void) write_letter (finfo->file, 'C', finfo->update_dir);
		break;
	    case T_NEEDS_MERGE:		/* needs merging */
		if (noexec)
		{
		    retval = 1;
		    (void) write_letter (finfo->file, 'C', finfo->update_dir);
		}
		else
		{
		    retval = merge_file (finfo, vers);
		}
		break;
	    case T_MODIFIED:		/* locally modified */
		retval = 0;
		if (vers->ts_conflict)
		{
		    char *filestamp;
		    int retcode;

		    /*
		     * If the timestamp has changed and no conflict indicators
		     * are found, it isn't a 'C' any more.
		     */
#ifdef SERVER_SUPPORT
		    if (server_active)
			retcode = vers->ts_conflict[0] != '=';
		    else {
			filestamp = time_stamp (finfo->file);
			retcode = strcmp (vers->ts_conflict, filestamp);
			free (filestamp);
		    }
#else
		    filestamp = time_stamp (finfo->file);
		    retcode = strcmp (vers->ts_conflict, filestamp);
		    free (filestamp);
#endif

		    if (retcode)
		    {
			/* The timestamps differ.  But if there are conflict
			   markers print 'C' anyway.  */
			retcode = !file_has_markers (finfo);
		    }

		    if (!retcode)
		    {
			(void) write_letter (finfo->file, 'C', finfo->update_dir);
			retval = 1;
		    }
		    else
		    {
			/* Reregister to clear conflict flag. */
			Register (finfo->entries, finfo->file, vers->vn_rcs, vers->ts_rcs,
				  vers->options, vers->tag,
				  vers->date, (char *)0);
		    }
		}
		if (!retval)
		    retval = write_letter (finfo->file, 'M', finfo->update_dir);
		break;
#ifdef SERVER_SUPPORT
	    case T_PATCH:		/* needs patch */
		if (patches)
		{
		    int docheckout;
		    struct stat file_info;
		    unsigned char checksum[16];

		    retval = patch_file (finfo,
					 vers, &docheckout,
					 &file_info, checksum);
		    if (! docheckout)
		    {
		        if (server_active && retval == 0)
			    server_updated (finfo, vers,
					    (rcs_diff_patches
					     ? SERVER_RCS_DIFF
					     : SERVER_PATCHED),
					    &file_info, checksum);
			break;
		    }
		}
		/* Fall through.  */
		/* If we're not running as a server, just check the
		   file out.  It's simpler and faster than starting up
		   two new processes (diff and patch).  */
		/* Fall through.  */
#endif
	    case T_CHECKOUT:		/* needs checkout */
		retval = checkout_file (finfo, vers, 0);
#ifdef SERVER_SUPPORT
		if (server_active && retval == 0)
		    server_updated (finfo, vers,
				    SERVER_UPDATED, (struct stat *) NULL,
				    (unsigned char *) NULL);
#endif
		break;
	    case T_ADDED:		/* added but not committed */
		retval = write_letter (finfo->file, 'A', finfo->update_dir);
		break;
	    case T_REMOVED:		/* removed but not committed */
		retval = write_letter (finfo->file, 'R', finfo->update_dir);
		break;
	    case T_REMOVE_ENTRY:	/* needs to be un-registered */
		retval = scratch_file (finfo);
#ifdef SERVER_SUPPORT
		if (server_active && retval == 0)
		{
		    if (vers->ts_user == NULL)
			server_scratch_entry_only ();
		    server_updated (finfo, vers,
				    SERVER_UPDATED, (struct stat *) NULL,
				    (unsigned char *) NULL);
		}
#endif
		break;
	    default:			/* can't ever happen :-) */
		error (0, 0,
		       "unknown file status %d for file %s", status, finfo->file);
		retval = 0;
		break;
	}
    }

    /* only try to join if things have gone well thus far */
    if (retval == 0 && join_rev1)
	join_file (finfo, vers);

    /* if this directory has an ignore list, add this file to it */
    if (ignlist)
    {
	Node *p;

	p = getnode ();
	p->type = FILES;
	p->key = xstrdup (finfo->file);
	if (addnode (ignlist, p) != 0)
	    freenode (p);
    }

    freevers_ts (&vers);
    return (retval);
}

static void update_ignproc PROTO ((char *, char *));

static void
update_ignproc (file, dir)
    char *file;
    char *dir;
{
    (void) write_letter (file, '?', dir);
}

/* ARGSUSED */
static int
update_filesdone_proc (callerdat, err, repository, update_dir, entries)
    void *callerdat;
    int err;
    char *repository;
    char *update_dir;
    List *entries;
{
    if (rewrite_tag)
    {
	WriteTag (NULL, tag, date, nonbranch, update_dir, repository);
	rewrite_tag = 0;
    }

    /* if this directory has an ignore list, process it then free it */
    if (ignlist)
    {
	ignore_files (ignlist, entries, update_dir, update_ignproc);
	dellist (&ignlist);
    }

    /* Clean up CVS admin dirs if we are export */
    if (strcmp (command_name, "export") == 0)
    {
	/* I'm not sure the existence_error is actually possible (except
	   in cases where we really should print a message), but since
	   this code used to ignore all errors, I'll play it safe.  */
	if (unlink_file_dir (CVSADM) < 0 && !existence_error (errno))
	    error (0, errno, "cannot remove %s directory", CVSADM);
    }
#ifdef SERVER_SUPPORT
    else if (!server_active && !pipeout)
#else
    else if (!pipeout)
#endif /* SERVER_SUPPORT */
    {
        /* If there is no CVS/Root file, add one */
        if (!isfile (CVSADM_ROOT))
	    Create_Root ((char *) NULL, CVSroot_original);
    }

    return (err);
}

/*
 * update_dirent_proc () is called back by the recursion processor before a
 * sub-directory is processed for update.  In this case, update_dirent proc
 * will probably create the directory unless -d isn't specified and this is a
 * new directory.  A return code of 0 indicates the directory should be
 * processed by the recursion code.  A return of non-zero indicates the
 * recursion code should skip this directory.
 */
static Dtype
update_dirent_proc (callerdat, dir, repository, update_dir, entries)
    void *callerdat;
    char *dir;
    char *repository;
    char *update_dir;
    List *entries;
{
    if (ignore_directory (update_dir))
    {
	/* print the warm fuzzy message */
	if (!quiet)
	  error (0, 0, "Ignoring %s", update_dir);
        return R_SKIP_ALL;
    }

    if (!isdir (dir))
    {
	/* if we aren't building dirs, blow it off */
	if (!update_build_dirs)
	    return (R_SKIP_ALL);

	if (noexec)
	{
	    /* ignore the missing dir if -n is specified */
	    error (0, 0, "New directory `%s' -- ignored", update_dir);
	    return (R_SKIP_ALL);
	}
	else
	{
	    /* otherwise, create the dir and appropriate adm files */
	    make_directory (dir);
	    Create_Admin (dir, update_dir, repository, tag, date,
			  /* This is a guess.  We will rewrite it later
			     via WriteTag.  */
			  0,
			  0);
	    rewrite_tag = 1;
	    nonbranch = 0;
	    Subdir_Register (entries, (char *) NULL, dir);
	}
    }
    /* Do we need to check noexec here? */
    else if (!pipeout)
    {
	char *cvsadmdir;

	/* The directory exists.  Check to see if it has a CVS
	   subdirectory.  */

	cvsadmdir = xmalloc (strlen (dir) + 80);
	strcpy (cvsadmdir, dir);
	strcat (cvsadmdir, "/");
	strcat (cvsadmdir, CVSADM);

	if (!isdir (cvsadmdir))
	{
	    /* We cannot successfully recurse into a directory without a CVS
	       subdirectory.  Generally we will have already printed
	       "? foo".  */
	    free (cvsadmdir);
	    return R_SKIP_ALL;
	}
	free (cvsadmdir);
    }

    /*
     * If we are building dirs and not going to stdout, we make sure there is
     * no static entries file and write the tag file as appropriate
     */
    if (!pipeout)
    {
	if (update_build_dirs)
	{
	    char *tmp;

	    tmp = xmalloc (strlen (dir) + sizeof (CVSADM_ENTSTAT) + 10);
	    (void) sprintf (tmp, "%s/%s", dir, CVSADM_ENTSTAT);
	    if (unlink_file (tmp) < 0 && ! existence_error (errno))
		error (1, errno, "cannot remove file %s", tmp);
#ifdef SERVER_SUPPORT
	    if (server_active)
		server_clear_entstat (update_dir, repository);
#endif
	    free (tmp);
	}

	/* keep the CVS/Tag file current with the specified arguments */
	if (aflag || tag || date)
	{
	    WriteTag (dir, tag, date, 0, update_dir, repository);
	    rewrite_tag = 1;
	    nonbranch = 0;
	}

	/* initialize the ignore list for this directory */
	ignlist = getlist ();
    }

    /* print the warm fuzzy message */
    if (!quiet)
	error (0, 0, "Updating %s", update_dir);

    return (R_PROCESS);
}

/*
 * update_dirleave_proc () is called back by the recursion code upon leaving
 * a directory.  It will prune empty directories if needed and will execute
 * any appropriate update programs.
 */
/* ARGSUSED */
static int
update_dirleave_proc (callerdat, dir, err, update_dir, entries)
    void *callerdat;
    char *dir;
    int err;
    char *update_dir;
    List *entries;
{
    FILE *fp;

    /* run the update_prog if there is one */
    /* FIXME: should be checking for errors from CVS_FOPEN and printing
       them if not existence_error.  */
    if (err == 0 && !pipeout && !noexec &&
	(fp = CVS_FOPEN (CVSADM_UPROG, "r")) != NULL)
    {
	char *cp;
	char *repository;
	char *line = NULL;
	size_t line_allocated = 0;

	repository = Name_Repository ((char *) NULL, update_dir);
	if (getline (&line, &line_allocated, fp) >= 0)
	{
	    if ((cp = strrchr (line, '\n')) != NULL)
		*cp = '\0';
	    run_setup ("%s %s", line, repository);
	    cvs_output (program_name, 0);
	    cvs_output (" ", 1);
	    cvs_output (command_name, 0);
	    cvs_output (": Executing '", 0);
	    run_print (stdout);
	    cvs_output ("'\n", 0);
	    (void) run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL);
	}
	else if (ferror (fp))
	    error (0, errno, "cannot read %s", CVSADM_UPROG);
	else
	    error (0, 0, "unexpected end of file on %s", CVSADM_UPROG);

	if (fclose (fp) < 0)
	    error (0, errno, "cannot close %s", CVSADM_UPROG);
	if (line != NULL)
	    free (line);
	free (repository);
    }

    if (strchr (dir, '/') == NULL)
    {
	/* FIXME: chdir ("..") loses with symlinks.  */
	/* Prune empty dirs on the way out - if necessary */
	(void) CVS_CHDIR ("..");
	if (update_prune_dirs && isemptydir (dir, 0))
	{
	    /* I'm not sure the existence_error is actually possible (except
	       in cases where we really should print a message), but since
	       this code used to ignore all errors, I'll play it safe.	*/
	    if (unlink_file_dir (dir) < 0 && !existence_error (errno))
		error (0, errno, "cannot remove %s directory", dir);
	    Subdir_Deregister (entries, (char *) NULL, dir);
	}
    }

    return (err);
}

static int isremoved PROTO ((Node *, void *));

/* Returns 1 if the file indicated by node has been removed.  */
static int
isremoved (node, closure)
    Node *node;
    void *closure;
{
    Entnode *entdata = (Entnode*) node->data;

    /* If the first character of the version is a '-', the file has been
       removed. */
    return (entdata->version && entdata->version[0] == '-') ? 1 : 0;
}

/* Returns 1 if the argument directory is completely empty, other than the
   existence of the CVS directory entry.  Zero otherwise.  If MIGHT_NOT_EXIST
   and the directory doesn't exist, then just return 0.  */
int
isemptydir (dir, might_not_exist)
    char *dir;
    int might_not_exist;
{
    DIR *dirp;
    struct dirent *dp;

    if ((dirp = CVS_OPENDIR (dir)) == NULL)
    {
	if (might_not_exist && existence_error (errno))
	    return 0;
	error (0, errno, "cannot open directory %s for empty check", dir);
	return (0);
    }
    errno = 0;
    while ((dp = readdir (dirp)) != NULL)
    {
	if (strcmp (dp->d_name, ".") != 0
	    && strcmp (dp->d_name, "..") != 0)
	{
	    if (strcmp (dp->d_name, CVSADM) != 0)
	    {
		/* An entry other than the CVS directory.  The directory
		   is certainly not empty. */
		(void) closedir (dirp);
		return (0);
	    }
	    else
	    {
		/* The CVS directory entry.  We don't have to worry about
		   this unless the Entries file indicates that files have
		   been removed, but not committed, in this directory.
		   (Removing the directory would prevent people from
		   comitting the fact that they removed the files!) */
		List *l;
		int files_removed;
		struct saved_cwd cwd;

		if (save_cwd (&cwd))
		    error_exit ();

		if (CVS_CHDIR (dir) < 0)
		    error (1, errno, "cannot change directory to %s", dir);
		l = Entries_Open (0);
		files_removed = walklist (l, isremoved, 0);
		Entries_Close (l);

		if (restore_cwd (&cwd, NULL))
		    error_exit ();
		free_cwd (&cwd);

		if (files_removed != 0)
		{
		    /* There are files that have been removed, but not
		       committed!  Do not consider the directory empty. */
		    (void) closedir (dirp);
		    return (0);
		}
	    }
	}
	errno = 0;
    }
    if (errno != 0)
    {
	error (0, errno, "cannot read directory %s", dir);
	(void) closedir (dirp);
	return (0);
    }
    (void) closedir (dirp);
    return (1);
}

/*
 * scratch the Entries file entry associated with a file
 */
static int
scratch_file (finfo)
    struct file_info *finfo;
{
    history_write ('W', finfo->update_dir, "", finfo->file, finfo->repository);
    Scratch_Entry (finfo->entries, finfo->file);
    if (unlink_file (finfo->file) < 0 && ! existence_error (errno))
	error (0, errno, "unable to remove %s", finfo->fullname);
    return (0);
}

/*
 * Check out a file.
 */
static int
checkout_file (finfo, vers_ts, adding)
    struct file_info *finfo;
    Vers_TS *vers_ts;
    int adding;
{
    char *backup;
    int set_time, retval = 0;
    int retcode = 0;
    int status;
    int file_is_dead;

    /* don't screw with backup files if we're going to stdout */
    if (!pipeout)
    {
	backup = xmalloc (strlen (finfo->file)
			  + sizeof (CVSADM)
			  + sizeof (CVSPREFIX)
			  + 10);
	(void) sprintf (backup, "%s/%s%s", CVSADM, CVSPREFIX, finfo->file);
	if (isfile (finfo->file))
	    rename_file (finfo->file, backup);
	else
	    /* If -f/-t wrappers are being used to wrap up a directory,
	       then backup might be a directory instead of just a file.  */
	    if (unlink_file_dir (backup) < 0)
	    {
		/* Not sure if the existence_error check is needed here.  */
		if (!existence_error (errno))
		    /* FIXME: should include update_dir in message.  */
		    error (0, errno, "error removing %s", backup);
	    }
    }

    file_is_dead = RCS_isdead (vers_ts->srcfile, vers_ts->vn_rcs);

    if (!file_is_dead)
    {
	/*
	 * if we are checking out to stdout, print a nice message to
	 * stderr, and add the -p flag to the command */
	if (pipeout)
	{
	    if (!quiet)
	    {
		cvs_outerr ("\
===================================================================\n\
Checking out ", 0);
		cvs_outerr (finfo->fullname, 0);
		cvs_outerr ("\n\
RCS:  ", 0);
		cvs_outerr (vers_ts->srcfile->path, 0);
		cvs_outerr ("\n\
VERS: ", 0);
		cvs_outerr (vers_ts->vn_rcs, 0);
		cvs_outerr ("\n***************\n", 0);
	    }
	}

	status = RCS_checkout (vers_ts->srcfile,
			       pipeout ? NULL : finfo->file,
			       vers_ts->vn_rcs, vers_ts->vn_tag,
			       vers_ts->options, RUN_TTY,
			       (RCSCHECKOUTPROC) NULL, (void *) NULL);
    }
    if (file_is_dead || status == 0)
    {
	if (!pipeout)
	{
	    Vers_TS *xvers_ts;

	    if (cvswrite
		&& !file_is_dead
		&& !fileattr_get (finfo->file, "_watched"))
		xchmod (finfo->file, 1);

	    {
		/* A newly checked out file is never under the spell
		   of "cvs edit".  If we think we were editing it
		   from a previous life, clean up.  Would be better to
		   check for same the working directory instead of
		   same user, but that is hairy.  */

		struct addremove_args args;

		editor_set (finfo->file, getcaller (), NULL);

		memset (&args, 0, sizeof args);
		args.remove_temp = 1;
		watch_modify_watchers (finfo->file, &args);
	    }

	    /* set the time from the RCS file iff it was unknown before */
	    set_time =
		(!noexec
		 && (vers_ts->vn_user == NULL ||
		     strncmp (vers_ts->ts_rcs, "Initial", 7) == 0));

	    wrap_fromcvs_process_file (finfo->file);

	    xvers_ts = Version_TS (finfo, options, tag, date, 
				   force_tag_match, set_time);
	    if (strcmp (xvers_ts->options, "-V4") == 0)
		xvers_ts->options[0] = '\0';

	    (void) time (&last_register_time);

	    if (file_is_dead)
	    {
		if (xvers_ts->vn_user != NULL)
		{
		    error (0, 0,
			   "warning: %s is not (any longer) pertinent",
			   finfo->fullname);
		}
		Scratch_Entry (finfo->entries, finfo->file);
#ifdef SERVER_SUPPORT
		if (server_active && xvers_ts->ts_user == NULL)
		    server_scratch_entry_only ();
#endif
		/* FIXME: Rather than always unlink'ing, and ignoring the
		   existence_error, we should do the unlink only if
		   vers_ts->ts_user is non-NULL.  Then there would be no
		   need to ignore an existence_error (for example, if the
		   user removes the file while we are running).  */
		if (unlink_file (finfo->file) < 0 && ! existence_error (errno))
		{
		    error (0, errno, "cannot remove %s", finfo->fullname);
		}
	    }
	    else
		Register (finfo->entries, finfo->file,
			  adding ? "0" : xvers_ts->vn_rcs,
			  xvers_ts->ts_user, xvers_ts->options,
			  xvers_ts->tag, xvers_ts->date,
			  (char *)0); /* Clear conflict flag on fresh checkout */

	    /* fix up the vers structure, in case it is used by join */
	    if (join_rev1)
	    {
		if (vers_ts->vn_user != NULL)
		    free (vers_ts->vn_user);
		if (vers_ts->vn_rcs != NULL)
		    free (vers_ts->vn_rcs);
		vers_ts->vn_user = xstrdup (xvers_ts->vn_rcs);
		vers_ts->vn_rcs = xstrdup (xvers_ts->vn_rcs);
	    }

	    /* If this is really Update and not Checkout, recode history */
	    if (strcmp (command_name, "update") == 0)
		history_write ('U', finfo->update_dir, xvers_ts->vn_rcs, finfo->file,
			       finfo->repository);

	    freevers_ts (&xvers_ts);

	    if (!really_quiet && !file_is_dead)
	    {
		write_letter (finfo->file, 'U', finfo->update_dir);
	    }
	}
    }
    else
    {
	int old_errno = errno;		/* save errno value over the rename */

	if (!pipeout && isfile (backup))
	    rename_file (backup, finfo->file);

	error (retcode == -1 ? 1 : 0, retcode == -1 ? old_errno : 0,
	       "could not check out %s", finfo->fullname);

	retval = retcode;
    }

    if (!pipeout)
    {
	/* If -f/-t wrappers are being used to wrap up a directory,
	   then backup might be a directory instead of just a file.  */
	if (unlink_file_dir (backup) < 0)
	{
	    /* Not sure if the existence_error check is needed here.  */
	    if (!existence_error (errno))
		/* FIXME: should include update_dir in message.  */
		error (0, errno, "error removing %s", backup);
	}
	free (backup);
    }

    return (retval);
}

#ifdef SERVER_SUPPORT

/* This structure is used to pass information between patch_file and
   patch_file_write.  */

struct patch_file_data
{
    /* File name, for error messages.  */
    const char *filename;
    /* File to which to write.  */
    FILE *fp;
    /* Whether to compute the MD5 checksum.  */
    int compute_checksum;
    /* Data structure for computing the MD5 checksum.  */
    struct MD5Context context;
    /* Set if the file has a final newline.  */
    int final_nl;
};

/* Patch a file.  Runs diff.  This is only done when running as the
 * server.  The hope is that the diff will be smaller than the file
 * itself.
 */
static int
patch_file (finfo, vers_ts, docheckout, file_info, checksum)
    struct file_info *finfo;
    Vers_TS *vers_ts;
    int *docheckout;
    struct stat *file_info;
    unsigned char *checksum;
{
    char *backup;
    char *file1;
    char *file2;
    int retval = 0;
    int retcode = 0;
    int fail;
    FILE *e;
    struct patch_file_data data;

    *docheckout = 0;

    if (noexec || pipeout || joining ())
    {
	*docheckout = 1;
	return 0;
    }

    /* If this file has been marked as being binary, then never send a
       patch.  */
    if (strcmp (vers_ts->options, "-kb") == 0)
    {
	*docheckout = 1;
	return 0;
    }

    /* First check that the first revision exists.  If it has been nuked
       by cvs admin -o, then just fall back to checking out entire
       revisions.  In some sense maybe we don't have to do this; after
       all cvs.texinfo says "Make sure that no-one has checked out a
       copy of the revision you outdate" but then again, that advice
       doesn't really make complete sense, because "cvs admin" operates
       on a working directory and so _someone_ will almost always have
       _some_ revision checked out.  */
    {
	char *rev;

	rev = RCS_gettag (finfo->rcs, vers_ts->vn_user, 1, NULL);
	if (rev == NULL)
	{
	    *docheckout = 1;
	    return 0;
	}
	else
	    free (rev);
    }

    backup = xmalloc (strlen (finfo->file)
		      + sizeof (CVSADM)
		      + sizeof (CVSPREFIX)
		      + 10);
    (void) sprintf (backup, "%s/%s%s", CVSADM, CVSPREFIX, finfo->file);
    if (isfile (finfo->file))
        rename_file (finfo->file, backup);
    else
        (void) unlink_file (backup);

    file1 = xmalloc (strlen (finfo->file)
		     + sizeof (CVSADM)
		     + sizeof (CVSPREFIX)
		     + 10);
    (void) sprintf (file1, "%s/%s%s-1", CVSADM, CVSPREFIX, finfo->file);
    file2 = xmalloc (strlen (finfo->file)
		     + sizeof (CVSADM)
		     + sizeof (CVSPREFIX)
		     + 10);
    (void) sprintf (file2, "%s/%s%s-2", CVSADM, CVSPREFIX, finfo->file);

    fail = 0;

    /* We need to check out both revisions first, to see if either one
       has a trailing newline.  Because of this, we don't use rcsdiff,
       but just use diff.  */

    e = CVS_FOPEN (file1, "w");
    if (e == NULL)
	error (1, errno, "cannot open %s", file1);

    data.filename = file1;
    data.fp = e;
    data.final_nl = 0;
    data.compute_checksum = 0;

    retcode = RCS_checkout (vers_ts->srcfile, (char *) NULL,
			    vers_ts->vn_user, (char *) NULL,
			    vers_ts->options, RUN_TTY,
			    patch_file_write, (void *) &data);

    if (fclose (e) < 0)
	error (1, errno, "cannot close %s", file1);

    if (retcode != 0 || ! data.final_nl)
	fail = 1;

    if (! fail)
    {
	e = CVS_FOPEN (file2, "w");
	if (e == NULL)
	    error (1, errno, "cannot open %s", file2);

	data.filename = file2;
	data.fp = e;
	data.final_nl = 0;
	data.compute_checksum = 1;
	MD5Init (&data.context);

	retcode = RCS_checkout (vers_ts->srcfile, (char *) NULL,
				vers_ts->vn_rcs, (char *) NULL,
				vers_ts->options, RUN_TTY,
				patch_file_write, (void *) &data);

	if (fclose (e) < 0)
	    error (1, errno, "cannot close %s", file2);

	if (retcode != 0 || ! data.final_nl)
	    fail = 1;
	else
	    MD5Final (checksum, &data.context);
    }	  

    retcode = 0;
    if (! fail)
    {
	char *diff_options;

	/* FIXME: It might be better to come up with a diff library
           which can be shared with the diffutils.  */
	/* If the client does not support the Rcs-diff command, we
           send a context diff, and the client must invoke patch.
           That approach was problematical for various reasons.  The
           new approach only requires running diff in the server; the
           client can handle everything without invoking an external
           program.  */
	if (! rcs_diff_patches)
	{
	    /* We use -c, not -u, because we have no way of knowing
	       which DIFF is in use.  */
	    diff_options = "-c";
	}
	else
	{
	    /* Now that diff is librarified, we could be passing -a if
	       we wanted to.  However, it is unclear to me whether we
	       would want to.  Does diff -a, in any significant
	       percentage of cases, produce patches which are smaller
	       than the files it is patching?  I guess maybe text
	       files with character sets which diff regards as
	       'binary'.  Conversely, do they tend to be much larger
	       in the bad cases?  This needs some more
	       thought/investigation, I suspect.  */

	    diff_options = "-n";
	}
	retcode = diff_exec (file1, file2, diff_options, finfo->file);

	/* A retcode of 0 means no differences.  1 means some differences.  */
	if (retcode != 0
	    && retcode != 1)
	{
	    fail = 1;
	}
	else
	{
#define BINARY "Binary"
	    char buf[sizeof BINARY];
	    unsigned int c;

	    /* Stat the original RCS file, and then adjust it the way
	       that RCS_checkout would.  FIXME: This is an abstraction
	       violation.  */
	    if (CVS_STAT (vers_ts->srcfile->path, file_info) < 0)
		error (1, errno, "could not stat %s", vers_ts->srcfile->path);
	    if (chmod (finfo->file,
		       file_info->st_mode & ~(S_IWRITE | S_IWGRP | S_IWOTH))
		< 0)
		error (0, errno, "cannot change mode of file %s", finfo->file);
	    if (cvswrite
		&& !fileattr_get (finfo->file, "_watched"))
		xchmod (finfo->file, 1);

	    /* Check the diff output to make sure patch will be handle it.  */
	    e = CVS_FOPEN (finfo->file, "r");
	    if (e == NULL)
		error (1, errno, "could not open diff output file %s",
		       finfo->fullname);
	    c = fread (buf, 1, sizeof BINARY - 1, e);
	    buf[c] = '\0';
	    if (strcmp (buf, BINARY) == 0)
	    {
		/* These are binary files.  We could use diff -a, but
		   patch can't handle that.  */
		fail = 1;
	    }
	    fclose (e);
	}
    }

    if (! fail)
    {
        Vers_TS *xvers_ts;

        /* This stuff is just copied blindly from checkout_file.  I
	   don't really know what it does.  */
        xvers_ts = Version_TS (finfo, options, tag, date,
			       force_tag_match, 0);
	if (strcmp (xvers_ts->options, "-V4") == 0)
	    xvers_ts->options[0] = '\0';

	Register (finfo->entries, finfo->file, xvers_ts->vn_rcs,
		  xvers_ts->ts_user, xvers_ts->options,
		  xvers_ts->tag, xvers_ts->date, NULL);

	if (CVS_STAT (finfo->file, file_info) < 0)
	    error (1, errno, "could not stat %s", finfo->file);

	/* If this is really Update and not Checkout, recode history */
	if (strcmp (command_name, "update") == 0)
	    history_write ('P', finfo->update_dir, xvers_ts->vn_rcs, finfo->file,
			   finfo->repository);

	freevers_ts (&xvers_ts);

	if (!really_quiet)
	{
	    write_letter (finfo->file, 'P', finfo->update_dir);
	}
    }
    else
    {
	int old_errno = errno;		/* save errno value over the rename */

	if (isfile (backup))
	    rename_file (backup, finfo->file);

	if (retcode != 0 && retcode != 1)
	    error (retcode == -1 ? 1 : 0, retcode == -1 ? old_errno : 0,
		   "could not diff %s", finfo->fullname);

	*docheckout = 1;
	retval = retcode;
    }

    (void) unlink_file (backup);
    (void) unlink_file (file1);
    (void) unlink_file (file2);

    free (backup);
    free (file1);
    free (file2);
    return (retval);
}

/* Write data to a file.  Record whether the last byte written was a
   newline.  Optionally compute a checksum.  This is called by
   patch_file via RCS_checkout.  */

static void
patch_file_write (callerdat, buffer, len)
     void *callerdat;
     const char *buffer;
     size_t len;
{
    struct patch_file_data *data = (struct patch_file_data *) callerdat;

    if (fwrite (buffer, 1, len, data->fp) != len)
	error (1, errno, "cannot write %s", data->filename);

    data->final_nl = (buffer[len - 1] == '\n');

    if (data->compute_checksum)
	MD5Update (&data->context, (unsigned char *) buffer, len);
}

#endif /* SERVER_SUPPORT */

/*
 * Several of the types we process only print a bit of information consisting
 * of a single letter and the name.
 */
static int
write_letter (file, letter, update_dir)
    char *file;
    int letter;
    char *update_dir;
{
    if (!really_quiet)
    {
	char buf[2];
	buf[0] = letter;
	buf[1] = ' ';
	cvs_output (buf, 2);
	if (update_dir[0])
	{
	    cvs_output (update_dir, 0);
	    cvs_output ("/", 1);
	}
	cvs_output (file, 0);
	cvs_output ("\n", 1);
    }
    return (0);
}

/*
 * Do all the magic associated with a file which needs to be merged
 */
static int
merge_file (finfo, vers)
    struct file_info *finfo;
    Vers_TS *vers;
{
    char *backup;
    int status;
    int retcode = 0;
    int retval;

    /*
     * The users currently modified file is moved to a backup file name
     * ".#filename.version", so that it will stay around for a few days
     * before being automatically removed by some cron daemon.  The "version"
     * is the version of the file that the user was most up-to-date with
     * before the merge.
     */
    backup = xmalloc (strlen (finfo->file)
		      + strlen (vers->vn_user)
		      + sizeof (BAKPREFIX)
		      + 10);
    (void) sprintf (backup, "%s%s.%s", BAKPREFIX, finfo->file, vers->vn_user);

    (void) unlink_file (backup);
    copy_file (finfo->file, backup);
    xchmod (finfo->file, 1);

    if (strcmp (vers->options, "-kb") == 0
	|| wrap_merge_is_copy (finfo->file))
    {
	/* For binary files, a merge is always a conflict.  We give the
	   user the two files, and let them resolve it.  It is possible
	   that we should require a "touch foo" or similar step before
	   we allow a checkin.  */
	status = checkout_file (finfo, vers, 0);
#ifdef SERVER_SUPPORT
	/* Send the new contents of the file before the message.  If we
	   wanted to be totally correct, we would have the client write
	   the message only after the file has safely been written.  */
	if (server_active)
	{
	    server_copy_file (finfo->file, finfo->update_dir,
			      finfo->repository, backup);
	    server_updated (finfo, vers, SERVER_MERGED,
			    (struct stat *) NULL, (unsigned char *) NULL);
	}
#endif
	/* Is there a better term than "nonmergeable file"?  What we
	   really mean is, not something that CVS cannot or does not
	   want to merge (there might be an external manual or
	   automatic merge process).  */
	error (0, 0, "nonmergeable file needs merge");
	error (0, 0, "revision %s from repository is now in %s",
	       vers->vn_rcs, finfo->fullname);
	error (0, 0, "file from working directory is now in %s", backup);
	write_letter (finfo->file, 'C', finfo->update_dir);

	history_write ('C', finfo->update_dir, vers->vn_rcs, finfo->file,
		       finfo->repository);
	retval = 0;
	goto out;
    }

    status = RCS_merge(finfo->rcs, vers->srcfile->path, finfo->file,
		       vers->options, vers->vn_user, vers->vn_rcs);
    if (status != 0 && status != 1)
    {
	error (0, status == -1 ? errno : 0,
	       "could not merge revision %s of %s", vers->vn_user, finfo->fullname);
	error (status == -1 ? 1 : 0, 0, "restoring %s from backup file %s",
	       finfo->fullname, backup);
	rename_file (backup, finfo->file);
	retval = 1;
	goto out;
    }

    if (strcmp (vers->options, "-V4") == 0)
	vers->options[0] = '\0';
    (void) time (&last_register_time);
    {
	char *cp = 0;

	if (status)
	    cp = time_stamp (finfo->file);
	Register (finfo->entries, finfo->file, vers->vn_rcs, vers->ts_rcs, vers->options,
		  vers->tag, vers->date, cp);
	if (cp)
	    free (cp);
    }

    /* fix up the vers structure, in case it is used by join */
    if (join_rev1)
    {
	if (vers->vn_user != NULL)
	    free (vers->vn_user);
	vers->vn_user = xstrdup (vers->vn_rcs);
    }

#ifdef SERVER_SUPPORT
    /* Send the new contents of the file before the message.  If we
       wanted to be totally correct, we would have the client write
       the message only after the file has safely been written.  */
    if (server_active)
    {
        server_copy_file (finfo->file, finfo->update_dir, finfo->repository,
			  backup);
	server_updated (finfo, vers, SERVER_MERGED,
			(struct stat *) NULL, (unsigned char *) NULL);
    }
#endif

    if (!noexec && !xcmp (backup, finfo->file))
    {
	printf ("%s already contains the differences between %s and %s\n",
		finfo->fullname, vers->vn_user, vers->vn_rcs);
	history_write ('G', finfo->update_dir, vers->vn_rcs, finfo->file,
		       finfo->repository);
	retval = 0;
	goto out;
    }

    if (status == 1)
    {
	if (!noexec)
	    error (0, 0, "conflicts found in %s", finfo->fullname);

	write_letter (finfo->file, 'C', finfo->update_dir);

	history_write ('C', finfo->update_dir, vers->vn_rcs, finfo->file, finfo->repository);

    }
    else if (retcode == -1)
    {
	error (1, errno, "fork failed while examining update of %s",
	       finfo->fullname);
    }
    else
    {
	write_letter (finfo->file, 'M', finfo->update_dir);
	history_write ('G', finfo->update_dir, vers->vn_rcs, finfo->file,
		       finfo->repository);
    }
    retval = 0;
 out:
    free (backup);
    return retval;
}

/*
 * Do all the magic associated with a file which needs to be joined
 * (-j option)
 */
static void
join_file (finfo, vers)
    struct file_info *finfo;
    Vers_TS *vers;
{
    char *backup;
    char *options;
    int status;

    char *rev1;
    char *rev2;
    char *jrev1;
    char *jrev2;
    char *jdate1;
    char *jdate2;

    jrev1 = join_rev1;
    jrev2 = join_rev2;
    jdate1 = date_rev1;
    jdate2 = date_rev2;

    /* Determine if we need to do anything at all.  */
    if (vers->srcfile == NULL ||
	vers->srcfile->path == NULL)
    {
	return;
    }

    /* If only one join revision is specified, it becomes the second
       revision.  */
    if (jrev2 == NULL)
    {
	jrev2 = jrev1;
	jrev1 = NULL;
	jdate2 = jdate1;
	jdate1 = NULL;
    }

    /* Convert the second revision, walking branches and dates.  */
    rev2 = RCS_getversion (vers->srcfile, jrev2, jdate2, 1, (int *) NULL);

    /* If this is a merge of two revisions, get the first revision.
       If only one join tag was specified, then the first revision is
       the greatest common ancestor of the second revision and the
       working file.  */
    if (jrev1 != NULL)
	rev1 = RCS_getversion (vers->srcfile, jrev1, jdate1, 1, (int *) NULL);
    else
    {
	/* Note that we use vn_rcs here, since vn_user may contain a
           special string such as "-nn".  */
	if (vers->vn_rcs == NULL)
	    rev1 = NULL;
	else if (rev2 == NULL)
	{
	    /* This means that the file never existed on the branch.
               It does not mean that the file was removed on the
               branch: that case is represented by a dead rev2.  If
               the file never existed on the branch, then we have
               nothing to merge, so we just return.  */
	    return;
	}
	else
	    rev1 = gca (vers->vn_rcs, rev2);
    }

    /* Handle a nonexistent or dead merge target.  */
    if (rev2 == NULL || RCS_isdead (vers->srcfile, rev2))
    {
	char *mrev;

	if (rev2 != NULL)
	    free (rev2);

	/* If the first revision doesn't exist either, then there is
           no change between the two revisions, so we don't do
           anything.  */
	if (rev1 == NULL || RCS_isdead (vers->srcfile, rev1))
	{
	    if (rev1 != NULL)
		free (rev1);
	    return;
	}

	/* If we are merging two revisions, then the file was removed
	   between the first revision and the second one.  In this
	   case we want to mark the file for removal.

	   If we are merging one revision, then the file has been
	   removed between the greatest common ancestor and the merge
	   revision.  From the perspective of the branch on to which
	   we ar emerging, which may be the trunk, either 1) the file
	   does not currently exist on the target, or 2) the file has
	   not been modified on the target branch since the greatest
	   common ancestor, or 3) the file has been modified on the
	   target branch since the greatest common ancestor.  In case
	   1 there is nothing to do.  In case 2 we mark the file for
	   removal.  In case 3 we have a conflict.

	   Note that the handling is slightly different depending upon
	   whether one or two join targets were specified.  If two
	   join targets were specified, we don't check whether the
	   file was modified since a given point.  My reasoning is
	   that if you ask for an explicit merge between two tags,
	   then you want to merge in whatever was changed between
	   those two tags.  If a file was removed between the two
	   tags, then you want it to be removed.  However, if you ask
	   for a merge of a branch, then you want to merge in all
	   changes which were made on the branch.  If a file was
	   removed on the branch, that is a change to the file.  If
	   the file was also changed on the main line, then that is
	   also a change.  These two changes--the file removal and the
	   modification--must be merged.  This is a conflict.  */

	/* If the user file is dead, or does not exist, or has been
           marked for removal, then there is nothing to do.  */
	if (vers->vn_user == NULL
	    || vers->vn_user[0] == '-'
	    || RCS_isdead (vers->srcfile, vers->vn_user))
	{
	    if (rev1 != NULL)
		free (rev1);
	    return;
	}

	/* If the user file has been marked for addition, or has been
	   locally modified, then we have a conflict which we can not
	   resolve.  No_Difference will already have been called in
	   this case, so comparing the timestamps is sufficient to
	   determine whether the file is locally modified.  */
	if (strcmp (vers->vn_user, "0") == 0
	    || (vers->ts_user != NULL
		&& strcmp (vers->ts_user, vers->ts_rcs) != 0))
	{
	    if (jdate2 != NULL)
		error (0, 0,
		       "file %s is locally modified, but has been removed in revision %s as of %s",
		       finfo->fullname, jrev2, jdate2);
	    else
		error (0, 0,
		       "file %s is locally modified, but has been removed in revision %s",
		       finfo->fullname, jrev2);

	    /* FIXME: Should we arrange to return a non-zero exit
               status?  */

	    if (rev1 != NULL)
		free (rev1);

	    return;
	}

	/* If only one join tag was specified, and the user file has
           been changed since the greatest common ancestor (rev1),
           then there is a conflict we can not resolve.  See above for
           the rationale.  */
	if (join_rev2 == NULL
	    && strcmp (rev1, vers->vn_user) != 0)
	{
	    if (jdate2 != NULL)
		error (0, 0,
		       "file %s has been modified, but has been removed in revision %s as of %s",
		       finfo->fullname, jrev2, jdate2);
	    else
		error (0, 0,
		       "file %s has been modified, but has been removed in revision %s",
		       finfo->fullname, jrev2);

	    /* FIXME: Should we arrange to return a non-zero exit
               status?  */

	    if (rev1 != NULL)
		free (rev1);

	    return;
	}

	if (rev1 != NULL)
	    free (rev1);

	/* The user file exists and has not been modified.  Mark it
           for removal.  FIXME: If we are doing a checkout, this has
           the effect of first checking out the file, and then
           removing it.  It would be better to just register the
           removal.  */
#ifdef SERVER_SUPPORT
	if (server_active)
	{
	    server_scratch (finfo->file);
	    server_updated (finfo, vers, SERVER_UPDATED, (struct stat *) NULL,
			    (unsigned char *) NULL);
	}
#endif
	mrev = xmalloc (strlen (vers->vn_user) + 2);
	sprintf (mrev, "-%s", vers->vn_user);
	Register (finfo->entries, finfo->file, mrev, vers->ts_rcs,
		  vers->options, vers->tag, vers->date, vers->ts_conflict);
	free (mrev);
	/* We need to check existence_error here because if we are
           running as the server, and the file is up to date in the
           working directory, the client will not have sent us a copy.  */
	if (unlink_file (finfo->file) < 0 && ! existence_error (errno))
	    error (0, errno, "cannot remove file %s", finfo->fullname);
#ifdef SERVER_SUPPORT
	if (server_active)
	    server_checked_in (finfo->file, finfo->update_dir,
			       finfo->repository);
#endif
	if (! really_quiet)
	    error (0, 0, "scheduling %s for removal", finfo->fullname);

	return;
    }

    /* If the target of the merge is the same as the working file
       revision, then there is nothing to do.  */
    if (vers->vn_user != NULL && strcmp (rev2, vers->vn_user) == 0)
    {
	if (rev1 != NULL)
	    free (rev1);
	free (rev2);
	return;
    }

    /* If rev1 is dead or does not exist, then the file was added
       between rev1 and rev2.  */
    if (rev1 == NULL || RCS_isdead (vers->srcfile, rev1))
    {
	if (rev1 != NULL)
	    free (rev1);
	free (rev2);

	/* If the file does not exist in the working directory, then
           we can just check out the new revision and mark it for
           addition.  */
	if (vers->vn_user == NULL)
	{
	    Vers_TS *xvers;

	    xvers = Version_TS (finfo, vers->options, jrev2, jdate2, 1, 0);

	    /* FIXME: If checkout_file fails, we should arrange to
               return a non-zero exit status.  */
	    status = checkout_file (finfo, xvers, 1);

#ifdef SERVER_SUPPORT
	    if (server_active && status == 0)
		server_updated (finfo, xvers,
				SERVER_UPDATED, (struct stat *) NULL,
				(unsigned char *) NULL);
#endif

	    freevers_ts (&xvers);

	    return;
	}

	/* The file currently exists in the working directory, so we
           have a conflict which we can not resolve.  Note that this
           is true even if the file is marked for addition or removal.  */

	if (jdate2 != NULL)
	    error (0, 0,
		   "file %s exists, but has been added in revision %s as of %s",
		   finfo->fullname, jrev2, jdate2);
	else
	    error (0, 0,
		   "file %s exists, but has been added in revision %s",
		   finfo->fullname, jrev2);

	return;
    }

    /* If the two merge revisions are the same, then there is nothing
       to do.  */
    if (strcmp (rev1, rev2) == 0)
    {
	free (rev1);
	free (rev2);
	return;
    }

    /* If there is no working file, then we can't do the merge.  */
    if (vers->vn_user == NULL)
    {
	free (rev1);
	free (rev2);

	if (jdate2 != NULL)
	    error (0, 0,
		   "file %s is present in revision %s as of %s",
		   finfo->fullname, jrev2, jdate2);
	else
	    error (0, 0,
		   "file %s is present in revision %s",
		   finfo->fullname, jrev2);

	/* FIXME: Should we arrange to return a non-zero exit status?  */

	return;
    }

#ifdef SERVER_SUPPORT
    if (server_active && !isreadable (finfo->file))
    {
	int retcode;
	/* The file is up to date.  Need to check out the current contents.  */
	retcode = RCS_checkout (vers->srcfile, finfo->file,
				vers->vn_user, (char *) NULL,
				(char *) NULL, RUN_TTY,
				(RCSCHECKOUTPROC) NULL, (void *) NULL);
	if (retcode != 0)
	    error (1, retcode == -1 ? errno : 0,
		   "failed to check out %s file", finfo->fullname);
    }
#endif

    /*
     * The users currently modified file is moved to a backup file name
     * ".#filename.version", so that it will stay around for a few days
     * before being automatically removed by some cron daemon.  The "version"
     * is the version of the file that the user was most up-to-date with
     * before the merge.
     */
    backup = xmalloc (strlen (finfo->file)
		      + strlen (vers->vn_user)
		      + sizeof (BAKPREFIX)
		      + 10);
    (void) sprintf (backup, "%s%s.%s", BAKPREFIX, finfo->file, vers->vn_user);

    (void) unlink_file (backup);
    copy_file (finfo->file, backup);
    xchmod (finfo->file, 1);

    options = vers->options;
#ifdef HAVE_RCS5
#if 0
    if (*options == '\0')
	options = "-kk";		/* to ignore keyword expansions */
#endif
#endif

    /* If the source of the merge is the same as the working file
       revision, then we can just RCS_checkout the target (no merging
       as such).  In the text file case, this is probably quite
       similar to the RCS_merge, but in the binary file case,
       RCS_merge gives all kinds of trouble.  */
    if (vers->vn_user != NULL
	&& strcmp (rev1, vers->vn_user) == 0
	/* See comments above about how No_Difference has already been
	   called.  */
	&& vers->ts_user != NULL
	&& strcmp (vers->ts_user, vers->ts_rcs) == 0

	/* This is because of the worry below about $Name.  If that
	   isn't a problem, I suspect this code probably works for
	   text files too.  */
	&& (strcmp (options, "-kb") == 0
	    || wrap_merge_is_copy (finfo->file)))
    {
	/* FIXME: what about nametag?  What does RCS_merge do with
	   $Name?  */
	if (RCS_checkout (finfo->rcs, finfo->file, rev2, NULL, options,
			  RUN_TTY, (RCSCHECKOUTPROC)0, NULL) != 0)
	    status = 2;
	else
	    status = 0;

	/* OK, this is really stupid.  RCS_checkout carefully removes
	   write permissions, and we carefully put them back.  But
	   until someone gets around to fixing it, that seems like the
	   easiest way to get what would seem to be the right mode.
	   I don't check CVSWRITE or _watched; I haven't thought about
	   that in great detail, but it seems like a watched file should
	   be checked out (writable) after a merge.  */
	xchmod (finfo->file, 1);

	/* Traditionally, the text file case prints a whole bunch of
	   scary looking and verbose output which fails to tell the user
	   what is really going on (it gives them rev1 and rev2 but doesn't
	   indicate in any way that rev1 == vn_user).  I think just a
	   simple "U foo" is good here; it seems analogous to the case in
	   which the file was added on the branch in terms of what to
	   print.  */
	write_letter (finfo->file, 'U', finfo->update_dir);
    }
    else if (strcmp (options, "-kb") == 0
	     || wrap_merge_is_copy (finfo->file))
    {
	/* We are dealing with binary files, but real merging would
	   need to take place.  This is a conflict.  We give the user
	   the two files, and let them resolve it.  It is possible
	   that we should require a "touch foo" or similar step before
	   we allow a checkin.  */
	if (RCS_checkout (finfo->rcs, finfo->file, rev2, NULL, options,
			  RUN_TTY, (RCSCHECKOUTPROC)0, NULL) != 0)
	    status = 2;
	else
	    status = 0;

	/* OK, this is really stupid.  RCS_checkout carefully removes
	   write permissions, and we carefully put them back.  But
	   until someone gets around to fixing it, that seems like the
	   easiest way to get what would seem to be the right mode.
	   I don't check CVSWRITE or _watched; I haven't thought about
	   that in great detail, but it seems like a watched file should
	   be checked out (writable) after a merge.  */
	xchmod (finfo->file, 1);

	/* Hmm.  We don't give them REV1 anywhere.  I guess most people
	   probably don't have a 3-way merge tool for the file type in
	   question, and might just get confused if we tried to either
	   provide them with a copy of the file from REV1, or even just
	   told them what REV1 is so they can get it themself, but it
	   might be worth thinking about.  */
	/* See comment in merge_file about the "nonmergeable file"
	   terminology.  */
	error (0, 0, "nonmergeable file needs merge");
	error (0, 0, "revision %s from repository is now in %s",
	       rev2, finfo->fullname);
	error (0, 0, "file from working directory is now in %s", backup);
	write_letter (finfo->file, 'C', finfo->update_dir);
    }
    else
	status = RCS_merge (finfo->rcs, vers->srcfile->path, finfo->file, options, rev1, rev2);

    if (status != 0 && status != 1)
    {
	error (0, status == -1 ? errno : 0,
	       "could not merge revision %s of %s", rev2, finfo->fullname);
	error (status == -1 ? 1 : 0, 0, "restoring %s from backup file %s",
	       finfo->fullname, backup);
	rename_file (backup, finfo->file);
    }
    free (rev1);
    free (rev2);

#ifdef SERVER_SUPPORT
    /*
     * If we're in server mode, then we need to re-register the file
     * even if there were no conflicts (status == 0).
     * This tells server_updated() to send the modified file back to
     * the client.
     */
    if (status == 1 || (status == 0 && server_active))
#else
    if (status == 1)
#endif
    {
	char *cp = 0;

	if (status)
	    cp = time_stamp (finfo->file);
	Register (finfo->entries, finfo->file,
		  vers->vn_rcs, vers->ts_rcs, vers->options,
		  vers->tag, vers->date, cp);
	if (cp)
	    free(cp);
    }

#ifdef SERVER_SUPPORT
    if (server_active)
    {
	server_copy_file (finfo->file, finfo->update_dir, finfo->repository,
			  backup);
	server_updated (finfo, vers, SERVER_MERGED,
			(struct stat *) NULL, (unsigned char *) NULL);
    }
#endif
    free (backup);
}

int
joining ()
{
    return (join_rev1 != NULL);
}
