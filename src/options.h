/*
 * Copyright (c) 1992, Brian Berliner and Jeff Polk
 * Copyright (c) 1989-1992, Brian Berliner
 * 
 * You may distribute under the terms of the GNU General Public License as
 * specified in the README file that comes with the CVS source distribution.
 * 
 * This file holds (most of) the configuration tweaks that can be made to
 * customize CVS for your site.  CVS comes configured for a typical SunOS 4.x
 * environment.  The comments for each configurable item are intended to be
 * self-explanatory.  All #defines are tested first to see if an over-riding
 * option was specified on the "make" command line.
 * 
 * If special libraries are needed, you will have to edit the Makefile.in file
 * or the configure script directly.  Sorry.
 */

/* By default, CVS stores its modules and other such items in flat
   text files (MY_NDBM enables this).  Turning off MY_NDBM causes CVS
   to look for a system-supplied ndbm database library and use it
   instead.  That may speed things up, but the default setting
   generally works fine too.  */

#ifndef MY_NDBM
#define	MY_NDBM
#endif

/* Directory used for storing temporary files, if not overridden by
   environment variables or the -T global option.  There should be little
   need to change this (-T is a better mechanism if you need to use a
   different directory for temporary files).  */
#ifndef TMPDIR_DFLT
#define	TMPDIR_DFLT	"/tmp"
#endif

/*
 * The default editor to use, if one does not specify the "-e" option
 * to cvs, or does not have an EDITOR environment variable.  I set
 * this to just "vi", and use the shell to find where "vi" actually
 * is.  This allows sites with /usr/bin/vi or /usr/ucb/vi to work
 * equally well (assuming that your PATH is reasonable).
 */
#ifndef EDITOR_DFLT
#define	EDITOR_DFLT	"vi"
#endif

/*
 * The default umask to use when creating or otherwise setting file or
 * directory permissions in the repository.  Must be a value in the
 * range of 0 through 0777.  For example, a value of 002 allows group
 * rwx access and world rx access; a value of 007 allows group rwx
 * access but no world access.  This value is overridden by the value
 * of the CVSUMASK environment variable, which is interpreted as an
 * octal number.
 */
#ifndef UMASK_DFLT
#define	UMASK_DFLT	002
#endif

/*
 * The cvs admin command is restricted to the members of the group
 * CVS_ADMIN_GROUP.  If this group does not exist, all users are
 * allowed to run cvs admin.  To disable the cvs admin for all users,
 * create an empty group CVS_ADMIN_GROUP.  To disable access control
 * for cvs admin, comment out the define below.
 */
#ifndef CVS_ADMIN_GROUP
#define CVS_ADMIN_GROUP "cvsadmin"
#endif

/*
 * When committing or importing files, you must enter a log message.
 * Normally, you can do this either via the -m flag on the command
 * line or an editor will be started for you.  If you like to use
 * logging templates (the rcsinfo file within the $CVSROOT/CVSROOT
 * directory), you might want to force people to use the editor even
 * if they specify a message with -m.  Enabling FORCE_USE_EDITOR will
 * cause the -m message to be appended to the temp file when the
 * editor is started.
 */
#ifndef FORCE_USE_EDITOR
/* #define 	FORCE_USE_EDITOR */
#endif

/*
 * When locking the repository, some sites like to remove locks and
 * assume the program that created them went away if the lock has
 * existed for a long time.  This used to be the default for previous
 * versions of CVS.  CVS now attempts to be much more robust, so lock
 * files should not be left around by mistake. The new behaviour will
 * never remove old locks (they must now be removed by hand).
 * Enabling CVS_FUDGELOCKS will cause CVS to remove locks that are
 * older than CVSLCKAGE seconds.
 * 
 * Use of this option is NOT recommended.
 */
#ifndef CVS_FUDGELOCKS
/* #define CVS_FUDGELOCKS */
#endif

/* Define this to enable the SETXID support.  The way to use this is
   to create a group with no users in it (except perhaps cvs
   administrators), set the cvs executable to setgid that group, chown
   all the repository files to that group, and change all directory
   permissions in the repository to 770.  The last person to modify a
   file will own it, but as long as directory permissions are set
   right that won't matter.  You'll need a system which inherits file
   groups from the parent directory (WARNING: using the wrong kind of
   system (I think Solaris 2.4 is the wrong kind, for example) will
   create a security hole!  You will receive no warning other than the
   fact that files in the working directory are owned by the group
   which cvs is setgid to).

   One security hole which has been reported is that setgid is not
   turned off when the editor is invoked--most editors provide a way
   to execute a shell, or the user can specify an editor (this one is
   large enough to drive a truck through).  Don't assume that the
   holes described here are the only ones; I don't know how carefully
   SETXID has been inspected for security holes.  */
#ifndef SETXID_SUPPORT
/* #define SETXID_SUPPORT */
#endif

/*
 * Should we build the password-authenticating client?  Whether to
 * include the password-authenticating _server_, on the other hand, is
 * set in config.h.
 */
#ifdef CLIENT_SUPPORT
#define AUTH_CLIENT_SUPPORT 1
#endif


/* End of CVS configuration section */

/*
 * Externs that are included in libc, but are used frequently enough
 * to warrant defining here.
 */
#ifndef STDC_HEADERS
extern void exit ();
#endif
