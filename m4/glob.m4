# glob.m4 serial 1
dnl Copyright (C) 2005 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

# The glob module assumes you want GNU glob, with glob_pattern_p etc,
# rather than vanilla POSIX glob.  This means your your code should
# always include <glob.h> for the glob prototypes.

AC_DEFUN([gl_GLOB_SUBSTITUTE],
[
  gl_PREREQ_GLOB

  GLOB_H=glob.h
  AC_LIBOBJ([glob])
  AC_DEFINE([GLOB_PREFIX], [[rpl_]],
    [Define to rpl_ if the glob replacement functions and variables
     should be used.])
  AC_SUBST([GLOB_H])
])

AC_DEFUN([gl_GLOB],
[
  gl_PREREQ_GLOB

  if test -z "$GLOB_H"; then
    GLOB_H=
    AC_CHECK_HEADERS([glob.h], [], [GLOB_H=glob.h])
    if test -z "$GLOB_H"; then
      AC_CHECK_FUNCS([glob_pattern_p], [], [GLOB_H=glob.h])
    fi

    if test -n "$GLOB_H"; then
      gl_GLOB_SUBSTITUTE
    fi
  fi
])

# Prerequisites of lib/glob.*.
AC_DEFUN([gl_PREREQ_GLOB], [
  AC_CHECK_HEADERS_ONCE([dirent.h sys/ndir.h sys/dir.h ndir.h])
  AC_CHECK_FUNCS_ONCE([dirent64 getlogin_r getpwnam_r stat64])
  AC_CHECK_MEMBERS([struct dirent.d_type],,, [#include <dirent.h>])
  :
])
