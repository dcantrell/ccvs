/* This file is generated via a rule in Makefile.am from the
 * config.h.in file.
 *
 * *** DO NOT EDIT THIS FILE DIRECTLY ***
 *
 * Edit config.h.in instead.
 */
/***
 *** ./config.h.in, generated by ./mkconfig:
 ***
 ***   (./config.h.in.in
 ***    + ../config.h.in)
 ***   . ./config.h.in.footer
 ***   --> ./config.h.in
 ***
 *** ***** DO NOT ALTER THIS FILE!!! *****
 ***
 *** Changes to this file will be overwritten by automatic script runs.
 *** Changes should be made to the ./config.h.in.in & ./config.h.in.footer
 *** files instead.
 ***/

/* config.h.in.  Generated from configure.in by autoheader.  */

/* Enable AUTH_CLIENT_SUPPORT to enable pserver as a remote access method in
   the CVS client (default) */
#define AUTH_CLIENT_SUPPORT 1

/* Define if you want to use the password authenticated server. */
#undef AUTH_SERVER_SUPPORT

/* Define if you want CVS to be able to be a remote repository client. */
#define CLIENT_SUPPORT

/* Define to 1 if the `closedir' function returns void instead of `int'. */
#undef CLOSEDIR_VOID

/* Define to one of `_getb67', `GETB67', `getb67' for Cray-2 and Cray-YMP
   systems. This function is required for `alloca.c' support on those systems.
   */
#undef CRAY_STACKSEG_END

/* define if cross compiling */
#undef CROSS_COMPILING

/* The CVS admin command is restricted to the members of the group
   CVS_ADMIN_GROUP. If this group does not exist, all users are allowed to run
   CVS admin. To disable the CVS admin command for all users, create an empty
   CVS_ADMIN_GROUP by running configure with the --with-cvs-admin-group=
   option. To disable access control for CVS admin, run configure with the
   --without-cvs-admin-group option in order to comment out the define below.
   */
#undef CVS_ADMIN_GROUP

/* When committing a permanent change, CVS and RCS make a log entry of who
   committed the change. If you are committing the change logged in as "root"
   (not under "su" or other root-priv giving program), CVS/RCS cannot
   determine who is actually making the change. As such, by default, CVS
   prohibits changes committed by users logged in as "root". You can disable
   checking by passing the "--enable-rootcommit" option to configure or by
   commenting out the lines below. */
#undef CVS_BADROOT

/* Define to 1 if using `alloca.c'. */
#undef C_ALLOCA

/* The default editor to use, if one does not specify the "-e" option to cvs,
   or does not have an EDITOR environment variable. If this is not set to an
   absolute path to an executable, use the shell to find where the editor
   actually is. This allows sites with /usr/bin/vi or /usr/ucb/vi to work
   equally well (assuming that their PATH is reasonable). */
#define EDITOR_DFLT "notepad"

/* Define to 1 if translation of program messages to the user's native
   language is requested. */
#undef ENABLE_NLS

/* Define to enable encryption support. */
#undef ENCRYPTION

/* Define as good substitute value for EOVERFLOW. */
#define EOVERFLOW EINVAL

/* Define if this executable will be running on case insensitive file systems.
   In the client case, this means that it will request that the server pretend
   to be case insensitive if it isn't already. */
#define FILENAMES_CASE_INSENSITIVE 1

/* Define on systems for which file names may have a so-called `drive letter'
   prefix, define this to compute the length of that prefix, including the
   colon. */
#define FILE_SYSTEM_ACCEPTS_DRIVE_LETTER_PREFIX 1

/* Define if the backslash character may also serve as a file name component
   separator. */
#define FILE_SYSTEM_BACKSLASH_IS_FILE_NAME_SEPARATOR 1

#if FILE_SYSTEM_ACCEPTS_DRIVE_LETTER_PREFIX
# define FILE_SYSTEM_PREFIX_LEN(Filename) \
  ((Filename)[0] && (Filename)[1] == ':' ? 2 : 0)
#else
# define FILE_SYSTEM_PREFIX_LEN(Filename) 0
#endif

/* When committing or importing files, you must enter a log message. Normally,
   you can do this either via the -m flag on the command line, the -F flag on
   the command line, or an editor will be started for you. If you like to use
   logging templates (the rcsinfo file within the $CVSROOT/CVSROOT directory),
   you might want to force people to use the editor even if they specify a
   message with -m or -F. Enabling FORCE_USE_EDITOR will cause the -m or -F
   message to be appended to the temp file when the editor is started. */
#undef FORCE_USE_EDITOR

/* Define if gettimeofday clobbers localtime's static buffer. */
#undef GETTIMEOFDAY_CLOBBERS_LOCALTIME_BUFFER

/* Define to an alternative value if GSS_C_NT_HOSTBASED_SERVICE isn't defined
   in the gssapi.h header file. MIT Kerberos 1.2.1 requires this. Only
   relevant when using GSSAPI. */
#undef GSS_C_NT_HOSTBASED_SERVICE

/* Define to 1 if you have the `alarm' function. */
#undef HAVE_ALARM

/* Define to 1 if you have `alloca' after including <alloca.h>, a header that
   may be supplied by this distribution. */
#undef HAVE_ALLOCA

/* Define HAVE_ALLOCA_H for backward compatibility with older code that
   includes <alloca.h> only if HAVE_ALLOCA_H is defined. */
#define HAVE_ALLOCA_H 1

/* Define to 1 if you have the `atexit' function. */
#undef HAVE_ATEXIT

/* Define to 1 if you have the `btowc' function. */
#undef HAVE_BTOWC

/* Define to 1 if you have the `clock_gettime' function. */
#undef HAVE_CLOCK_GETTIME

/* Define to 1 if you have the `clock_settime' function. */
#undef HAVE_CLOCK_SETTIME

/* Define if you have the connect function. */
#define HAVE_CONNECT

/* Define if you have the crypt function. */
#undef HAVE_CRYPT

/* Define if the GNU dcgettext() function is already present or preinstalled.
   */
#undef HAVE_DCGETTEXT

/* Define to 1 if you have the declaration of `clearerr_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_CLEARERR_UNLOCKED

/* Define to 1 if you have the declaration of `feof_unlocked', and to 0 if you
   don't. */
#undef HAVE_DECL_FEOF_UNLOCKED

/* Define to 1 if you have the declaration of `ferror_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_FERROR_UNLOCKED

/* Define to 1 if you have the declaration of `fflush_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_FFLUSH_UNLOCKED

/* Define to 1 if you have the declaration of `fgets_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_FGETS_UNLOCKED

/* Define to 1 if you have the declaration of `flockfile', and to 0 if you
   don't. */
#undef HAVE_DECL_FLOCKFILE

/* Define to 1 if you have the declaration of `fputc_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_FPUTC_UNLOCKED

/* Define to 1 if you have the declaration of `fputs_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_FPUTS_UNLOCKED

/* Define to 1 if you have the declaration of `fread_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_FREAD_UNLOCKED

/* Define to 1 if you have the declaration of `funlockfile', and to 0 if you
   don't. */
#undef HAVE_DECL_FUNLOCKFILE

/* Define to 1 if you have the declaration of `fwrite_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_FWRITE_UNLOCKED

/* Define to 1 if you have the declaration of `getchar_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_GETCHAR_UNLOCKED

/* Define to 1 if you have the declaration of `getc_unlocked', and to 0 if you
   don't. */
#undef HAVE_DECL_GETC_UNLOCKED

/* Define to 1 if you have the declaration of `getenv', and to 0 if you don't.
   */
#undef HAVE_DECL_GETENV

/* Define to 1 if you have the declaration of `getpass', and to 0 if you
   don't. */
#define HAVE_DECL_GETPASS 0

/* Define to 1 if you have the declaration of `nanosleep', and to 0 if you
   don't. */
#undef HAVE_DECL_NANOSLEEP

/* Define to 1 if you have the declaration of `putchar_unlocked', and to 0 if
   you don't. */
#undef HAVE_DECL_PUTCHAR_UNLOCKED

/* Define to 1 if you have the declaration of `putc_unlocked', and to 0 if you
   don't. */
#undef HAVE_DECL_PUTC_UNLOCKED

/* Define to 1 if you have the declaration of `strerror_r', and to 0 if you
   don't. */
#undef HAVE_DECL_STRERROR_R

/* Define to 1 if you have the <direct.h> header file. */
#define HAVE_DIRECT_H 1

/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
   */
#undef HAVE_DIRENT_H

/* Define to 1 if you have the `dup2' function. */
#undef HAVE_DUP2

/* Define if you have the declaration of environ. */
#undef HAVE_ENVIRON_DECL

/* Define if you have the declaration of errno. */
#undef HAVE_ERRNO_DECL

/* Define to 1 if you have the `fchdir' function. */
#undef HAVE_FCHDIR

/* Define to 1 if you have the `fchmod' function. */
#undef HAVE_FCHMOD

/* Define to 1 if you have the <fcntl.h> header file. */
#define HAVE_FCNTL_H 1

/* Define to 1 if you have the `fork' function. */
#undef HAVE_FORK

/* Define to 1 if fseeko (and presumably ftello) exists and is declared. */
#undef HAVE_FSEEKO

/* Define to 1 if you have the `fsync' function. */
#undef HAVE_FSYNC

/* Define to 1 if you have the `ftime' function. */
#define HAVE_FTIME 1

/* Define to 1 if you have the `ftruncate' function. */
#undef HAVE_FTRUNCATE

/* Define to 1 if you have the `getcwd' function. */
#define HAVE_GETCWD 1

/* Define if getcwd (NULL, 0) allocates memory for result. */
#define HAVE_GETCWD_NULL 1

/* Define to 1 if you have the `getdelim' function. */
#undef HAVE_GETDELIM

/* Define to 1 if you have the `geteuid' function. */
#undef HAVE_GETEUID

/* Define to 1 if you have the `getgroups' function. */
#undef HAVE_GETGROUPS

/* Define to 1 if you have the `gethostname' function. */
#undef HAVE_GETHOSTNAME

/* Define to 1 if you have the <getopt.h> header file. */
#undef HAVE_GETOPT_H

/* Define to 1 if you have the `getopt_long_only' function. */
#undef HAVE_GETOPT_LONG_ONLY

/* Define to 1 if you have the `getpagesize' function. */
#undef HAVE_GETPAGESIZE

/* Define if you have the getspnam function. */
#undef HAVE_GETSPNAM

/* Define if the GNU gettext() function is already present or preinstalled. */
#undef HAVE_GETTEXT

/* Define to 1 if you have the `gettimeofday' function. */
#undef HAVE_GETTIMEOFDAY

/* Define if you have GSSAPI with Kerberos version 5 available. */
#undef HAVE_GSSAPI

/* Define to 1 if you have the <gssapi/gssapi_generic.h> header file. */
#undef HAVE_GSSAPI_GSSAPI_GENERIC_H

/* Define to 1 if you have the <gssapi/gssapi.h> header file. */
#undef HAVE_GSSAPI_GSSAPI_H

/* Define to 1 if you have the <gssapi.h> header file. */
#undef HAVE_GSSAPI_H

/* Define if you have the hstrerror function. */
#undef HAVE_HSTRERROR

/* Define if you have the iconv() function. */
#undef HAVE_ICONV

/* Define to 1 if you have the `initgroups' function. */
#undef HAVE_INITGROUPS

/* Define if you have the 'intmax_t' type in <stdint.h> or <inttypes.h>. */
#undef HAVE_INTMAX_T

/* Define if <inttypes.h> exists and doesn't clash with <sys/types.h>. */
#undef HAVE_INTTYPES_H

/* Define if <inttypes.h> exists, doesn't clash with <sys/types.h>, and
   declares uintmax_t. */
#undef HAVE_INTTYPES_H_WITH_UINTMAX

/* Define to 1 if you have the <io.h> header file. */
#define HAVE_IO_H 1

/* Define to 1 if you have the `isascii' function. */
#undef HAVE_ISASCII

/* Define if you have MIT Kerberos version 4 available. */
#undef HAVE_KERBEROS

/* Define to 1 if you have the <krb5.h> header file. */
#undef HAVE_KRB5_H

/* Define to 1 if you have the `krb_get_err_text' function. */
#undef HAVE_KRB_GET_ERR_TEXT

/* Define to 1 if you have the `krb' library (-lkrb). */
#undef HAVE_LIBKRB

/* Define to 1 if you have the `krb4' library (-lkrb4). */
#undef HAVE_LIBKRB4

/* Define to 1 if you have the `nsl' library (-lnsl). */
#undef HAVE_LIBNSL

/* Define to 1 if you have the `login' function. */
#undef HAVE_LOGIN

/* Define to 1 if you have the `logout' function. */
#undef HAVE_LOGOUT

/* Define if you have the 'long double' type. */
#undef HAVE_LONG_DOUBLE

/* Define to 1 if you support file names longer than 14 characters. */
#define HAVE_LONG_FILE_NAMES 1

/* Define if you have the 'long long' type. */
#undef HAVE_LONG_LONG

/* Define to 1 if `lstat' has the bug that it succeeds when given the
   zero-length file name argument. */
#undef HAVE_LSTAT_EMPTY_STRING_BUG

/* Define to 1 if your system has a GNU libc compatible `malloc' function, and
   to 0 otherwise. */
#define HAVE_MALLOC 1

/* Define to 1 if you have the `mblen' function. */
#undef HAVE_MBLEN

/* Define to 1 if you have the `mbrlen' function. */
#undef HAVE_MBRLEN

/* Define to 1 if you have the `mbsrtowcs' function. */
#undef HAVE_MBSRTOWCS

/* Define to 1 if <wchar.h> declares mbstate_t. */
#undef HAVE_MBSTATE_T

/* Define if you have memchr (always for CVS). */
#undef HAVE_MEMCHR

/* Define to 1 if you have the `memmove' function. */
#undef HAVE_MEMMOVE

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the `mempcpy' function. */
#undef HAVE_MEMPCPY

/* Define to 1 if you have the `mkdir' function. */
#undef HAVE_MKDIR

/* Define to 1 if you have the `mknod' function. */
#undef HAVE_MKNOD

/* Define to 1 if you have the `mkstemp' function. */
#undef HAVE_MKSTEMP

/* Define to 1 if you have a working `mmap' system call. */
#undef HAVE_MMAP

/* Define to 1 if you have the <ndbm.h> header file. */
#undef HAVE_NDBM_H

/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
#define HAVE_NDIR_H 1

/* Define to 1 if you have the <OS.h> header file. */
#undef HAVE_OS_H

/* Define to enable system authentication with PAM instead of using the simple
   getpwnam interface. This allows authentication (in theory) with any PAM
   module, e.g. on systems with shadow passwords or via LDAP */
#undef HAVE_PAM

/* Define to 1 if the `printf' function supports the %p format for printing
   pointers. */
#undef HAVE_PRINTF_PTR

/* Define to 1 if the system has the type `ptrdiff_t'. */
#undef HAVE_PTRDIFF_T

/* Define to 1 if you have the `putenv' function. */
#define HAVE_PUTENV 1

/* Define to 1 if you have the `readlink' function. */
#undef HAVE_READLINK

/* Define to 1 if your system has a GNU libc compatible `realloc' function,
   and to 0 otherwise. */
#define HAVE_REALLOC 1

/* Define to 1 if you have the `regcomp' function. */
#undef HAVE_REGCOMP

/* Define to 1 if you have the `regerror' function. */
#undef HAVE_REGERROR

/* Define to 1 if you have the `regexec' function. */
#undef HAVE_REGEXEC

/* Define to 1 if you have the `regfree' function. */
#undef HAVE_REGFREE

/* Define to 1 if you have the `rename' function. */
#undef HAVE_RENAME

/* Define to 1 if you have the `rpmatch' function. */
#undef HAVE_RPMATCH

/* Define to 1 if you have run the test for working tzset. */
#define HAVE_RUN_TZSET_TEST 1

/* Define to 1 if you have the <search.h> header file. */
#undef HAVE_SEARCH_H

/* Define to 1 if you have the `setenv' function. */
#undef HAVE_SETENV

/* Define if the diff library should use setmode for binary files. */
#define HAVE_SETMODE 1

/* Define to 1 if you have the `sigaction' function. */
#undef HAVE_SIGACTION

/* Define to 1 if you have the `sigblock' function. */
#undef HAVE_SIGBLOCK

/* Define to 1 if you have the `sigprocmask' function. */
#undef HAVE_SIGPROCMASK

/* Define to 1 if you have the `sigsetmask' function. */
#undef HAVE_SIGSETMASK

/* Define to 1 if you have the `sigvec' function. */
#undef HAVE_SIGVEC

/* Define to 1 if you have the `snprintf' function. */
#undef HAVE_SNPRINTF

/* Define to 1 if `stat' has the bug that it succeeds when given the
   zero-length file name argument. */
#undef HAVE_STAT_EMPTY_STRING_BUG

/* Define to 1 if stdbool.h conforms to C99. */
#undef HAVE_STDBOOL_H

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define if <stdint.h> exists, doesn't clash with <sys/types.h>, and declares
   uintmax_t. */
#define HAVE_STDINT_H_WITH_UINTMAX 1

/* Define to 1 if you have the <stdio_ext.h> header file. */
#undef HAVE_STDIO_EXT_H

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the `strcasecmp' function. */
#undef HAVE_STRCASECMP

/* Define if you have strchr (always for CVS). */
#undef HAVE_STRCHR

/* Define to 1 if you have the `strerror' function. */
#undef HAVE_STRERROR

/* Define to 1 if you have the `strerror_r' function. */
#undef HAVE_STRERROR_R

/* Define to 1 if you have the `strftime' function. */
#define HAVE_STRFTIME 1

/* Define to 1 if you have the <strings.h> header file. */
#undef HAVE_STRINGS_H

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the `strncasecmp' function. */
#undef HAVE_STRNCASECMP

/* Define to 1 if you have the `strstr' function. */
#undef HAVE_STRSTR

/* Define to 1 if you have the `strtoul' function. */
#undef HAVE_STRTOUL

/* Define to 1 if `st_blksize' is member of `struct stat'. */
#undef HAVE_STRUCT_STAT_ST_BLKSIZE

/* Define to 1 if `st_rdev' is member of `struct stat'. */
#undef HAVE_STRUCT_STAT_ST_RDEV

/* Define if struct timespec is declared in <time.h>. */
#undef HAVE_STRUCT_TIMESPEC

/* Define to 1 if `tm_zone' is member of `struct tm'. */
#undef HAVE_STRUCT_TM_TM_ZONE

/* Define to 1 if you have the <syslog.h> header file. */
#undef HAVE_SYSLOG_H

/* Define to 1 if you have the <sys/bsdtypes.h> header file. */
#undef HAVE_SYS_BSDTYPES_H

/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
   */
#undef HAVE_SYS_DIR_H

/* Define to 1 if you have the <sys/file.h> header file. */
#undef HAVE_SYS_FILE_H

/* Define to 1 if you have the <sys/inttypes.h> header file. */
#undef HAVE_SYS_INTTYPES_H

/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
   */
#undef HAVE_SYS_NDIR_H

/* Define to 1 if you have the <sys/param.h> header file. */
#undef HAVE_SYS_PARAM_H

/* Define to 1 if you have the <sys/resource.h> header file. */
#undef HAVE_SYS_RESOURCE_H

/* Define to 1 if you have the <sys/select.h> header file. */
#undef HAVE_SYS_SELECT_H

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/time.h> header file. */
#undef HAVE_SYS_TIME_H

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have <sys/wait.h> that is POSIX.1 compatible. */
#undef HAVE_SYS_WAIT_H

/* Define to 1 if you have the `timezone' function. */
#undef HAVE_TIMEZONE

/* Define to 1 if localtime_r, etc. have the type signatures that POSIX
   requires. */
#undef HAVE_TIME_R_POSIX

/* Define if struct tm has the tm_gmtoff member. */
#undef HAVE_TM_GMTOFF

/* Define to 1 if your `struct tm' has `tm_zone'. Deprecated, use
   `HAVE_STRUCT_TM_TM_ZONE' instead. */
#undef HAVE_TM_ZONE

/* Define to 1 if you have the `tsearch' function. */
#undef HAVE_TSEARCH

/* Define to 1 if you don't have `tm_zone' but do have the external array
   `tzname'. */
#undef HAVE_TZNAME

/* Define to 1 if you have the `tzset' function. */
#undef HAVE_TZSET

/* Define if you have the 'uintmax_t' type in <stdint.h> or <inttypes.h>. */
#undef HAVE_UINTMAX_T

/* Define to 1 if you have the `uname' function. */
#undef HAVE_UNAME

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the `unsetenv' function. */
#undef HAVE_UNSETENV

/* Define if you have the 'unsigned long long' type. */
#undef HAVE_UNSIGNED_LONG_LONG

/* Define to 1 if you have the <utime.h> header file. */
#undef HAVE_UTIME_H

/* Define to 1 if `utime(file, NULL)' sets file's timestamp to the present. */
#define HAVE_UTIME_NULL 1

/* Define to 1 if you have the `valloc' function. */
#undef HAVE_VALLOC

/* Define to 1 if you have the `vasnprintf' function. */
#undef HAVE_VASNPRINTF

/* Define to 1 if you have the `vasprintf' function. */
#undef HAVE_VASPRINTF

/* Define to 1 if you have the `vfork' function. */
#undef HAVE_VFORK

/* Define to 1 if you have the <vfork.h> header file. */
#undef HAVE_VFORK_H

/* Define to 1 if you have the `vprintf' function. */
#define HAVE_VPRINTF 1

/* Define to 1 if you have the `wait3' function. */
#undef HAVE_WAIT3

/* Define to 1 if you have the `waitpid' function. */
#undef HAVE_WAITPID

/* Define to 1 if you have the <wchar.h> header file. */
#undef HAVE_WCHAR_H

/* Define if you have the 'wchar_t' type. */
#undef HAVE_WCHAR_T

/* Define to 1 if you have the `wcslen' function. */
#undef HAVE_WCSLEN

/* Define to 1 if you have the <wctype.h> header file. */
#undef HAVE_WCTYPE_H

/* Define if you have the 'wint_t' type. */
#undef HAVE_WINT_T

/* Define to 1 if you have the `wmemchr' function. */
#undef HAVE_WMEMCHR

/* Define to 1 if you have the `wmemcpy' function. */
#undef HAVE_WMEMCPY

/* Define to 1 if you have the `wmempcpy' function. */
#undef HAVE_WMEMPCPY

/* Define to 1 if `fork' works. */
#undef HAVE_WORKING_FORK

/* Define to 1 if `vfork' works. */
#undef HAVE_WORKING_VFORK

/* Define to 1 if you have the <zlib.h> header file. */
#undef HAVE_ZLIB_H

/* Define to 1 if the system has the type `_Bool'. */
#undef HAVE__BOOL

/* Define to 1 if you have the `__secure_getenv' function. */
#undef HAVE___SECURE_GETENV

#if FILE_SYSTEM_BACKSLASH_IS_FILE_NAME_SEPARATOR
# define ISSLASH(C) ((C) == '/' || (C) == '\\')
#else
# define ISSLASH(C) ((C) == '/')
#endif

/* Define to include locking code which prevents versions of CVS earlier than
   1.12.4 directly accessing the same repositiory as this executable from
   ignoring this executable's promotable read locks. If only CVS versions
   1.12.4 and later will be accessing your repository directly (as a server or
   locally), you can safely disable this option in return for fewer disk
   accesses and a small speed increase. Disabling this option when versions of
   CVS earlier than 1,12,4 _will_ be accessing your repository, however, is
   *VERY* *VERY* *VERY* dangerous and could result in data loss. As such, by
   default, CVS is compiled with this code enabled. If you are sure you would
   like this code disabled, you can disable it by passing the
   "--disable-lock-compatibility" option to configure or by commenting out the
   lines below. */
#undef LOCK_COMPATIBILITY

/* Define to 1 if `lstat' dereferences a symlink specified with a trailing
   slash. */
#undef LSTAT_FOLLOWS_SLASHED_SYMLINK

/* If malloc(0) is != NULL, define this to 1. Otherwise define this to 0. */
#undef MALLOC_0_IS_NONNULL

/* By default, CVS stores its modules and other such items in flat text files
   (MY_NDBM enables this). Turning off MY_NDBM causes CVS to look for a
   system-supplied ndbm database library and use it instead. That may speed
   things up, but the default setting generally works fine too. */
#define MY_NDBM

/* Define to 1 if your C compiler doesn't accept -c and -o together. */
#undef NO_MINUS_C_MINUS_O

/* Define to the address where bug reports for this package should be sent. */
#undef PACKAGE_BUGREPORT

/* Define to the full name of this package. */
#undef PACKAGE_NAME

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "Concurrent Versions System (CVS) 1.12.9.1"

/* Define to the one symbol short name of this package. */
#undef PACKAGE_TARNAME

/* Define to the version of this package. */
#undef PACKAGE_VERSION

/* Define to set a service name for PAM. This must be defined. Define to
   `program_name', without the quotes, to use whatever name CVS was invoked
   as. Otherwise, define to a double-quoted literal string, such as `"cvs"'.
   */
#undef PAM_SERVICE_NAME

/* Define if you want CVS to be able to serve as a transparent proxy for write
   operations. Disabling this may produce a slight performance gain on some
   systems, at the expense of write proxy support. */
#undef PROXY_SUPPORT

/* Path to the pr utility */
#undef PR_PROGRAM

/* Define to force lib/regex.c to use malloc instead of alloca. */
#define REGEX_MALLOC 1

/* Define as the return type of signal handlers (`int' or `void'). */
#define RETSIGTYPE void

/* The default remote shell to use, if one does not specify the CVS_RSH
   environment variable. */
#define RSH_DFLT "rsh"

/* If you are working with a large remote repository and a 'cvs checkout' is
   swamping your network and memory, define these to enable flow control. You
   will end up with even less probability of a consistent checkout (see
   Concurrency in cvs.texinfo), but CVS doesn't try to guarantee that anyway.
   The master server process will monitor how far it is getting behind, if it
   reaches the high water mark, it will signal the child process to stop
   generating data when convenient (ie: no locks are held, currently at the
   beginning of a new directory). Once the buffer has drained sufficiently to
   reach the low water mark, it will be signalled to start again. */
#undef SERVER_FLOWCONTROL

/* The high water mark in bytes for server flow control. Required if
   SERVER_FLOWCONTROL is defined, and useless otherwise. */
#undef SERVER_HI_WATER

/* The low water mark in bytes for server flow control. Required if
   SERVER_FLOWCONTROL is defined, and useless otherwise. */
#undef SERVER_LO_WATER

/* Define if you want CVS to be able to serve repositories to remote clients.
   */
#undef SERVER_SUPPORT

/* The size of a `char', as computed by sizeof. */
#undef SIZEOF_CHAR

/* The size of a `double', as computed by sizeof. */
#undef SIZEOF_DOUBLE

/* The size of a `float', as computed by sizeof. */
#undef SIZEOF_FLOAT

/* The size of a `int', as computed by sizeof. */
#undef SIZEOF_INT

/* The size of a `intmax_t', as computed by sizeof. */
#undef SIZEOF_INTMAX_T

/* The size of a `long', as computed by sizeof. */
#undef SIZEOF_LONG

/* The size of a `long double', as computed by sizeof. */
#undef SIZEOF_LONG_DOUBLE

/* The size of a `long long', as computed by sizeof. */
#undef SIZEOF_LONG_LONG

/* The size of a `ptrdiff_t', as computed by sizeof. */
#undef SIZEOF_PTRDIFF_T

/* The size of a `short', as computed by sizeof. */
#undef SIZEOF_SHORT

/* The size of a `size_t', as computed by sizeof. */
#undef SIZEOF_SIZE_T

/* The size of a `wint_t', as computed by sizeof. */
#undef SIZEOF_WINT_T

/* Define as the maximum value of type 'size_t', if the system doesn't define
   it. */
#define SIZE_MAX (~(size_t)0)

/* If using the C implementation of alloca, define if you know the
   direction of stack growth for your system; otherwise it will be
   automatically deduced at run-time.
	STACK_DIRECTION > 0 => grows toward higher addresses
	STACK_DIRECTION < 0 => grows toward lower addresses
	STACK_DIRECTION = 0 => direction of growth unknown */
#undef STACK_DIRECTION

/* Define to 1 if the `S_IS*' macros in <sys/stat.h> do not work properly. */
#define STAT_MACROS_BROKEN 1

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Define to 1 if strerror_r returns char *. */
#undef STRERROR_R_CHAR_P

/* Define to be the nanoseconds member of struct stat's st_mtim, if it exists.
   */
#undef ST_MTIM_NSEC

/* Enable support for the pre 1.12.1 *info scripting hook format strings.
   Disable this option for a smaller executable once your scripting hooks have
   been updated to use the new *info format strings by passing
   "--disable-old-info-format-support" option to configure or by commenting
   out the line below. */
#undef SUPPORT_OLD_INFO_FMT_STRINGS

/* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
#undef TIME_WITH_SYS_TIME

/* Directory used for storing temporary files, if not overridden by
   environment variables or the -T global option. There should be little need
   to change this (-T is a better mechanism if you need to use a different
   directory for temporary files). */
#define TMPDIR_DFLT "c:\\temp"

/* Define to 1 if your <sys/time.h> declares `struct tm'. */
#undef TM_IN_SYS_TIME

/* Define if tzset clobbers localtime's static buffer. */
#undef TZSET_CLOBBERS_LOCALTIME_BUFFER

/* Define to its maximum value if an unsigned integer type of width exactly 32
   bits exists and the standard includes do not define UINT32_MAX. */
#undef UINT32_MAX

/* The default umask to use when creating or otherwise setting file or
   directory permissions in the repository. Must be a value in the range of 0
   through 0777. For example, a value of 002 allows group rwx access and world
   rx access; a value of 007 allows group rwx access but no world access. This
   value is overridden by the value of the CVSUMASK environment variable,
   which is interpreted as an octal number. */
#define UMASK_DFLT 002

/* Define if double is the first floating point type detected with its size.
   */
#undef UNIQUE_FLOAT_TYPE_DOUBLE

/* Define if float is the first floating point type detected with its size. */
#undef UNIQUE_FLOAT_TYPE_FLOAT

/* Define if long double is the first floating point type detected with its
   size. */
#undef UNIQUE_FLOAT_TYPE_LONG_DOUBLE

/* Define if char is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_CHAR

/* Define if int is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_INT

/* Define if intmax_t is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_INTMAX_T

/* Define if long int is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_LONG

/* Define if long long is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_LONG_LONG

/* Define if ptrdiff_t is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_PTRDIFF_T

/* Define if short is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_SHORT

/* Define if size_t is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_SIZE_T

/* Define if wint_t is the first integer type detected with its size. */
#undef UNIQUE_INT_TYPE_WINT_T

/* Define if setmode is required when writing binary data to stdout. */
#define USE_SETMODE_STDOUT 1

/* Define to 1 if you want getc etc. to use unlocked I/O if available.
   Unlocked I/O can improve performance in unithreaded apps, but it is not
   safe for multithreaded apps. */
#undef USE_UNLOCKED_IO

/* Define if utime requires write access to the file (true on Windows, but not
   Unix). */
#define UTIME_EXPECTS_WRITABLE

/* Define if unsetenv() returns void, not int. */
#undef VOID_UNSETENV

/* Define to 1 if your processor stores words with the most significant byte
   first (like Motorola and SPARC, unlike Intel and VAX). */
#undef WORDS_BIGENDIAN

/* Define to 1 if on AIX 3.
   System headers sometimes define this.
   We just want to avoid a redefinition error message.  */
#ifndef _ALL_SOURCE
# undef _ALL_SOURCE
#endif

/* Number of bits in a file offset, on hosts where this is settable. */
#undef _FILE_OFFSET_BITS

/* Enable GNU extensions on systems that have them.  */
#ifndef _GNU_SOURCE
# undef _GNU_SOURCE
#endif

/* Define to 1 to make fseeko visible on some hosts (e.g. glibc 2.2). */
#undef _LARGEFILE_SOURCE

/* Define for large files, on AIX-style hosts. */
#undef _LARGE_FILES

/* Define to 1 if on MINIX. */
#undef _MINIX

/* Define to 2 if the system does not provide POSIX.1 features except with
   this defined. */
#undef _POSIX_1_SOURCE

/* Define to 1 if you need to in order for `stat' and other things to work. */
#undef _POSIX_SOURCE

/* Define to force lib/regex.c to define re_comp et al. */
#define _REGEX_RE_COMP 1

/* Define for Solaris 2.5.1 so uint32_t typedef from <sys/synch.h>,
   <pthread.h>, or <semaphore.h> is not used. If the typedef was allowed, the
   #define below would cause a syntax error. */
#undef _UINT32_T

/* Enable extensions on Solaris.  */
#ifndef __EXTENSIONS__
# undef __EXTENSIONS__
#endif

/* Define to empty if `const' does not conform to ANSI C. */
#undef const

/* Define to a replacement function name for fnmatch(). */
#undef fnmatch

/* Define to a replacement function name for getline(). */
#undef getline

/* Define to rpl_getopt if the replacement function should be used. */
#define getopt rpl_getopt

/* Define to rpl_getopt_long if the replacement function should be used. */
#define getopt_long rpl_getopt_long

/* Define to rpl_getopt_long_only if the replacement function should be used.
   */
#define getopt_long_only rpl_getopt_long_only

/* Define to a replacement function name for getpass(). */
#undef getpass

/* Define to rpl_gettimeofday if the replacement function should be used. */
#undef gettimeofday

/* Define to `int' if <sys/types.h> doesn't define. */
#define gid_t int

/* Define to rpl_gmtime if the replacement function should be used. */
#undef gmtime

/* Define to `__inline__' or `__inline' if that's what the C compiler
   calls it, or to nothing if 'inline' is not supported under any name.  */
#ifndef __cplusplus
#define inline __inline
#endif

/* Define to long or long long if <inttypes.h> and <stdint.h> don't define. */
#undef intmax_t

/* Define to rpl_localtime if the replacement function should be used. */
#undef localtime

/* Define to rpl_malloc if the replacement function should be used. */
#undef malloc

/* Define to a type if <wchar.h> does not define. */
#undef mbstate_t

/* Define to rpl_mkstemp if the replacement function should be used. */
#undef mkstemp

/* Define to rpl_mktime if the replacement function should be used. */
#undef mktime

/* Define to `int' if <sys/types.h> does not define. */
#define mode_t int

/* Define to the name of the strftime replacement function. */
#define my_strftime nstrftime

/* Define to rpl_nanosleep if the replacement function should be used. */
#undef nanosleep

/* Define to rpl_optarg if the replacement variable should be used. */
#define optarg rpl_optarg

/* Define to rpl_opterr if the replacement variable should be used. */
#define opterr rpl_opterr

/* Define to rpl_optind if the replacement variable should be used. */
#define optind rpl_optind

/* Define to rpl_optopt if the replacement variable should be used. */
#define optopt rpl_optopt

/* Define to `int' if <sys/types.h> does not define. */
#define pid_t int

/* Define to rpl_realloc if the replacement function should be used. */
#define realloc rpl_realloc

/* Define to equivalent of C99 restrict keyword, or to nothing if this is not
   supported. Do not define if restrict is supported directly. */
#define restrict

/* Define to rpl_select if the replacement function should be used. */
#undef select

/* Define to empty if the C compiler doesn't support this keyword. */
#undef signed

/* Define to `unsigned' if <sys/types.h> does not define. */
#undef size_t

/* Define as a signed type of the same size as size_t. */
#define ssize_t int

/* Define to rpl_tzset if the wrapper function should be used. */
#undef tzset

/* Define to `int' if <sys/types.h> doesn't define. */
#define uid_t int

/* Define to the type of a unsigned integer type of width exactly 32 bits if
   such a type exists and the standard includes do not define it. */
#undef uint32_t

/* Define to unsigned long or unsigned long long if <stdint.h> and
   <inttypes.h> don't define. */
#undef uintmax_t

/* Define as `fork' if `vfork' does not work. */
#undef vfork
/*============================================================================*/
/* config.h.in.footer:  configuration file for Windows NT
   Conrad T. Pino <Conrad@Pino.com> --- May 2004 */

/* This file lives in the windows-NT subdirectory, which is only included
   in your header search path if you're working under Microsoft Visual C++,
   and use ../cvsnt.mak for your project.  Thus, this is the right place to
   put configuration information for Windows NT.  */

/* Define if you have the <sys/timeb.h> header file.  */
#define HAVE_SYS_TIMEB_H 1

/* Under Windows NT, mkdir only takes one argument.  */
#define CVS_MKDIR wnt_mkdir
int wnt_mkdir (const char *PATH, int MODE);

#define CVS_STAT wnt_stat
int wnt_stat ();

#define CVS_LSTAT wnt_lstat
int wnt_lstat ();

#define CVS_RENAME wnt_rename
int wnt_rename (const char *, const char *);

/* This function doesn't exist under Windows NT; we
   provide a stub.  */
int readlink (char *path, char *buf, int buf_size);

/* This is just a call to GetCurrentProcessID.  */
pid_t getpid (void);

/* This is just a call to the Win32 Sleep function.  */
unsigned int sleep (unsigned int);

/* Don't worry, Microsoft, it's okay for these functions to
   be in our namespace.  */
#define popen _popen
#define pclose _pclose

/* Diff needs us to define this.  I think it could always be
   -1 for CVS, because we pass temporary files to diff, but
   config.h seems like the easiest place to put this, so for
   now we put it here.  */
#define same_file(s,t) (-1)

/* This is where old bits go to die under Windows NT.  */
#define DEVNULL "nul"

#define START_SERVER wnt_start_server
void wnt_start_server (int *tofd, int *fromfd,
		       char *client_user,
		       char *server_user,
		       char *server_host,
		       char *server_cvsroot);

#define SHUTDOWN_SERVER wnt_shutdown_server
void wnt_shutdown_server (int fd);

#define SYSTEM_INITIALIZE(pargc,pargv) init_winsock()
void init_winsock();

#define SYSTEM_CLEANUP wnt_cleanup
void wnt_cleanup (void);

#define HAVE_WINSOCK_H

/* This tells the client that it must use send()/recv() to talk to the
   server if it is connected to the server via a socket; Win95 needs
   it because _open_osfhandle doesn't work.  */
#define NO_SOCKET_TO_FD 1

/* This tells the client that, in addition to needing to use
   send()/recv() to do socket I/O, the error codes for send()/recv()
   and other socket operations are not available through errno.
   Instead, this macro should be used to obtain an error code. */
#define SOCK_ERRNO (WSAGetLastError ())

/* This tells the client that, in addition to needing to use
   send()/recv() to do socket I/O, the error codes for send()/recv()
   and other socket operations are not known to strerror.  Instead,
   this macro should be used to convert the error codes to strings. */
#define SOCK_STRERROR sock_strerror
char *sock_strerror (int errnum);

/* The internal rsh client uses sockets not file descriptors.  Note
   that as the code stands now, it often takes values from a SOCKET and
   puts them in an int.  This is ugly but it seems like sizeof
   (SOCKET) <= sizeof (int) on win32, even the 64-bit variants.  */
#define START_SERVER_RETURNS_SOCKET 1

/* Is this true on NT?  Seems like I remember reports that NT 3.51 has
   problems with 200K writes (of course, the issue of large writes is
   moot since the use of buffer.c ensures that writes will only be as big
   as the buffers).  */
#define SEND_NEVER_PARTIAL 1

/* getpagesize is missing on Windows, but 4096 seems to do the right
   thing. */
#define getpagesize() 4096
