## Process this file with automake to produce Makefile.in
# Makefile for library files used by GNU CVS.
# Copyright (C) 1986, 1987, 1988, 1989, 1990, 1991, 1992, 1993, 1994,
#               1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003
#               Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

#
# savecwd.h needs src/error.h
#
AM_CPPFLAGS = -I$(top_srcdir)/src

noinst_LIBRARIES = libcvs.a

# Always use CVS's regular expression matcher regex.o, because of
# variations in regular expression syntax - we want to be the same
# across systems and (probably) compared with old versions of CVS too.
#
# On a more mundane/detail level, having regex.h match regex.c can be
# an issue if we aren't careful.
#
# Also should look into unifying regular expression matching in CVS
# with the diff library (perhaps to have the caller, CVS, do the
# matching?)
libcvs_a_SOURCES = \
	argmatch.c \
	getdate.y \
	getndelim2.c \
	getnline.c \
	getopt.c \
	getopt1.c \
	md5.c \
	regex.c \
	savecwd.c \
	sighandle.c \
	stripslash.c \
	xgetwd.c \
	yesno.c \
	exit.h \
	getline.h \
	getndelim2.h \
	getnline.h \
	getopt.h \
	gettext.h \
	getpagesize.h \
	md5.h \
	pathmax.h \
	regex.h \
        PROTO.h \
	savecwd.h \
	system.h \
	unlocked-io.h \
	wait.h \
	xselect.h \
	xtime.h
## because @LIBOBJS@ is included below, automake automatically knows about
##     dup2.c
##     fncase.c
##     fnmatch.c
##     fnmatch.h
##     ftruncate.c
##     gethostname.c
##     malloc.c
##     memmove.c
##     mkdir.c
##     realloc.c
##     rename.c
##     strstr.c
##     strerror.c
##     strtoul.c
##     valloc.c
##     waitpid.c
libcvs_a_LIBADD = @LIBOBJS@

EXTRA_DIST = \
	.cvsignore \
	ChangeLog.fsf \
	build_lib.com

# Until Automake gets its act together
distclean-local:
	rm -f fnmatch.h

# for backwards compatibility with the old makefiles
realclean: maintainer-clean
.PHONY: realclean
