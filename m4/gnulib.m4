# Copyright (C) 2004 Free Software Foundation, Inc.
# This file is free software, distributed under the terms of the GNU
# General Public License.  As a special exception to the GNU General
# Public License, this file may be distributed as part of a program
# that contains a configuration script generated by Autoconf, under
# the same distribution terms as the rest of that program.
#
# Generated by gnulib-tool.
#
# Invoked as: gnulib-tool --import gettext vasnprintf regex atexit save-cwd dirname error exit exitfail extensions fnmatch-posix fnmatch mkstemp getopt stdbool getline getnline getndelim2 gethostname strcase getpass-gnu gettimeofday timespec gettime unlocked-io tzset restrict time_r mktime minmax memmove nanosleep stat lstat strerror vasprintf malloc realloc strftime xsize getpagesize md5 stdint yesno allocsa setenv getdate readlink xreadlink xgethostname mkdir rename dup2 strstr ftruncate strtoul pathmax xalloc-die pagealign_alloc closeout strdup canonicalize getlogin_r stat-macros
# Reproduce by: gnulib-tool --import --dir=. --lib=libgnu --source-base=lib --m4-base=m4 --aux-dir=build-aux   alloca alloca-opt allocsa atexit canonicalize chdir-long closeout cycle-check dirname dup2 error exit exitfail extensions fnmatch fnmatch-posix fpending ftruncate getcwd getdate gethostname getline getlogin_r getndelim2 getnline getopt getpagesize getpass-gnu gettext gettime gettimeofday lstat malloc md5 memmove mempcpy memrchr minmax mkdir mkstemp mktime nanosleep openat pagealign_alloc path-concat pathmax quotearg readlink realloc regex rename restrict rpmatch save-cwd setenv stat stat-macros stdbool stdint strcase strdup strerror strftime strstr strtol strtoul time_r timespec tzset unistd-safer unlocked-io vasnprintf vasprintf xalloc xalloc-die xgetcwd xgethostname xreadlink xsize yesno

AC_DEFUN([gl_EARLY],
[
  AC_GNU_SOURCE
  gl_USE_SYSTEM_EXTENSIONS
])

AC_DEFUN([gl_INIT],
[
  gl_FUNC_ALLOCA
  gl_ALLOCSA
  gl_FUNC_ATEXIT
  AC_FUNC_CANONICALIZE_FILE_NAME
  gl_FUNC_CHDIR_LONG
  gl_CLOSEOUT
  gl_DIRNAME
  gl_FUNC_DUP2
  gl_ERROR
  gl_EXITFAIL
  dnl gl_USE_SYSTEM_EXTENSIONS must be added quite early to configure.ac.
  # No macro. You should also use one of fnmatch-posix or fnmatch-gnu.
  gl_FUNC_FNMATCH_POSIX
  gl_FUNC_FPENDING
  gl_FUNC_FTRUNCATE
  gl_FUNC_GETCWD
  gl_GETDATE
  gl_FUNC_GETHOSTNAME
  AM_FUNC_GETLINE
  gl_GETLOGIN_R
  gl_GETNDELIM2
  gl_GETNLINE
  gl_GETOPT
  gl_GETPAGESIZE
  gl_FUNC_GETPASS_GNU
  dnl you must add AM_GNU_GETTEXT([external]) or similar to configure.ac.
  gl_GETTIME
  AC_FUNC_GETTIMEOFDAY_CLOBBER
  gl_FUNC_LSTAT
  AC_FUNC_MALLOC
  gl_MD5
  gl_FUNC_MEMMOVE
  gl_FUNC_MEMPCPY
  gl_FUNC_MEMRCHR
  gl_MINMAX
  gl_FUNC_MKDIR_TRAILING_SLASH
  gl_FUNC_MKSTEMP
  gl_FUNC_MKTIME
  gl_FUNC_NANOSLEEP
  gl_FUNC_OPENAT
  gl_PAGEALIGN_ALLOC
  gl_PATH_CONCAT
  gl_PATHMAX
  gl_QUOTEARG
  gl_FUNC_READLINK
  AC_FUNC_REALLOC
  gl_REGEX
  vb_FUNC_RENAME
  gl_C_RESTRICT
  gl_FUNC_RPMATCH
  gl_SAVE_CWD
  gt_FUNC_SETENV
  gl_FUNC_STAT
  gl_STAT_MACROS
  AM_STDBOOL_H
  gl_STDINT_H
  gl_STRCASE
  gl_FUNC_STRDUP
  gl_FUNC_STRERROR
  gl_FUNC_GNU_STRFTIME
  gl_FUNC_STRSTR
  gl_FUNC_STRTOL
  gl_FUNC_STRTOUL
  gl_TIME_R
  gl_TIMESPEC
  gl_FUNC_TZSET_CLOBBER
  gl_UNISTD_SAFER
  gl_FUNC_GLIBC_UNLOCKED_IO
  gl_FUNC_VASNPRINTF
  gl_FUNC_VASPRINTF
  gl_XALLOC
  gl_XGETCWD
  gl_XREADLINK
  gl_XSIZE
  gl_YESNO
])

dnl Usage: gl_MODULES(module1 module2 ...)
AC_DEFUN([gl_MODULES], [])

dnl Usage: gl_SOURCE_BASE(DIR)
AC_DEFUN([gl_SOURCE_BASE], [])

dnl Usage: gl_M4_BASE(DIR)
AC_DEFUN([gl_M4_BASE], [])

dnl Usage: gl_LIB(LIBNAME)
AC_DEFUN([gl_LIB], [])

dnl Usage: gl_LGPL
AC_DEFUN([gl_LGPL], [])

# gnulib.m4 ends here
