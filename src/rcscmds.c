/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS 1.4 kit.
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

/* For RCS file PATH, make symbolic tag TAG point to revision REV.
   This validates that TAG is OK for a user to use.  Return value is
   -1 for error (and errno is set to indicate the error), positive for
   error (and an error message has been printed), or zero for success.  */

int
RCS_exec_settag(path, tag, rev)
    const char *path;
    const char *tag;
    const char *rev;
{
    run_setup ("%s%s -x,v/ -q -N%s:%s", Rcsbin, RCS, tag, rev);
    run_arg (path);
    return run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL);
}

/* NOERR is 1 to suppress errors--FIXME it would
   be better to avoid the errors or some cleaner solution.  */
int
RCS_exec_deltag(path, tag, noerr)
    const char *path;
    const char *tag;
    int noerr;
{
    run_setup ("%s%s -x,v/ -q -N%s", Rcsbin, RCS, tag);
    run_arg (path);
    return run_exec (RUN_TTY, RUN_TTY, noerr ? DEVNULL : RUN_TTY, RUN_NORMAL);
}

/* set RCS branch to REV */
int
RCS_exec_setbranch(path, rev)
    const char *path;
    const char *rev;
{
    run_setup ("%s%s -x,v/ -q -b%s", Rcsbin, RCS, rev ? rev : "");
    run_arg (path);
    return run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL);
}

/* Lock revision REV.  NOERR is 1 to suppress errors--FIXME it would
   be better to avoid the errors or some cleaner solution.  */
int
RCS_exec_lock(path, rev, noerr)
    const char *path;
    const char *rev;
    int noerr;
{
    run_setup ("%s%s -x,v/ -q -l%s", Rcsbin, RCS, rev ? rev : "");
    run_arg (path);
    return run_exec (RUN_TTY, RUN_TTY, noerr ? DEVNULL : RUN_TTY, RUN_NORMAL);
}

/* Unlock revision REV.  NOERR is 1 to suppress errors--FIXME it would
   be better to avoid the errors or some cleaner solution.  */
int
RCS_exec_unlock(path, rev, noerr)
    const char *path;
    const char *rev;
    int noerr;
{
    run_setup ("%s%s -x,v/ -q -u%s", Rcsbin, RCS, rev ? rev : "");
    run_arg (path);
    return run_exec (RUN_TTY, RUN_TTY, noerr ? DEVNULL : RUN_TTY, RUN_NORMAL);
}

/* Merge revisions REV1 and REV2. */
int
RCS_merge(path, options, rev1, rev2)
     const char *path;
     const char *options;
     const char *rev1;
     const char *rev2;
{
    int status;

    /* XXX - Do merge by hand instead of using rcsmerge, due to -k handling */

    run_setup ("%s%s -x,v/ %s -r%s -r%s %s", Rcsbin, RCS_RCSMERGE,
	       options, rev1, rev2, path);
    status = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL);
#ifndef HAVE_RCS5
    if (status == 0) 
    {
	error (1, 0, "CVS no longer supports RCS versions older than RCS5");
	/* This case needs to call file_has_markers to see if the file
	   contains conflict indicators.  But is anyone using the !HAVE_RCS5
	   code any more?  */
    }
#endif
    return status;
}

/* Check in to RCSFILE with revision REV (which must be greater than the
   largest revision) and message MESSAGE (which is checked for legality).
   If FLAGS & RCS_FLAGS_DEAD, check in a dead revision.  If FLAGS &
   RCS_FLAGS_QUIET, tell ci to be quiet.  If FLAGS & RCS_FLAGS_MODTIME,
   use the working file's modification time for the checkin time.
   WORKFILE is the working file to check in from, or NULL to use the usual
   RCS rules for deriving it from the RCSFILE.
   
   Return value is -1 for error (and errno is set to indicate the
   error), positive for error (and an error message has been printed),
   or zero for success.  */
int
RCS_checkin (rcsfile, workfile, message, rev, flags)
    char *rcsfile;
    char *workfile;
    char *message;
    char *rev;
    int flags;
{
    /* The desired behavior regarding permissions is to preserve the
       permissions on RCSFILE if it already exists.  Based on looking
       at the RCS 5.7 source, it would appear that RCS_CI does this
       except when it is creating RCSFILE (reasonable), or when
       RCSFILE was created with rcs -i (this is strange, and quite
       possibly unintentional).  In those two cases it copies the
       permissions from the workfile.

       Anyway, the fix is simple enough: we preserve the mode ourself.  */
    struct stat sb;
    int fix_mode = 1;
    int retval;

    if (CVS_STAT (rcsfile, &sb) < 0)
    {
	fix_mode = 0;
	if (!existence_error (errno))
	    error (0, errno, "warning: cannot stat %s", rcsfile);
    }
    run_setup ("%s%s -x,v/ -w%s -f %s%s", Rcsbin, RCS_CI, getcaller (),
	       rev ? "-r" : "", rev ? rev : "");
    if (flags & RCS_FLAGS_DEAD)
	run_arg ("-sdead");
    if (flags & RCS_FLAGS_QUIET)
	run_arg ("-q");
    if (flags & RCS_FLAGS_MODTIME)
	run_arg ("-d");
    run_args ("-m%s", make_message_rcslegal (message));
    if (workfile != NULL)
	run_arg (workfile);
    run_arg (rcsfile);
    retval = run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_NORMAL);
    if (retval == 0 && fix_mode)
    {
	if (chmod (rcsfile, sb.st_mode) < 0)
	    error (0, errno, "warning: cannot change permissions on %s",
		   rcsfile);
    }
    return retval;
}

/* Diff revisions and/or files.  OPTS controls the format of the diff
   (it contains options such as "-w -c", &c), or "" for the default.
   OPTIONS controls keyword expansion, as a string starting with "-k",
   or "" to use the default.  REV1 is the first revision to compare
   against; it must be non-NULL.  If REV2 is non-NULL, compare REV1
   and REV2; if REV2 is NULL compare REV1 with the file in the working
   directory.  Output goes to stdout.

   Return value is 0 for success, -1 for a failure which set errno,
   or positive for a failure which printed a message on stderr.

   It would be relatively easy to convert this to use RCS_checkout
   and DIFF.  The comments in options.h.in regarding the selection of
   a diff program would need some revision, but I don't see a big
   issue here.  Another issue (which probably is an issue with or without
   changes to DIFF vs. rcsdiff), is what timezone is used for the dates
   which appear in the diff output.  I suspect that rcsdiff's behavior
   is different from DIFF's, but I'm not sure exactly how hard to worry
   about this--any such features are undocumented in the context
   of CVS, and I'm not sure how important to users.  */
int
RCS_exec_rcsdiff (rcsfile, opts, options, rev1, rev2)
    char *rcsfile;
    char *opts;
    char *options;
    char *rev1;
    char *rev2;
{
    if (rev2 != NULL)
    {
	run_setup ("%s%s -x,v/ %s %s -r%s -r%s", Rcsbin, RCS_DIFF,
		   opts, options, rev1, rev2);
    }
    else
    {
	run_setup ("%s%s -x,v/ %s %s -r%s", Rcsbin, RCS_DIFF, opts,
		   options, rev1);
    }
    run_arg (rcsfile);
    return run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_REALLY|RUN_COMBINED);
}


/* Show differences between two files.  This is the start of a diff library.

   Some issues:

   1.  Should option parsing be part of the library or the caller?  The
   former allows the library to add options without changing the callers,
   but it causes various problems.  One is that something like --brief really
   wants special handling in CVS, and probably the caller should retain
   some flexibility in this area.  Another is online help (the library could
   have some feature for providing help, but how does that interact with
   the help provided by the caller directly?).  Another is that as things
   stand currently, there is no separate namespace for diff options versus
   "cvs diff" options like -l (that is, if the library adds an option which
   conflicts with a CVS option, it is trouble).

   2.  Should there be a way of invoking an external diff program?  This is
   pretty much orthogonal to the issue of a diff library.  The fact that
   CVS uses an external diff program isn't particularly useful for
   user-supplied diff programs because there is no way to distinguish
   between the various uses CVS makes of it (e.g. supply this to the user
   or supply this to the remote protocol), and because there is no way to
   pick a different user-supplied diff for different file types.

   3.  This isn't required for a first-cut diff library, but if there
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
    run_setup ("%s %s %s %s", DIFF, options, file1, file2);
    if (out == RUN_TTY)
	/* I'm not 100% sure about the need for RUN_COMBINED here.  But
	   the code I took this from had it, and I suspect it may
	   avoid some out-of-order bugs.  */
	return run_exec (RUN_TTY, RUN_TTY, RUN_TTY, RUN_REALLY | RUN_COMBINED);
    else
	return run_exec (RUN_TTY, out, RUN_TTY, RUN_REALLY);
}
