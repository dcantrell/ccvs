# getopt.m4 serial 8
dnl Copyright (C) 2002, 2003, 2004, 2005 Free Software Foundation, Inc.
dnl This file is free software; the Free Software Foundation
dnl gives unlimited permission to copy and/or distribute it,
dnl with or without modifications, as long as this notice is preserved.

# The getopt module assume you want GNU getopt, with getopt_long etc,
# rather than vanilla POSIX getopt.  This means your your code should
# always include <getopt.h> for the getopt prototypes.

AC_DEFUN([gl_GETOPT_SUBSTITUTE],
[
  GETOPT_H=getopt.h
  AC_LIBOBJ([getopt])
  AC_LIBOBJ([getopt1])
  AC_DEFINE([__GETOPT_PREFIX], [[rpl_]],
    [Define to rpl_ if the getopt replacement functions and variables
     should be used.])
  AC_SUBST([GETOPT_H])
])

AC_DEFUN([gl_GETOPT],
[
  gl_PREREQ_GETOPT

  if test -z "$GETOPT_H"; then
    GETOPT_H=
    AC_CHECK_HEADERS([getopt.h], [], [GETOPT_H=getopt.h])
    if test -z "$GETOPT_H"; then
      AC_CHECK_FUNCS([getopt_long_only], [], [GETOPT_H=getopt.h])
    fi

    dnl BSD getopt_long uses an incompatible method to reset option processing,
    dnl and (as of 2004-10-15) mishandles optional option-arguments.
    if test -z "$GETOPT_H"; then
      AC_CHECK_DECL([optreset], [GETOPT_H=getopt.h], [], [#include <getopt.h>])
    fi

    dnl Solaris 10 getopt doesn't handle `+' as a leading character in an
    dnl option string (as of 2005-05-05).
    if test -z "$GETOPT_H"; then
      AC_CHECK_DECL([getopt_clip], [GETOPT_H=getopt.h], [],
	[#include <getopt.h>])
    fi

    if test -n "$GETOPT_H"; then
      gl_GETOPT_SUBSTITUTE
    fi
  fi
])

# Prerequisites of lib/getopt*.
AC_DEFUN([gl_PREREQ_GETOPT], [:])
