/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 */


#include "cvs.h"
#include "getline.h"

static int find_type (Node * p, void *closure);
static int fmt_proc (Node * p, void *closure);
static int logfile_write (char *repository, char *filter,
			  char *message, FILE * logfp, List * changes);
static int rcsinfo_proc ( char *repository, char *template,
                                void *closure );
static int title_proc (Node * p, void *closure);
static int update_logfile_proc ( char *repository, char *filter,
                                       void *closure);
static void setup_tmpfile (FILE * xfp, char *xprefix, List * changes);
static int verifymsg_proc ( char *repository, char *script,
                                  void *closure );

static FILE *fp;
static char *str_list;
static char *str_list_format;	/* The format for str_list's contents. */
static Ctype type;

/* 
 * Should the logmsg be re-read during the do_verify phase?
 * RereadLogAfterVerify=no|stat|yes
 * LOGMSG_REREAD_NEVER  - never re-read the logmsg
 * LOGMSG_REREAD_STAT   - re-read the logmsg only if it has changed
 * LOGMSG_REREAD_ALWAYS - always re-read the logmsg
 */
int RereadLogAfterVerify = LOGMSG_REREAD_ALWAYS;

/*
 * Puts a standard header on the output which is either being prepared for an
 * editor session, or being sent to a logfile program.  The modified, added,
 * and removed files are included (if any) and formatted to look pretty. */
static char *prefix;
static int col;
static char *tag;
static void
setup_tmpfile (FILE *xfp, char *xprefix, List *changes)
{
    /* set up statics */
    fp = xfp;
    prefix = xprefix;

    type = T_MODIFIED;
    if (walklist (changes, find_type, NULL) != 0)
    {
	(void) fprintf (fp, "%sModified Files:\n", prefix);
	col = 0;
	(void) walklist (changes, fmt_proc, NULL);
	(void) fprintf (fp, "\n");
	if (tag != NULL)
	{
	    free (tag);
	    tag = NULL;
	}
    }
    type = T_ADDED;
    if (walklist (changes, find_type, NULL) != 0)
    {
	(void) fprintf (fp, "%sAdded Files:\n", prefix);
	col = 0;
	(void) walklist (changes, fmt_proc, NULL);
	(void) fprintf (fp, "\n");
	if (tag != NULL)
	{
	    free (tag);
	    tag = NULL;
	}
    }
    type = T_REMOVED;
    if (walklist (changes, find_type, NULL) != 0)
    {
	(void) fprintf (fp, "%sRemoved Files:\n", prefix);
	col = 0;
	(void) walklist (changes, fmt_proc, NULL);
	(void) fprintf (fp, "\n");
	if (tag != NULL)
	{
	    free (tag);
	    tag = NULL;
	}
    }
}

/*
 * Looks for nodes of a specified type and returns 1 if found
 */
static int
find_type (Node *p, void *closure)
{
    struct logfile_info *li;

    li = (struct logfile_info *) p->data;
    if (li->type == type)
	return (1);
    else
	return (0);
}

/*
 * Breaks the files list into reasonable sized lines to avoid line wrap...
 * all in the name of pretty output.  It only works on nodes whose types
 * match the one we're looking for
 */
static int
fmt_proc (Node *p, void *closure)
{
    struct logfile_info *li;

    li = (struct logfile_info *) p->data;
    if (li->type == type)
    {
        if (li->tag == NULL
	    ? tag != NULL
	    : tag == NULL || strcmp (tag, li->tag) != 0)
	{
	    if (col > 0)
	        (void) fprintf (fp, "\n");
	    (void) fputs (prefix, fp);
	    col = strlen (prefix);
	    while (col < 6)
	    {
	        (void) fprintf (fp, " ");
		++col;
	    }

	    if (li->tag == NULL)
	        (void) fprintf (fp, "No tag");
	    else
	        (void) fprintf (fp, "Tag: %s", li->tag);

	    if (tag != NULL)
	        free (tag);
	    tag = xstrdup (li->tag);

	    /* Force a new line.  */
	    col = 70;
	}

	if (col == 0)
	{
	    (void) fprintf (fp, "%s\t", prefix);
	    col = 8;
	}
	else if (col > 8 && (col + (int) strlen (p->key)) > 70)
	{
	    (void) fprintf (fp, "\n%s\t", prefix);
	    col = 8;
	}
	(void) fprintf (fp, "%s ", p->key);
	col += strlen (p->key) + 1;
    }
    return (0);
}

/*
 * Builds a temporary file using setup_tmpfile() and invokes the user's
 * editor on the file.  The header garbage in the resultant file is then
 * stripped and the log message is stored in the "message" argument.
 * 
 * If REPOSITORY is non-NULL, process rcsinfo for that repository; if it
 * is NULL, use the CVSADM_TEMPLATE file instead.  REPOSITORY should be
 * NULL when running in client mode.
 *
 * GLOBALS
 *   Editor     Set to a default value by configure and overridable using the
 *              -e option to the CVS executable.
 */
void
do_editor (char *dir, char **messagep, char *repository, List *changes)
{
    static int reuse_log_message = 0;
    char *line;
    int line_length;
    size_t line_chars_allocated;
    char *fname;
    struct stat pre_stbuf, post_stbuf;
    int retcode = 0;

#ifdef CLIENT_SUPPORT
    assert (!current_parsed_root->isremote != !repository);
#else
    assert (repository);
#endif

    if (noexec || reuse_log_message)
	return;

    /* Abort before creation of the temp file if no editor is defined. */
    if (strcmp (Editor, "") == 0)
        error(1, 0, "no editor defined, must use -e or -m");

  again:
    /* Create a temporary file.  */
    if( ( fp = cvs_temp_file( &fname ) ) == NULL )
	error( 1, errno, "cannot create temporary file" );

    if (*messagep)
    {
	(void) fputs (*messagep, fp);

	if ((*messagep)[0] == '\0' ||
	    (*messagep)[strlen (*messagep) - 1] != '\n')
	    (void) fprintf (fp, "\n");
    }

    if (repository != NULL)
	/* tack templates on if necessary */
	(void) Parse_Info (CVSROOTADM_RCSINFO, repository, rcsinfo_proc,
		PIOPT_ALL, 0);
    else
    {
	FILE *tfp;
	char buf[1024];
	size_t n;
	size_t nwrite;

	/* Why "b"?  */
	tfp = CVS_FOPEN (CVSADM_TEMPLATE, "rb");
	if (tfp == NULL)
	{
	    if (!existence_error (errno))
		error (1, errno, "cannot read %s", CVSADM_TEMPLATE);
	}
	else
	{
	    while (!feof (tfp))
	    {
		char *p = buf;
		n = fread (buf, 1, sizeof buf, tfp);
		nwrite = n;
		while (nwrite > 0)
		{
		    n = fwrite (p, 1, nwrite, fp);
		    nwrite -= n;
		    p += n;
		}
		if (ferror (tfp))
		    error (1, errno, "cannot read %s", CVSADM_TEMPLATE);
	    }
	    if (fclose (tfp) < 0)
		error (0, errno, "cannot close %s", CVSADM_TEMPLATE);
	}
    }

    (void) fprintf (fp,
  "%s----------------------------------------------------------------------\n",
		    CVSEDITPREFIX);
    (void) fprintf (fp,
  "%sEnter Log.  Lines beginning with `%.*s' are removed automatically\n%s\n",
		    CVSEDITPREFIX, CVSEDITPREFIXLEN, CVSEDITPREFIX,
		    CVSEDITPREFIX);
    if (dir != NULL && *dir)
	(void) fprintf (fp, "%sCommitting in %s\n%s\n", CVSEDITPREFIX,
			dir, CVSEDITPREFIX);
    if (changes != NULL)
	setup_tmpfile (fp, CVSEDITPREFIX, changes);
    (void) fprintf (fp,
  "%s----------------------------------------------------------------------\n",
		    CVSEDITPREFIX);

    /* finish off the temp file */
    if (fclose (fp) == EOF)
        error (1, errno, "%s", fname);
    if ( CVS_STAT (fname, &pre_stbuf) == -1)
	pre_stbuf.st_mtime = 0;

    /* run the editor */
    run_setup (Editor);
    run_arg (fname);
    if ((retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY,
			     RUN_NORMAL | RUN_SIGIGNORE)) != 0)
	error (0, retcode == -1 ? errno : 0, "warning: editor session failed");

    /* put the entire message back into the *messagep variable */

    fp = open_file (fname, "r");

    if (*messagep)
	free (*messagep);

    if ( CVS_STAT (fname, &post_stbuf) != 0)
	    error (1, errno, "cannot find size of temp file %s", fname);

    if (post_stbuf.st_size == 0)
	*messagep = NULL;
    else
    {
	/* On NT, we might read less than st_size bytes, but we won't
	   read more.  So this works.  */
	*messagep = (char *) xmalloc (post_stbuf.st_size + 1);
 	(*messagep)[0] = '\0';
    }

    line = NULL;
    line_chars_allocated = 0;

    if (*messagep)
    {
	size_t message_len = post_stbuf.st_size + 1;
	size_t offset = 0;
	while (1)
	{
	    line_length = getline (&line, &line_chars_allocated, fp);
	    if (line_length == -1)
	    {
		if (ferror (fp))
		    error (0, errno, "warning: cannot read %s", fname);
		break;
	    }
	    if (strncmp (line, CVSEDITPREFIX, CVSEDITPREFIXLEN) == 0)
		continue;
	    if (offset + line_length >= message_len)
		expand_string (messagep, &message_len,
				offset + line_length + 1);
	    (void) strcpy (*messagep + offset, line);
	    offset += line_length;
	}
    }
    if (fclose (fp) < 0)
	error (0, errno, "warning: cannot close %s", fname);

    /* canonicalize emply messages */
    if (*messagep != NULL &&
        (**messagep == '\0' || strcmp (*messagep, "\n") == 0))
    {
	free (*messagep);
	*messagep = NULL;
    }

    if (pre_stbuf.st_mtime == post_stbuf.st_mtime || *messagep == NULL)
    {
	for (;;)
	{
	    (void) printf ("\nLog message unchanged or not specified\n");
	    (void) printf ("a)bort, c)ontinue, e)dit, !)reuse this message unchanged for remaining dirs\n");
	    (void) printf ("Action: (continue) ");
	    (void) fflush (stdout);
	    line_length = getline (&line, &line_chars_allocated, stdin);
	    if (line_length < 0)
	    {
		error (0, errno, "cannot read from stdin");
		if (unlink_file (fname) < 0)
		    error (0, errno,
			   "warning: cannot remove temp file %s", fname);
		error (1, 0, "aborting");
	    }
	    else if (line_length == 0
		     || *line == '\n' || *line == 'c' || *line == 'C')
		break;
	    if (*line == 'a' || *line == 'A')
		{
		    if (unlink_file (fname) < 0)
			error (0, errno, "warning: cannot remove temp file %s", fname);
		    error (1, 0, "aborted by user");
		}
	    if (*line == 'e' || *line == 'E')
		goto again;
	    if (*line == '!')
	    {
		reuse_log_message = 1;
		break;
	    }
	    (void) printf ("Unknown input\n");
	}
    }
    if (line)
	free (line);
    if (unlink_file (fname) < 0)
	error (0, errno, "warning: cannot remove temp file %s", fname);
    free (fname);
}

/* Runs the user-defined verification script as part of the commit or import 
   process.  This verification is meant to be run whether or not the user 
   included the -m atribute.  unlike the do_editor function, this is 
   independant of the running of an editor for getting a message.
 */
void
do_verify (char **messagep, char *repository)
{
    FILE *fp;
    char *fname;
    int retcode = 0;
    char *verifymsg_script = NULL;

    struct stat pre_stbuf, post_stbuf;

#ifdef CLIENT_SUPPORT
    if (current_parsed_root->isremote)
	/* The verification will happen on the server.  */
	return;
#endif

    /* FIXME? Do we really want to skip this on noexec?  What do we do
       for the other administrative files?  */
    if (noexec || repository == NULL)
	return;

    /* Get the name of the verification script to run  */

    if (Parse_Info (CVSROOTADM_VERIFYMSG, repository, verifymsg_proc, 0, &verifymsg_script) > 0)
	error (1, 0, "Message verification failed");

    if (!verifymsg_script)
	return;

    /* open a temporary file, write the message to the 
       temp file, and close the file.  */

    if ((fp = cvs_temp_file (&fname)) == NULL)
	error (1, errno, "cannot create temporary file %s", fname);

    if (*messagep != NULL)
	fputs (*messagep, fp);
    if (*messagep == NULL ||
	(*messagep)[0] == '\0' ||
	(*messagep)[strlen (*messagep) - 1] != '\n')
	putc ('\n', fp);
    if (fclose (fp) == EOF)
	error (1, errno, "%s", fname);

    if (RereadLogAfterVerify == LOGMSG_REREAD_STAT)
    {
	/* Remember the status of the temp file for later */
	if ( CVS_STAT (fname, &pre_stbuf) != 0 )
	    error (1, errno, "cannot stat temp file %s", fname);

	/*
	 * See if we need to sleep before running the verification
	 * script to avoid time-stamp races.
	 */
	sleep_past (pre_stbuf.st_mtime);
    }

    run_setup (verifymsg_script);
    run_arg (fname);
    if ((retcode = run_exec (RUN_TTY, RUN_TTY, RUN_TTY,
			     RUN_NORMAL | RUN_SIGIGNORE)) != 0)
    {
	/* Since following error() exits, delete the temp file now.  */
	if (unlink_file (fname) < 0)
	    error (0, errno, "cannot remove %s", fname);

	error (1, retcode == -1 ? errno : 0, 
	       "Message verification failed");
    }

    /* Get the mod time and size of the possibly new log message
     * in always and stat modes.
     */
    if (RereadLogAfterVerify == LOGMSG_REREAD_ALWAYS ||
	RereadLogAfterVerify == LOGMSG_REREAD_STAT)
    {
	if ( CVS_STAT (fname, &post_stbuf) != 0 )
	    error (1, errno, "cannot find size of temp file %s", fname);
    }

    /* And reread the log message in `always' mode or in `stat' mode when it's
     * changed
     */
    if (RereadLogAfterVerify == LOGMSG_REREAD_ALWAYS ||
	(RereadLogAfterVerify == LOGMSG_REREAD_STAT &&
	    (pre_stbuf.st_mtime != post_stbuf.st_mtime ||
	     pre_stbuf.st_size != post_stbuf.st_size)))
    {
	/* put the entire message back into the *messagep variable */

	if (*messagep) free (*messagep);

	if (post_stbuf.st_size == 0)
	    *messagep = NULL;
	else
	{
	    char *line = NULL;
	    int line_length;
	    size_t line_chars_allocated = 0;
	    char *p;

	    if ( (fp = open_file (fname, "r")) == NULL )
		error (1, errno, "cannot open temporary file %s", fname);

	    /* On NT, we might read less than st_size bytes,
	       but we won't read more.  So this works.  */
	    p = *messagep = (char *) xmalloc (post_stbuf.st_size + 1);
	    *messagep[0] = '\0';

	    while (1)
	    {
		line_length = getline (&line,
				       &line_chars_allocated,
				       fp);
		if (line_length == -1)
		{
		    if (ferror (fp))
			/* Fail in this case because otherwise we will have no
			 * log message
			 */
			error (1, errno, "cannot read %s", fname);
		    break;
		}
		if (strncmp (line, CVSEDITPREFIX, CVSEDITPREFIXLEN) == 0)
		    continue;
		(void) strcpy (p, line);
		p += line_length;
	    }
	    if (line) free (line);
	    if (fclose (fp) < 0)
	        error (0, errno, "warning: cannot close %s", fname);
	}
    }

    /* Delete the temp file  */

    if (unlink_file (fname) < 0)
	error (0, errno, "cannot remove %s", fname);
    free (fname);
    free( verifymsg_script );
    verifymsg_script = NULL;
}

/*
 * callback proc for Parse_Info for rcsinfo templates this routine basically
 * copies the matching template onto the end of the tempfile we are setting
 * up
 */
/* ARGSUSED */
static int
rcsinfo_proc(char *repository, char *template, void *closure)
{
    static char *last_template;
    FILE *tfp;

    /* nothing to do if the last one included is the same as this one */
    if (last_template && strcmp (last_template, template) == 0)
	return (0);
    if (last_template)
	free (last_template);
    last_template = xstrdup (template);

    if ((tfp = CVS_FOPEN (template, "r")) != NULL)
    {
	char *line = NULL;
	size_t line_chars_allocated = 0;

	while (getline (&line, &line_chars_allocated, tfp) >= 0)
	    (void) fputs (line, fp);
	if (ferror (tfp))
	    error (0, errno, "warning: cannot read %s", template);
	if (fclose (tfp) < 0)
	    error (0, errno, "warning: cannot close %s", template);
	if (line)
	    free (line);
	return (0);
    }
    else
    {
	error (0, errno, "Couldn't open rcsinfo template file %s", template);
	return (1);
    }
}

/*
 * Uses setup_tmpfile() to pass the updated message on directly to any
 * logfile programs that have a regular expression match for the checked in
 * directory in the source repository.  The log information is fed into the
 * specified program as standard input.
 */
struct ulp_data {
    FILE *logfp;
    char *message;
    List *changes;
};

void
Update_Logfile (char *repository, char *xmessage, FILE *xlogfp, List *xchanges)
{
    struct ulp_data ud;

    /* nothing to do if the list is empty */
    if (xchanges == NULL || xchanges->list->next == xchanges->list)
	return;

    /* set up vars for update_logfile_proc */
    ud.message = xmessage;
    ud.logfp = xlogfp;
    ud.changes = xchanges;

    /* call Parse_Info to do the actual logfile updates */
    (void) Parse_Info (CVSROOTADM_LOGINFO, repository, update_logfile_proc,
		PIOPT_ALL, &ud);
}

/*
 * callback proc to actually do the logfile write from Update_Logfile
 */
static int
update_logfile_proc(char *repository, char *filter, void *closure)
{
    struct ulp_data *udp = (struct ulp_data *)closure;
    return (logfile_write (repository, filter, udp->message, udp->logfp,
			   udp->changes));
}

/*
 * concatenate each filename/version onto str_list
 */
static int
title_proc (Node *p, void *closure)
{
    struct logfile_info *li;
    char *c;

    li = (struct logfile_info *) p->data;
    if (li->type == type)
    {
	/* Until we decide on the correct logging solution when we add
	   directories or perform imports, T_TITLE nodes will only
	   tack on the name provided, regardless of the format string.
	   You can verify that this assumption is safe by checking the
	   code in add.c (add_directory) and import.c (import). */

	str_list = xrealloc (str_list, strlen (str_list) + 5);
	(void) strcat (str_list, " ");

	if (li->type == T_TITLE)
	{
	    str_list = xrealloc (str_list,
				 strlen (str_list) + strlen (p->key) + 5);
	    (void) strcat (str_list, p->key);
	}
	else
	{
	    /* All other nodes use the format string. */

	    for (c = str_list_format; *c != '\0'; c++)
	    {
		switch (*c)
		{
		case 's':
		    str_list =
			xrealloc (str_list,
				  strlen (str_list) + strlen (p->key) + 5);
		    (void) strcat (str_list, p->key);
		    break;
		case 'V':
		    str_list =
			xrealloc (str_list,
				  (strlen (str_list)
				   + (li->rev_old ? strlen (li->rev_old) : 0)
				   + 10)
				  );
		    (void) strcat (str_list, (li->rev_old
					      ? li->rev_old : "NONE"));
		    break;
		case 'v':
		    str_list =
			xrealloc (str_list,
				  (strlen (str_list)
				   + (li->rev_new ? strlen (li->rev_new) : 0)
				   + 10)
				  );
		    (void) strcat (str_list, (li->rev_new
					      ? li->rev_new : "NONE"));
		    break;
		/* All other characters, we insert an empty field (but
		   we do put in the comma separating it from other
		   fields).  This way if future CVS versions add formatting
		   characters, one can write a loginfo file which at least
		   won't blow up on an old CVS.  */
		/* Note that people who have to deal with spaces in file
		   and directory names are using space to get a known
		   delimiter for the directory name, so it's probably
		   not a good idea to ever define that as a formatting
		   character.  */
		}
		if (*(c + 1) != '\0')
		{
		    str_list = xrealloc (str_list, strlen (str_list) + 5);
		    (void) strcat (str_list, ",");
		}
	    }
	}
    }
    return (0);
}

/*
 * Writes some stuff to the logfile "filter" and returns the status of the
 * filter program.
 */
static int
logfile_write (char *repository, char *filter, char *message, FILE *logfp, List *changes)
{
    FILE *pipefp;
    char *prog;
    char *cp;
    int c;
    int pipestatus;
    char *fmt_percent;		/* the location of the percent sign
				   that starts the format string. */

    /* The user may specify a format string as part of the filter.
       Originally, `%s' was the only valid string.  The string that
       was substituted for it was:

         <repository-name> <file1> <file2> <file3> ...

       Each file was either a new directory/import (T_TITLE), or a
       added (T_ADDED), modified (T_MODIFIED), or removed (T_REMOVED)
       file.

       It is desirable to preserve that behavior so lots of commitlog
       scripts won't die when they get this new code.  At the same
       time, we'd like to pass other information about the files (like
       version numbers, statuses, or checkin times).

       The solution is to allow a format string that allows us to
       specify those other pieces of information.  The format string
       will be composed of `%' followed by a single format character,
       or followed by a set of format characters surrounded by `{' and
       `}' as separators.  The format characters are:

         s = file name
	 V = old version number (pre-checkin)
	 v = new version number (post-checkin)

       For example, valid format strings are:

         %{}
	 %s
	 %{s}
	 %{sVv}

       There's no reason that more items couldn't be added (like
       modification date or file status [added, modified, updated,
       etc.]) -- the code modifications would be minimal (logmsg.c
       (title_proc) and commit.c (check_fileproc)).

       The output will be a string of tokens separated by spaces.  For
       backwards compatibility, the the first token will be the
       repository name.  The rest of the tokens will be
       comma-delimited lists of the information requested in the
       format string.  For example, if `/u/src/master' is the
       repository, `%{sVv}' is the format string, and three files
       (ChangeLog, Makefile, foo.c) were modified, the output might
       be:

         /u/src/master ChangeLog,1.1,1.2 Makefile,1.3,1.4 foo.c,1.12,1.13

       Why this duplicates the old behavior when the format string is
       `%s' is left as an exercise for the reader. */

    fmt_percent = strchr (filter, '%');
    if (fmt_percent)
    {
	int len;
	char *srepos;
	char *fmt_begin, *fmt_end;	/* beginning and end of the
					   format string specified in
					   filter. */
	char *fmt_continue;		/* where the string continues
					   after the format string (we
					   might skip a '}') somewhere
					   in there... */

	/* Grab the format string. */

	if ((*(fmt_percent + 1) == ' ') || (*(fmt_percent + 1) == '\0'))
	{
	    /* The percent stands alone.  This is an error.  We could
	       be treating ' ' like any other formatting character, but
	       using it as a formatting character seems like it would be
	       a mistake.  */

	    /* Would be nice to also be giving the line number.  */
	    error (0, 0, "loginfo: '%%' not followed by formatting character");
	    fmt_begin = fmt_percent + 1;
	    fmt_end = fmt_begin;
	    fmt_continue = fmt_begin;
	}
	else if (*(fmt_percent + 1) == '{')
	{
	    /* The percent has a set of characters following it. */

	    fmt_begin = fmt_percent + 2;
	    fmt_end = strchr (fmt_begin, '}');
	    if (fmt_end)
	    {
		/* Skip over the '}' character. */

		fmt_continue = fmt_end + 1;
	    }
	    else
	    {
		/* There was no close brace -- assume that format
                   string continues to the end of the line. */

		/* Would be nice to also be giving the line number.  */
		error (0, 0, "loginfo: '}' missing");
		fmt_end = fmt_begin + strlen (fmt_begin);
		fmt_continue = fmt_end;
	    }
	}
	else
	{
	    /* The percent has a single character following it.  FIXME:
	       %% should expand to a regular percent sign.  */

	    fmt_begin = fmt_percent + 1;
	    fmt_end = fmt_begin + 1;
	    fmt_continue = fmt_end;
	}

	len = fmt_end - fmt_begin;
	str_list_format = xmalloc (len + 1);
	strncpy (str_list_format, fmt_begin, len);
	str_list_format[len] = '\0';

	/* Allocate an initial chunk of memory.  As we build up the string
	   we will realloc it.  */
	if (!str_list)
	    str_list = xmalloc (1);
	str_list[0] = '\0';

	/* Add entries to the string.  Don't bother looking for
           entries if the format string is empty. */

	if (str_list_format[0] != '\0')
	{
	    type = T_TITLE;
	    (void) walklist (changes, title_proc, NULL);
	    type = T_ADDED;
	    (void) walklist (changes, title_proc, NULL);
	    type = T_MODIFIED;
	    (void) walklist (changes, title_proc, NULL);
	    type = T_REMOVED;
	    (void) walklist (changes, title_proc, NULL);
	}

	free (str_list_format);
	
	/* Construct the final string. */

	srepos = Short_Repository (repository);

	prog = cp = xmalloc ((fmt_percent - filter) + 2 * strlen (srepos)
			+ 2 * strlen (str_list) + strlen (fmt_continue)
			+ 10);
	(void) memcpy (cp, filter, fmt_percent - filter);
	cp += fmt_percent - filter;
	*cp++ = '"';
	cp = shell_escape (cp, srepos);
	cp = shell_escape (cp, str_list);
	*cp++ = '"';
	(void) strcpy (cp, fmt_continue);
	    
	/* To be nice, free up some memory. */

	free (str_list);
	str_list = (char *) NULL;
    }
    else
    {
	/* There's no format string. */
	prog = xstrdup (filter);
    }

    if ((pipefp = run_popen (prog, "w")) == NULL)
    {
	if (!noexec)
	    error (0, 0, "cannot write entry to log filter: %s", prog);
	free (prog);
	return (1);
    }
    (void) fprintf (pipefp, "Update of %s\n", repository);
    (void) fprintf (pipefp, "In directory %s:", hostname);
    cp = xgetwd ();
    if (cp == NULL)
	fprintf (pipefp, "<cannot get working directory: %s>\n\n",
		 strerror (errno));
    else
    {
	fprintf (pipefp, "%s\n\n", cp);
	free (cp);
    }

    setup_tmpfile (pipefp, "", changes);
    (void) fprintf (pipefp, "Log Message:\n%s\n", (message) ? message : "");
    if (logfp != (FILE *) 0)
    {
	(void) fprintf (pipefp, "Status:\n");
	rewind (logfp);
	while ((c = getc (logfp)) != EOF)
	    (void) putc ((char) c, pipefp);
    }
    free (prog);
    pipestatus = pclose (pipefp);
    return ((pipestatus == -1) || (pipestatus == 127)) ? 1 : 0;
}



/*  This routine is calld by Parse_Info.  It picks up the name of the
 *  message verification script.
 */
static int
verifymsg_proc(char *repository, char *script, void *closure)
{
    char **verifymsg_script = (char **)closure;
    if (*verifymsg_script && strcmp (*verifymsg_script, script) == 0)
	return (0);
    if (*verifymsg_script)
	free (*verifymsg_script);
    *verifymsg_script = xstrdup (script);
    return (0);
}
