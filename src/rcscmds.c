/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 * 
 * The functions in this file provide an interface for performing 
 * operations directly on RCS files. 
 */

#include "cvs.h"
#include <assert.h>

/* This file, rcs.h, and rcs.c, are intended to define our interface
   to RCS files.  There is only one place outside this file that execs
   RCS commands directly--admin.c.  The intended long-term direction
   is to have CVS access RCS files via an RCS library (rcs.c can be
   considered a start at one), for performance, cleanliness (CVS has
   some awful hacks to work around RCS behaviors which don't make
   sense for CVS), installation hassles, ease of implementing the CVS
   server (I don't think that the output-out-of-order bug can be
   completely fixed as long as CVS calls RCS), and perhaps other
   reasons.

   Whether there will also be a version of RCS which uses this
   library, or whether the library will be packaged for uses beyond
   CVS or RCS (many people would like such a thing) is an open
   question.  Some considerations:

   1.  An RCS library for CVS must have the capabilities of the
   existing CVS code which accesses RCS files.  In particular, simple
   approaches will often be slow.

   2.  An RCS library should not use the code from the current RCS
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
   for more on a diff library.  */

static void RCS_output_diff_options PROTO ((char *, char *, char *, char *));


/* Stuff to deal with passing arguments the way libdiff.a wants to deal
   with them.  This is a crufty interface; there is no good reason for it
   to resemble a command line rather than something closer to "struct
   log_data" in log.c.  */

#ifdef HAVE_VPRINTF
#  if defined (USE_PROTOTYPES) ? USE_PROTOTYPES : defined (__STDC__)
#    include <stdarg.h>
#    define VA_START(args, lastarg) va_start(args, lastarg)
#  else
#    include <varargs.h>
#    define VA_START(args, lastarg) va_start(args)
#  endif
#else
you lose
#endif

/* First call call_diff_setup to setup any initial
   arguments.  The arguments to run_setup are essentially like printf().  The
   arguments will be parsed into whitespace separated words and added to the
   global call_diff_argv list.

   Then, optionally, call call_diff_arg for each additional argument
   that you'd like to pass to the diff library.

   Finally, call call_diff or call_diff3 to produce the diffs.  */

static char **call_diff_argv;
static int call_diff_argc;
static int call_diff_argc_allocated;

static void call_diff_add_arg PROTO ((const char *));
#ifdef HAVE_VPRINTF
static void call_diff_setup PROTO ((const char *fmt,...));
#else
you lose
#endif
static int call_diff PROTO ((char *out));
static int call_diff3 PROTO ((char *out));

/* VARARGS */
#if defined (HAVE_VPRINTF) && (defined (USE_PROTOTYPES) ? USE_PROTOTYPES : defined (__STDC__))
static void 
call_diff_setup (const char *fmt,...)
#else
static void 
call_diff_setup (fmt, va_alist)
    char *fmt;
    va_dcl
#endif
{
#ifdef HAVE_VPRINTF
    va_list args;
#endif
    char *cp;
    int i;
    char *call_diff_prog;

    /* clean out any malloc'ed values from call_diff_argv */
    for (i = 0; i < call_diff_argc; i++)
    {
	if (call_diff_argv[i])
	{
	    free (call_diff_argv[i]);
	    call_diff_argv[i] = (char *) 0;
	}
    }
    call_diff_argc = 0;

    /* process the varargs into call_diff_prog */
#ifdef HAVE_VPRINTF
    VA_START (args, fmt);
    (void) vasprintf (&call_diff_prog, fmt, args);
    va_end (args);
#else
    you lose
#endif
    if (call_diff_prog == NULL)
	error (1, 0, "out of memory");

    /* put each word into call_diff_argv, allocating it as we go */
    for (cp = strtok (call_diff_prog, " \t");
	 cp != NULL;
	 cp = strtok ((char *) NULL, " \t"))
	call_diff_add_arg (cp);
    free (call_diff_prog);
}

static void
call_diff_arg (s)
    const char *s;
{
    call_diff_add_arg (s);
}

static void
call_diff_add_arg (s)
    const char *s;
{
    /* allocate more argv entries if we've run out */
    if (call_diff_argc >= call_diff_argc_allocated)
    {
	call_diff_argc_allocated += 50;
	call_diff_argv = (char **)
	    xrealloc ((char *) call_diff_argv,
		      call_diff_argc_allocated * sizeof (char **));
    }

    if (s)
	call_diff_argv[call_diff_argc++] = xstrdup (s);
    else
	/* Not post-incremented on purpose!  */
	call_diff_argv[call_diff_argc] = (char *) 0;
}

/* diff_run is imported from libdiff.a. */
extern int diff_run PROTO ((int argc, char **argv, char *out));

static int
call_diff (out)
    char *out;
{
    /* Try to keep the out-of-order bugs at bay (protocol_pipe for cvs_output
       with has "Index: foo" and such; stdout and/or stderr for diff's
       output).  I think the only reason that this used to not be such
       a problem is that the time spent on the fork() and exec() of diff
       slowed us down enough to let the "Index:" make it through first.

       The real fix, of course, will be to have the diff library do all
       its output through callbacks (which CVS will supply as cvs_output
       and cvs_outerr).  */
    sleep (1);

    if (out == RUN_TTY)
	return diff_run (call_diff_argc, call_diff_argv, NULL);
    else
	return diff_run (call_diff_argc, call_diff_argv, out);
}

extern int diff3_run PROTO ((int argc, char **argv, char *out));

static int
call_diff3 (out)
    char *out;
{
    /* Try to keep the out-of-order bugs at bay (protocol_pipe for cvs_output
       with has "Index: foo" and such; stdout and/or stderr for diff's
       output).  I think the only reason that this used to not be such
       a problem is that the time spent on the fork() and exec() of diff
       slowed us down enough to let the "Index:" make it through first.

       The real fix, of course, will be to have the diff library do all
       its output through callbacks (which CVS will supply as cvs_output
       and cvs_outerr).  */
    sleep (1);

    if (out == RUN_TTY)
	return diff3_run (call_diff_argc, call_diff_argv, NULL);
    else
	return diff3_run (call_diff_argc, call_diff_argv, out);
}



/* Merge revisions REV1 and REV2. */

int
RCS_merge(rcs, path, workfile, options, rev1, rev2)
    RCSNode *rcs;
    char *path;
    char *workfile;
    char *options;
    char *rev1;
    char *rev2;
{
    char *xrev1, *xrev2;
    char *tmp1, *tmp2;
    char *diffout = NULL;
    int retval;

    if (options != NULL && options[0] != '\0')
      assert (options[0] == '-' && options[1] == 'k');

    cvs_output ("RCS file: ", 0);
    cvs_output (rcs->path, 0);
    cvs_output ("\n", 1);

    /* Calculate numeric revision numbers from rev1 and rev2 (may be
       symbolic). */
    xrev1 = RCS_gettag (rcs, rev1, 0, NULL);
    xrev2 = RCS_gettag (rcs, rev2, 0, NULL);

    /* Check out chosen revisions.  The error message when RCS_checkout
       fails is not very informative -- it is taken verbatim from RCS 5.7,
       and relies on RCS_checkout saying something intelligent upon failure. */
    cvs_output ("retrieving revision ", 0);
    cvs_output (xrev1, 0);
    cvs_output ("\n", 1);

    tmp1 = cvs_temp_name();
    if (RCS_checkout (rcs, NULL, xrev1, rev1, options, tmp1,
		      (RCSCHECKOUTPROC)0, NULL))
    {
	cvs_outerr ("rcsmerge: co failed\n", 0);
	error_exit();
    }

    cvs_output ("retrieving revision ", 0);
    cvs_output (xrev2, 0);
    cvs_output ("\n", 1);

    tmp2 = cvs_temp_name();
    if (RCS_checkout (rcs, NULL, xrev2, rev2, options, tmp2,
		      (RCSCHECKOUTPROC)0, NULL))
    {
	cvs_outerr ("rcsmerge: co failed\n", 0);
	error_exit();
    }

    /* Merge changes. */
    cvs_output ("Merging differences between ", 0);
    cvs_output (xrev1, 0);
    cvs_output (" and ", 0);
    cvs_output (xrev2, 0);
    cvs_output (" into ", 0);
    cvs_output (workfile, 0);
    cvs_output ("\n", 1);

    /* Remember that the first word in the `call_diff_setup' string is used now
       only for diagnostic messages -- CVS no longer forks to run diff3. */
    diffout = cvs_temp_name();
    call_diff_setup ("diff3 -E -am -L%s -L%s -L%s %s %s %s", workfile, xrev1,
	       xrev2, workfile, tmp1, tmp2);

    retval = call_diff3 (diffout);

    if (retval == 1)
	cvs_outerr ("rcsmerge: warning: conflicts during merge\n", 0);
    else if (retval == 2)
	error_exit();

    if (diffout)
	copy_file (diffout, workfile);

    /* Clean up. */
    {
	int save_noexec = noexec;
	noexec = 0;
	if (unlink_file (tmp1) < 0)
	{
	    if (!existence_error (errno))
		error (0, errno, "cannot remove temp file %s", tmp1);
	}
	free (tmp1);
	if (unlink_file (tmp2) < 0)
	{
	    if (!existence_error (errno))
		error (0, errno, "cannot remove temp file %s", tmp2);
	}
	free (tmp2);
	if (diffout)
	{
	    if (unlink_file (diffout) < 0)
	    {
		if (!existence_error (errno))
		    error (0, errno, "cannot remove temp file %s", diffout);
	    }
	    free (diffout);
	}
	noexec = save_noexec;
    }

    return retval;
}

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

   This used to exec rcsdiff, but now uses RCS_checkout and execs only
   DIFF.  The comments in options.h.in regarding the selection of
   a diff program need some revision, but I don't see a big
   issue here.  Another issue (which probably is an issue with or without
   changes to DIFF vs. rcsdiff), is what timezone is used for the dates
   which appear in the diff output.  rcsdiff uses the -z flag, which is not
   presently processed by CVS diff, but I'm not sure exactly how hard to worry
   about this--any such features are undocumented in the context
   of CVS, and I'm not sure how important to users.  */
int
RCS_exec_rcsdiff (rcsfile, opts, options, rev1, rev2, label1, label2, workfile)
    RCSNode *rcsfile;
    char *opts;
    char *options;
    char *rev1;
    char *rev2;
    char *label1;
    char *label2;
    char *workfile;
{
    char *tmpfile1;
    char *tmpfile2;
    char *use_file2;
    int status, retval;

    tmpfile1 = cvs_temp_name ();
    tmpfile2 = NULL;

    cvs_output ("\
===================================================================\n\
RCS file: ", 0);
    cvs_output (rcsfile->path, 0);
    cvs_output ("\n", 1);

    /* Historically, `cvs diff' has expanded the $Name keyword to the
       empty string when checking out revisions.  This is an accident,
       but no one has considered the issue thoroughly enough to determine
       what the best behavior is.  Passing NULL for the `nametag' argument
       preserves the existing behavior. */

    cvs_output ("retrieving revision ", 0);
    cvs_output (rev1, 0);
    cvs_output ("\n", 1);
    status = RCS_checkout (rcsfile, NULL, rev1, NULL, options, tmpfile1,
			   (RCSCHECKOUTPROC)0, NULL);
    if (status > 0)
    {
	retval = status;
	goto error_return;
    }
    else if (status < 0)
    {
	error (0, errno,
	       "cannot check out revision %s of %s", rev1, rcsfile->path);
	retval = 1;
	goto error_return;
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
			       tmpfile2, (RCSCHECKOUTPROC)0, NULL);
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

    RCS_output_diff_options (opts, rev1, rev2, workfile);
    status = diff_execv (tmpfile1, use_file2, label1, label2, opts, RUN_TTY);
    if (status >= 0)
    {
	retval = status;
	goto error_return;
    }
    else if (status < 0)
    {
	error (0, errno,
	       "cannot diff %s and %s", tmpfile1, use_file2);
	retval = 1;
	goto error_return;
    }

 error_return:
    {
	int save_noexec = noexec;
	noexec = 0;
	if (unlink_file (tmpfile1) < 0)
	{
	    if (!existence_error (errno))
		error (0, errno, "cannot remove temp file %s", tmpfile1);
	}
	noexec = save_noexec;
    }
    free (tmpfile1);
    if (tmpfile2 != NULL)
    {
	int save_noexec = noexec;
	noexec = 0;
	if (unlink_file (tmpfile2) < 0)
	{
	    if (!existence_error (errno))
		error (0, errno, "cannot remove temp file %s", tmpfile2);
	}
	noexec = save_noexec;
	free (tmpfile2);
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
diff_exec (file1, file2, options, out)
    char *file1;
    char *file2;
    char *options;
    char *out;
{
    /* The first word in this string is used only for error reporting. */
    call_diff_setup ("%s %s %s %s", DIFF, options, file1, file2);

    return call_diff (out);
}

int
diff_execv (file1, file2, label1, label2, options, out)
    char *file1;
    char *file2;
    char *label1;
    char *label2;
    char *options;
    char *out;
{
    call_diff_setup ("%s%s", DIFF, options);
    if (label1)
	call_diff_arg (label1);
    if (label2)
	call_diff_arg (label2);
    call_diff_arg (file1);
    call_diff_arg (file2);

    return call_diff (out);
}

/* Print the options passed to DIFF, in the format used by rcsdiff.
   The rcsdiff code that produces this output is extremely hairy, and
   it is not clear how rcsdiff decides which options to print and
   which not to print.  The code below reproduces every rcsdiff run
   that I have seen. */

static void
RCS_output_diff_options (opts, rev1, rev2, workfile)
    char *opts;
    char *rev1;
    char *rev2;
    char *workfile;
{
    char *tmp;

    tmp = (char *) xmalloc (strlen (opts) + strlen (rev1) + 10);

    sprintf (tmp, "diff%s -r%s", opts, rev1);
    cvs_output (tmp, 0);
    free (tmp);

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
