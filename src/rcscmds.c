/*
 * Copyright (C) 1986-2005 The Free Software Foundation, Inc.
 *
 * Portions Copyright (C) 1998-2005 Derek Price, Ximbiot <http://ximbiot.com>,
 *                                  and others.
 *
 * Portions Copyright (C) 1992, Brian Berliner and Jeff Polk
 * Portions Copyright (C) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 * 
 * The functions in this file provide an interface for performing 
 * operations directly on RCS files. 
 */

#ifdef HAVE_CONFIG_H
# include <config.h>
#endif

/* Standard headers.  */
#include <stdio.h>

/* GNULIB */
#include "quotearg.h"

/* CVS */
#include "difflib.h"
#include "cvs.h"

/* This file, rcs.h, and rcs.c, together sometimes known as the "RCS
   library", are intended to define our interface to RCS files.

   Whether there will also be a version of RCS which uses this
   library, or whether the library will be packaged for uses beyond
   CVS or RCS (many people would like such a thing) is an open
   question.  Some considerations:

   1.  An RCS library for CVS must have the capabilities of the
   existing CVS code which accesses RCS files.  In particular, simple
   approaches will often be slow.

   2.  An RCS library should not use code from the current RCS
   (5.7 and its ancestors).  The code has many problems.  Too few
   comments, too many layers of abstraction, too many global variables
   (the correct number for a library is zero), too much intricately
   interwoven functionality, and too many clever hacks.  Paul Eggert,
   the current RCS maintainer, agrees.

   3.  More work needs to be done in terms of separating out the RCS
   library from the rest of CVS (for example, cvs_output should be
   replaced by a callback, and the declarations should be centralized
   into rcs.h, and probably other such cleanups).

   4.  To be useful for RCS and perhaps for other uses, the library
   may need features beyond those needed by CVS.

   5.  Any changes to the RCS file format *must* be compatible.  Many,
   many tools (not just CVS and RCS) can at least import this format.
   RCS and CVS must preserve the current ability to import/export it
   (preferably improved--magic branches are currently a roadblock).
   See doc/RCSFILES in the CVS distribution for documentation of this
   file format.

   On a related note, see the comments at diff_exec, later in this file,
   for more on the diff library.  */

static void RCS_output_diff_options (int, char * const *, const char *,
				     const char *, const char *);


/* Stuff to deal with passing arguments the way libdiff.a wants to deal
   with them.  This is a crufty interface; there is no good reason for it
   to resemble a command line rather than something closer to "struct
   log_data" in log.c.  */



/* Diff revisions and/or files.  OPTS controls the format of the diff
   (it contains options such as "-w -c", &c), or "" for the default.
   OPTIONS controls keyword expansion, as a string starting with "-k",
   or "" to use the default.  REV1 is the first revision to compare
   against; it must be non-NULL.  If REV2 is non-NULL, compare REV1
   and REV2; if REV2 is NULL compare REV1 with the file in the working
   directory, whose name is WORKFILE.  LABEL1 and LABEL2 are default
   file labels, and (if non-NULL) should be added as -L options
   to diff.  Output goes to stdout.

   Return value is 0 for success, -1 for a failure which set errno,
   or positive for a failure which printed a message on stderr.

   This used to exec rcsdiff, but now calls RCS_checkout and diff_exec.

   An issue is what timezone is used for the dates which appear in the
   diff output.  rcsdiff uses the -z flag, which is not presently
   processed by CVS diff, but I'm not sure exactly how hard to worry
   about this--any such features are undocumented in the context of
   CVS, and I'm not sure how important to users.  */
int
RCS_exec_rcsdiff (RCSNode *rcsfile, int diff_argc,
		  char * const *diff_argv, const char *options,
                  const char *rev1, const char *rev1_cache, const char *rev2,
                  const char *label1, const char *label2, const char *workfile)
{
    char *tmpfile1 = NULL;
    char *tmpfile2 = NULL;
    const char *use_file1, *use_file2;
    int status, retval;


    cvs_output ("\
===================================================================\n\
RCS file: ", 0);
    cvs_output (rcsfile->print_path, 0);
    cvs_output ("\n", 1);

    /* Historically, `cvs diff' has expanded the $Name keyword to the
       empty string when checking out revisions.  This is an accident,
       but no one has considered the issue thoroughly enough to determine
       what the best behavior is.  Passing NULL for the `nametag' argument
       preserves the existing behavior. */

    cvs_output ("retrieving revision ", 0);
    cvs_output (rev1, 0);
    cvs_output ("\n", 1);

    if (rev1_cache != NULL)
	use_file1 = rev1_cache;
    else
    {
	tmpfile1 = cvs_temp_name();
	status = RCS_checkout (rcsfile, NULL, rev1, NULL, options, tmpfile1,
	                       NULL, NULL);
	if (status > 0)
	{
	    retval = status;
	    goto error_return;
	}
	else if (status < 0)
	{
	    error( 0, errno,
	           "cannot check out revision %s of %s", rev1, rcsfile->path );
	    retval = 1;
	    goto error_return;
	}
	use_file1 = tmpfile1;
    }

    if (rev2 == NULL)
    {
	assert (workfile != NULL);
	use_file2 = workfile;
    }
    else
    {
	tmpfile2 = cvs_temp_name ();
	cvs_output ("retrieving revision ", 0);
	cvs_output (rev2, 0);
	cvs_output ("\n", 1);
	status = RCS_checkout (rcsfile, NULL, rev2, NULL, options,
			       tmpfile2, NULL, NULL);
	if (status > 0)
	{
	    retval = status;
	    goto error_return;
	}
	else if (status < 0)
	{
	    error (0, errno,
		   "cannot check out revision %s of %s", rev2, rcsfile->path);
	    return 1;
	}
	use_file2 = tmpfile2;
    }

    RCS_output_diff_options (diff_argc, diff_argv, rev1, rev2, workfile);
    status = diff_exec (use_file1, use_file2, label1, label2,
			diff_argc, diff_argv, RUN_TTY);
    if (status >= 0)
    {
	retval = status;
	goto error_return;
    }
    else if (status < 0)
    {
	error (0, errno,
	       "cannot diff %s and %s", use_file1, use_file2);
	retval = 1;
	goto error_return;
    }

 error_return:
    {
	/* Call CVS_UNLINK() below rather than unlink_file to avoid the check
	 * for noexec.
	 */
	if( tmpfile1 != NULL )
	{
	    if( CVS_UNLINK( tmpfile1 ) < 0 )
	    {
		if( !existence_error( errno ) )
		    error( 0, errno, "cannot remove temp file %s", tmpfile1 );
	    }
	    free( tmpfile1 );
	}
	if( tmpfile2 != NULL )
	{
	    if( CVS_UNLINK( tmpfile2 ) < 0 )
	    {
		if( !existence_error( errno ) )
		    error( 0, errno, "cannot remove temp file %s", tmpfile2 );
	    }
	    free (tmpfile2);
	}
    }

    return retval;
}



/* Show differences between two files.  This is the start of a diff library.

   Some issues:

   * Should option parsing be part of the library or the caller?  The
   former allows the library to add options without changing the callers,
   but it causes various problems.  One is that something like --brief really
   wants special handling in CVS, and probably the caller should retain
   some flexibility in this area.  Another is online help (the library could
   have some feature for providing help, but how does that interact with
   the help provided by the caller directly?).  Another is that as things
   stand currently, there is no separate namespace for diff options versus
   "cvs diff" options like -l (that is, if the library adds an option which
   conflicts with a CVS option, it is trouble).

   * This isn't required for a first-cut diff library, but if there
   would be a way for the caller to specify the timestamps that appear
   in the diffs (rather than the library getting them from the files),
   that would clean up the kludgy utime() calls in patch.c.

   Show differences between FILE1 and FILE2.  Either one can be
   DEVNULL to indicate a nonexistent file (same as an empty file
   currently, I suspect, but that may be an issue in and of itself).
   OPTIONS is a list of diff options, or "" if none.  At a minimum,
   CVS expects that -c (update.c, patch.c) and -n (update.c) will be
   supported.  Other options, like -u, --speed-large-files, &c, will
   be specified if the user specified them.

   OUT is a filename to send the diffs to, or RUN_TTY to send them to
   stdout.  Error messages go to stderr.  Return value is 0 for
   success, -1 for a failure which set errno, 1 for success (and some
   differences were found), or >1 for a failure which printed a
   message on stderr.  */

int
diff_exec (const char *file1, const char *file2, const char *label1,
           const char *label2, int dargc, char * const *dargv,
	   const char *out)
{
    TRACE (TRACE_FUNCTION, "diff_exec (%s, %s, %s, %s, %s)",
	   file1, file2, label1, label2, out);

#ifdef PRESERVE_PERMISSIONS_SUPPORT
    /* If either file1 or file2 are special files, pretend they are
       /dev/null.  Reason: suppose a file that represents a block
       special device in one revision becomes a regular file.  CVS
       must find the `difference' between these files, but a special
       file contains no data useful for calculating this metric.  The
       safe thing to do is to treat the special file as an empty file,
       thus recording the regular file's full contents.  Doing so will
       create extremely large deltas at the point of transition
       between device files and regular files, but this is probably
       very rare anyway.

       There may be ways around this, but I think they are fraught
       with danger. -twp */

    if (preserve_perms &&
	strcmp (file1, DEVNULL) != 0 &&
	strcmp (file2, DEVNULL) != 0)
    {
	struct stat sb1, sb2;

	if (lstat (file1, &sb1) < 0)
	    error (1, errno, "cannot get file information for %s", file1);
	if (lstat (file2, &sb2) < 0)
	    error (1, errno, "cannot get file information for %s", file2);

	if (!S_ISREG (sb1.st_mode) && !S_ISDIR (sb1.st_mode))
	    file1 = DEVNULL;
	if (!S_ISREG (sb2.st_mode) && !S_ISDIR (sb2.st_mode))
	    file2 = DEVNULL;
    }
#endif

    /* The first arg to call_diff_setup is used only for error reporting. */
    call_diff_setup ("diff", dargc, dargv);
    if (label1)
	call_diff_add_arg (label1);
    if (label2)
	call_diff_add_arg (label2);
    call_diff_add_arg ("--");
    call_diff_add_arg (file1);
    call_diff_add_arg (file2);

    return call_diff (out);
}

/* Print the options passed to DIFF, in the format used by rcsdiff.
   The rcsdiff code that produces this output is extremely hairy, and
   it is not clear how rcsdiff decides which options to print and
   which not to print.  The code below reproduces every rcsdiff run
   that I have seen. */

static void
RCS_output_diff_options (int diff_argc, char * const *diff_argv,
			 const char *rev1, const char *rev2,
                         const char *workfile)
{
    int i;
    
    cvs_output ("diff", 0);
    for (i = 0; i < diff_argc; i++)
    {
        cvs_output (" ", 1);
	cvs_output (quotearg_style (shell_quoting_style, diff_argv[i]), 0);
    }
    cvs_output (" -r", 3);
    cvs_output (rev1, 0);

    if (rev2)
    {
	cvs_output (" -r", 3);
	cvs_output (rev2, 0);
    }
    else
    {
	assert (workfile != NULL);
	cvs_output (" ", 1);
	cvs_output (workfile, 0);
    }
    cvs_output ("\n", 1);
}
