/* config.h --- configuration file for Windows NT
   Jim Blandy <jimb@cyclic.com> --- July 1995  */

/* This file lives in the windows-NT subdirectory, which is only included
   in your header search path if you're working under Microsoft Visual C++,
   and use ../cvsnt.mak for your project.  Thus, this is the right place to
   put configuration information for Windows NT.  */

/* Define if type char is unsigned and you are not using gcc.  */
/* We wrote a little test program whose output suggests that char is
   signed on this system.  Go back and check the verdict when CVS
   is configured on floss...  */
#undef __CHAR_UNSIGNED__

/* Windows NT has alloca, but calls it _alloca and says it returns
   void *.  We provide our own header file.  */
#define HAVE_ALLOCA 1
#define HAVE_ALLOCA_H 1
#undef C_ALLOCA
/* These shouldn't matter, but pro forma:  */
#undef CRAY_STACKSEG_END
#undef STACK_DIRECTION

/* Define to `int' if <sys/types.h> doesn't define.  */
/* Windows NT doesn't have gid_t.  It doesn't even really have group
   numbers, I think.  This will take more thought to get right, but
   let's get it running first.  */
#define gid_t int

/* Define if you support file names longer than 14 characters.  */
/* Yes.  Woo.  */
#define HAVE_LONG_FILE_NAMES 1

/* Define if you have <sys/wait.h> that is POSIX.1 compatible.  */
/* If POSIX.1 requires this, why doesn't WNT have it?  */
#undef HAVE_SYS_WAIT_H

/* Define if utime(file, NULL) sets file's timestamp to the present.  */
/* Experimentation says yes.  Wish I had the full documentation, but
   I have neither the CD-ROM nor a CD-ROM drive to put it in.  */
#define HAVE_UTIME_NULL 1

/* Define as __inline if that's what the C compiler calls it.  */
/* We apparently do have inline functions.  The 'inline' keyword is only
   available from C++, though.  You have to use '__inline' in C code.  */
#define inline __inline

/* Define if on MINIX.  */
/* Hah.  */
#undef _MINIX

/* Define to `int' if <sys/types.h> doesn't define.  */
#define mode_t int

/* Define to `int' if <sys/types.h> doesn't define.  */
#define pid_t int

/* Define if the system does not provide POSIX.1 features except
   with this defined.  */
/* This string doesn't appear anywhere in the system header files,
   so I assume it's irrelevant.  */
#undef _POSIX_1_SOURCE

/* Define if you need to in order for stat and other things to work.  */
/* Same as for _POSIX_1_SOURCE, above.  */
#undef _POSIX_SOURCE

/* Define as the return type of signal handlers (int or void).  */
/* The manual says they return void.  */
#define RETSIGTYPE void

/* Define to `unsigned' if <sys/types.h> doesn't define.  */
/* sys/types.h doesn't define it, but stdio.h does, which cvs.h
   #includes, so things should be okay.  */
/* #undef size_t */

/* Define if the `S_IS*' macros in <sys/stat.h> do not work properly.  */
/* We don't seem to have them at all; let ../lib/system.h define them.  */
#define STAT_MACROS_BROKEN 1
 
/* Define if you have the ANSI C header files.  */
/* We'd damn well better.  */
#define STDC_HEADERS 1

/* Define if you can safely include both <sys/time.h> and <time.h>.  */
/* We don't have <sys/time.h> at all.  Why isn't there a definition
   for HAVE_SYS_TIME_H anywhere in config.h.in?  */
#undef TIME_WITH_SYS_TIME
#undef HAVE_SYS_TIME_H

/* Define to `int' if <sys/types.h> doesn't define.  */
#define uid_t int

/* Define if you have MIT Kerberos version 4 available.  */
/* We don't.  Cygnus says they've ported it to Windows 3.1, but
   I don't know if that means that it works under Windows NT as
   well.  */
#undef HAVE_KERBEROS

/* The number of bytes in a int.  */
#define SIZEOF_INT 4

/* The number of bytes in a long.  */
#define SIZEOF_LONG 4

/* Define if you have the fchdir function.  */
#undef HAVE_FCHDIR

/* Define if you have the fchmod function.  */
#undef HAVE_FCHMOD

/* Define if you have the fsync function.  */
#undef HAVE_FSYNC

/* Define if you have the ftime function.  */
#define HAVE_FTIME 1

/* Define if you have the ftruncate function.  */
#undef HAVE_FTRUNCATE

/* Define if you have the getpagesize function.  */
#undef HAVE_GETPAGESIZE

/* Define if you have the krb_get_err_text function.  */
#undef HAVE_KRB_GET_ERR_TEXT

/* Define if you have the mkfifo function.  */
#undef HAVE_MKFIFO

/* Define if you have the putenv function.  */
#define HAVE_PUTENV 1

/* Define if you have the setvbuf function.  */
#define HAVE_SETVBUF 1

/* Define if you have the timezone function.  */
/* Hmm, I actually rather think it's an extern long
   variable; that message was mechanically generated
   by autoconf.  And I don't see any actual uses of
   this function in the code anyway, hmm.  */
#undef HAVE_TIMEZONE

/* Define if you have the vfork function.  */
#undef HAVE_VFORK

/* Define if you have the vprintf function.  */
#define HAVE_VPRINTF 1

/* Define if you have the <dirent.h> header file.  */
/* No, but we have the <direct.h> header file...  */
#undef HAVE_DIRENT_H

/* Define if you have the <errno.h> header file.  */
#define HAVE_ERRNO_H 1

/* Define if you have the <fcntl.h> header file.  */
#define HAVE_FCNTL_H 1

/* Define if you have the <memory.h> header file.  */
#define HAVE_MEMORY_H 1

/* Define if you have the <ndbm.h> header file.  */
#undef HAVE_NDBM_H

/* Define if you have the <ndir.h> header file.  */
#undef HAVE_NDIR_H

/* Define if you have the <string.h> header file.  */
#define HAVE_STRING_H 1

/* Define if you have the <sys/dir.h> header file.  */
#undef HAVE_SYS_DIR_H

/* Define if you have the <sys/ndir.h> header file.  */
#undef HAVE_SYS_NDIR_H

/* Define if you have the <sys/param.h> header file.  */	
#undef HAVE_SYS_PARAM_H

/* Define if you have the <sys/select.h> header file.  */
#undef HAVE_SYS_SELECT_H

/* Define if you have the <sys/timeb.h> header file.  */
#define HAVE_SYS_TIMEB_H 1

/* Define if you have the <unistd.h> header file.  */
#undef HAVE_UNISTD_H

/* Define if you have the <utime.h> header file.  */
#undef HAVE_UTIME_H

/* Define if you have the <io.h> header file.  */
/* Apparently this is where Windows NT declares all the low-level
   Unix I/O routines like open and creat and stuff.  */
#define HAVE_IO_H 1

/* Define if you have the <direct.h> header file.  */
/* Windows NT wants this for mkdir and friends.  */
#define HAVE_DIRECT_H 1

/* Define if you have the nsl library (-lnsl).  */
/* This is not used anywhere in the source code.  */
#undef HAVE_LIBNSL

/* Define if you have the socket library (-lsocket).  */
/* This isn't ever used either.  */
#undef HAVE_LIBSOCKET


