/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * Copyright (c) 2001, Tony Hoyle
 * Copyright (c) 2004, Derek R. Price & Ximbiot <http://ximbiot.com>
 *
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 *
 * Query CVS/Entries from server
 */

#include "cvs.h"
#include <stdbool.h>

static int ls_proc (int argc, char **argv, char *xwhere, char *mwhere,
                    char *mfile, int shorten, int local, char *mname,
                    char *msg);
static int ls_fileproc (void *callerdat, struct file_info *finfo);
static Dtype ls_direntproc (void *callerdat, const char *dir,
                            const char *repos, const char *update_dir,
                            List *entries);

static RCSNode *xrcsnode;

static const char *const ls_usage[] =
{
    "Usage: %s %s [-e | -l] [-R] [-r rev] [-D date] [path...]\n",
    "\t-e\tDisplay in CVS/Entries format.\n",
    "\t-l\tDisplay all details.\n",
    "\t-R\tList recursively.\n",
    "\t-r rev\tShow files with revision or tag.\n",
    "\t-D date\tShow files from date.\n",
    "(Specify the --help global option for a list of other help options)\n",
    NULL
};

static bool entries_format;
static bool long_format;
static char *show_tag;
static char *show_date;
static bool tag_validated;
static bool recurse;
static char *regexp_match;
static bool is_rls;
static unsigned long long dircount; /* Dircount is used to avoid printing a
                                     * blank line after the last directory.
                                     */



int
ls (int argc, char **argv)
{
    int c;
    int err = 0;

    is_rls = strcmp (cvs_cmd_name, "rls") == 0;

    if (argc == -1)
	usage (ls_usage);

    entries_format = false;
    long_format = false;
    show_tag = NULL;
    show_date = NULL;
    tag_validated = false;
    recurse = false;

    optind = 0;

    while ((c = getopt (argc, argv,
#ifdef SERVER_SUPPORT
           server_active ? "qelr:D:R" :
#endif /* SERVER_SUPPORT */
           "elr:D:R"
           )) != -1)
    {
	switch (c)
	{
#ifdef SERVER_SUPPORT
	    case 'q':
		if (server_active)
		{
		    error (0, 0,
"`%s ls -q' is deprecated.  Please use the global `-q' option instead.",
                           program_name);
		    quiet = true;
		}
		else
		    usage (ls_usage);
		break;
#endif /* SERVER_SUPPORT */
	    case 'e':
		entries_format = true;
		break;
	    case 'l':
		long_format = true;
		break;
	    case 'r':
		show_tag = optarg;
		break;
	    case 'D':
		show_date = Make_Date (optarg);
		break;
	    case 'R':
		recurse = true;
		break;
	    case '?':
	    default:
		usage (ls_usage);
		break;
	}
    }
    argc -= optind;
    argv += optind;

    if (entries_format && long_format)
    {
        error (0, 0, "`-e' & `-l' are mutually exclusive.");
        usage (ls_usage);
    }

    wrap_setup ();

#ifdef CLIENT_SUPPORT
    if (current_parsed_root->isremote)
    {
	/* We're the local client.  Fire up the remote server.	*/
	start_server ();

	ign_setup ();

	if (is_rls ? !(supported_request ("rlist") || supported_request ("ls"))
                   : !supported_request ("list"))
	    error (1, 0, "server does not support %s", cvs_cmd_name);

	if (quiet && !supported_request ("global-list-quiet"))
	    send_arg ("-q");
	if (entries_format)
	    send_arg ("-e");
	if (long_format)
	    send_arg ("-l");
	if (recurse)
	    send_arg ("-R");
	if (show_tag)
	    option_with_arg ("-r", show_tag);
	if (show_date)
	    option_with_arg ("-D", show_date);

	send_arg ("--");

	if (is_rls)
	{
	    int i;
	    for (i = 0; i < argc; i++)
		send_arg (argv[i]);
            if (supported_request ("rlist"))
		send_to_server ("rlist\012", 0);
	    else
		/* For backwards compatibility with CVSNT...  */
		send_to_server ("ls\012", 0);
	}
	else
	{
	    /* I explicitly decide not to send contents here.  We *could* let
	     * the user pull status information with this command, but why
	     * don't they just use update or status?
	     */
	    send_files (argc, argv, !recurse, 0, SEND_NO_CONTENTS);
	    send_file_names (argc, argv, SEND_EXPAND_WILD);
	    send_to_server ("list\012", 0);
	}

	err = get_responses_and_close ();
	return err;
    }
#endif

    if (is_rls)
    {
	DBM *db;
	int i;
	db = open_module ();
	if (argc)
	{
	    for (i = 0; i < argc; i++)
	    {
		char *mod = xstrdup (argv[i]);
		char *p;

		for (p=strchr (mod,'\\'); p; p=strchr (p,'\\'))
		    *p='/';

		p = strrchr (mod,'/');
		if (p && (strchr (p,'?') || strchr (p,'*')))
		{
		    *p='\0';
		    regexp_match = p+1;
		}
		else
		    regexp_match = NULL;

		/* Frontends like to do 'ls -q /', so we support it explicitly.
                 */
		if (!strcmp (mod,"/"))
		{
		    *mod='\0';
		}

		err += do_module (db, mod, MISC, "Listing",
				  ls_proc, NULL, 0, 0, 0, 0, NULL);

		free (mod);
	    }
	}
	else
	{
	    /* should be ".", but do_recursion() 
	       fails this: assert ( strstr ( repository, "/./" ) == NULL ); */
	    err += do_module (db, "", MISC, "Listing",
			      ls_proc, NULL, 0, 0, 0, 0, NULL);
	}
	close_module (db);
    }
    else
	ls_proc (argc + 1, argv - 1, NULL, NULL, NULL, 0, 0, NULL, NULL);

    return err;
}



static int
ls_print (Node *p, void *closure)
{
    cvs_output (p->key, 0);
}



static int
ls_print_dir (Node *p, void *closure)
{
    if (recurse)
    {
        if (!strcmp (p->key, ""))
            cvs_output (".", 1);
        else
	    cvs_output (p->key, 0);
        cvs_output (":\n", 2);
    }
    walklist (p->data, ls_print, NULL);
    if (recurse && --dircount)
        cvs_output ("\n", 1);
    return 0;
}



/*
 * Add a file to our list of data to print for a directory.
 */
/* ARGSUSED */
static int
ls_fileproc (void *callerdat, struct file_info *finfo)
{
    Vers_TS *vers;
    char outdate[32];
    time_t t;
    char *regex_err;
    char *buf;
    size_t length;
    Node *p;

    if (regexp_match)
    {
#ifdef FILENAMES_CASE_INSENSITIVE
	  re_set_syntax (REG_ICASE|RE_SYNTAX_EGREP);
#else
	  re_set_syntax (RE_SYNTAX_EGREP);
#endif
	  if ((regex_err = re_comp (regexp_match)) != NULL)
	  {
	      error (1, 0, "bad regular expression passed to 'ls': %s",
                     regex_err);
	  }
	  if (re_exec (finfo->file) == 0)
	      return 0;				/* no match */
    }

    vers = Version_TS (finfo, NULL, show_tag, show_date, 1, 0);
    if (!vers->vn_rcs)
    {
        freevers_ts (&vers);
	return 0;
    }

    /* FIXME: The date format should mimic a real `ls' as much as possible
     * in long_format and should be asctime(gmtime(&t)) in entries_format.
     */
    t = RCS_getrevtime (finfo->rcs, vers->vn_rcs, 0, 0);
    strcpy (outdate, asctime (gmtime(&t)));
    outdate[strlen (outdate) - 1] = '\0';

    if (entries_format)
	buf = asnprintf (NULL, &length, "/%s/%s/%s/%s/%s%s\n",
                         finfo->file, vers->vn_rcs,
                         outdate, vers->options,
                         show_tag ? "T" : "", show_tag ? show_tag : "");
    else if (long_format)
	buf = asnprintf (NULL, &length, "%-5.5s%s %-9.9s%s %s\n",
                         vers->options[0] != '\0' ? vers->options : "----",
                         outdate, vers->vn_rcs,
                         strlen (vers->vn_rcs) > 9 ? "+" : " ",
                         finfo->file);
    else
	buf = asnprintf (NULL, &length, "%s\n", finfo->file);

    p = findnode (callerdat, finfo->update_dir);
    assert (p);
    push_string (p->data, buf);

    freevers_ts (&vers);
    return 0;
}



/*
 * Add this directory to the list of data to be printed for a directory and
 * decide whether to tell the recursion processor whether to continue
 * recursing or not.
 */
Dtype
ls_direntproc (void *callerdat, const char *dir, const char *repos,
               const char *update_dir, List *entries)
{
    Dtype retval = R_SKIP_ALL;
    Node *p;
    char *parent;

    if (!strcmp (dir, ".") || recurse)
    {
	/* Create a new list for this directory.  */
	p = getnode ();
	p->key = xstrdup (strcmp (update_dir, ".") ? update_dir : "");
	p->data = getlist ();
        p->delproc = dellist;
	addnode (callerdat, p);
        dircount++;
	retval = R_PROCESS;
    }

    if (strcmp (dir, "."))
    {
	/* Push this dir onto our parent directory's list.  */
	char *buf;
	size_t length;
	size_t trailingpathsep = 0;
	parent = xmalloc (strlen (update_dir) - strlen (dir) + 1);
	strncpy (parent, update_dir, strlen (update_dir) - strlen (dir));
	if (ISDIRSEP (parent[strlen (update_dir) - strlen (dir) - 1]))
            trailingpathsep = 1;
	parent[strlen (update_dir) - strlen (dir) - trailingpathsep] = '\0';
	p = findnode (callerdat, parent);
        assert (p);

	if (entries_format)
	    buf = asnprintf (NULL, &length, "D/%s////\n", dir);
	else if (long_format)
	    buf = asnprintf (NULL, &length, "d--- %36s%s\n", "", dir);
	else
	    buf = asnprintf (NULL, &length, "%s\n", dir);

	push_string (p->data, buf);
    }

    return retval;
}



static int
ls_proc (int argc, char **argv, char *xwhere, char *mwhere, char *mfile,
         int shorten, int local, char *mname, char *msg)
{
    char *repository;
    int err = 0;
    List *dirs;
    int which;
    char *where;

    if (is_rls)
    {
	char *myargv[2];

	if (!quiet)
	    error (0, 0, "Listing module: `%s'",
	           strcmp (mname, "") ? mname : ".");

	repository = xmalloc (strlen (current_parsed_root->directory)
			      + strlen (argv[0])
			      + (mfile == NULL ? 0 : strlen (mfile) + 1)
			      + 2);
	(void)sprintf (repository, "%s/%s", current_parsed_root->directory,
		       argv[0]);
	where = xmalloc (strlen (argv[0])
			 + (mfile == NULL ? 0 : strlen (mfile) + 1)
			 + 1);
	(void)strcpy (where, argv[0]);

	/* If mfile isn't null, we need to set up to do only part of the
	 * module.
	 */
	if (mfile != NULL)
	{
	    char *cp;
	    char *path;

	    /* If the portion of the module is a path, put the dir part on
	     * repos.
	     */
	    if ((cp = strrchr (mfile, '/')) != NULL)
	    {
		*cp = '\0';
		(void)strcat (repository, "/");
		(void)strcat (repository, mfile);
		(void)strcat (where, "/");
		(void)strcat (where, mfile);
		mfile = cp + 1;
	    }

	    /* take care of the rest */
	    path = asnprintf (NULL, NULL, "%s/%s", repository, mfile);
	    if (isdir (path))
	    {
		/* directory means repository gets the dir tacked on */
		(void)strcpy (repository, path);
		(void)strcat (where, "/");
		(void)strcat (where, mfile);
	    }
	    else
	    {
		myargv[1] = mfile;
		argc = 2;
		argv = myargv;
	    }
	    free (path);
	}

	/* cd to the starting repository */
	if (CVS_CHDIR (repository) < 0)
	{
	    error (0, errno, "cannot chdir to %s", repository);
	    free (repository);
	    free (where);
	    return 1;
	}

	which = W_REPOS;
    }
    else /* !is_rls */
    {
        repository = NULL;
        where = NULL;
        which = W_LOCAL | W_REPOS;
    }

    if (show_tag || show_date)
	which |= W_ATTIC;

    if (show_tag != NULL && !tag_validated)
    {
	tag_check_valid (show_tag, argc - 1, argv + 1, local, 0, repository);
	tag_validated = true;
    }

    dirs = getlist ();
    err = start_recursion (ls_fileproc, NULL, ls_direntproc,
                           NULL, dirs, argc - 1, argv + 1, local, which, 0,
                           CVS_LOCK_READ, where, 1, repository);

    if (!(which & W_LOCAL)) free (repository);
    if (where) free (where);

    walklist (dirs, ls_print_dir, NULL);

    return err;
}
