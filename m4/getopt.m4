# getopt.m4 serial 5
dnl Copyright (C) 2002, 2003, 2004 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

# The getopt module assume you want GNU getopt, with getopt_long etc,
# rather than vanilla POSIX getopt.  This means your your code should
# always include <getopt.h> for the getopt prototypes.

AC_DEFUN([gl_GETOPT_SUBSTITUTE],
[
  GETOPT_H=getopt.h
  AC_LIBOBJ([getopt])
  AC_LIBOBJ([getopt1])
  AC_DEFINE([optarg], [rpl_optarg],
    [Define to rpl_optarg if the replacement variable should be used.])
  AC_DEFINE([optind], [rpl_optind],
    [Define to rpl_optind if the replacement variable should be used.])
  AC_DEFINE([opterr], [rpl_opterr],
    [Define to rpl_opterr if the replacement variable should be used.])
  AC_DEFINE([optopt], [rpl_optopt],
    [Define to rpl_optopt if the replacement variable should be used.])
  AC_DEFINE([getopt], [rpl_getopt],
    [Define to rpl_getopt if the replacement function should be used.])
  AC_DEFINE([getopt_long], [rpl_getopt_long],
    [Define to rpl_getopt_long if the replacement function should be used.])
  AC_DEFINE([getopt_long_only], [rpl_getopt_long_only],
    [Define to rpl_getopt_long_only if the replacement function should be used.])
  AC_SUBST([GETOPT_H])
])

AC_DEFUN([gl_GETOPT],
[
  gl_PREREQ_GETOPT

  GETOPT_H=
  AC_CHECK_HEADERS([getopt.h], [], [GETOPT_H=getopt.h])
  AC_CHECK_FUNCS([getopt_long_only], [], [GETOPT_H=getopt.h])

  dnl BSD getopt_long uses an incompatible method to reset option processing,
  dnl and (as of 2004-10-15) mishandles optional option-arguments.
  AC_CHECK_DECL([optreset], [GETOPT_H=getopt.h], [], [#include <getopt.h>])

  if test -n "$GETOPT_H"; then
     gl_GETOPT_SUBSTITUTE
  fi
])

# Prerequisites of lib/getopt*.
AC_DEFUN([gl_PREREQ_GETOPT], [:])
