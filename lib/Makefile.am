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
	getnline.c \
	getopt.c \
	getopt1.c \
	md5.c \
	savecwd.c \
	sighandle.c \
	stripslash.c \
	xgetwd.c \
	yesno.c \
	error.h \
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
	savecwd.h \
	system.h \
	unlocked-io.h \
	wait.h \
	xselect.h \
	xsize.h \
	xtime.h
## Because @LIBOBJS@ is included below and AC_LIBOBJ is sometimes called on
## these files from configure.in, automake automatically knows about many of
## the *.c files in this directory.
libcvs_a_LIBADD = @LIBOBJS@

BUILT_SOURCES =
MOSTLYCLEANFILES =

EXTRA_DIST = \
	.cvsignore \
	ChangeLog.fsf \
	build_lib.com \
	lib.dsp \
	lib.mak

# For GNULIB's alloca module.
BUILT_SOURCES += $(ALLOCA_H)
EXTRA_DIST += alloca_.h
all-local $(lib_OBJECTS): $(ALLOCA_H)
alloca.h: alloca_.h
	cp $(srcdir)/alloca_.h $@-t
	mv $@-t $@
MOSTLYCLEANFILES += alloca.h alloca.h-t

# For GNULIB's exitfail module.
libcvs_a_SOURCES += exitfail.h exitfail.c

# For GNULIB's fnmatch module.
BUILT_SOURCES += $(FNMATCH_H)
EXTRA_DIST += fnmatch_.h fnmatch_loop.c
# We need the following in order to create an <fnmatch.h> when the system
# doesn't have one that supports the required API.
all-local $(libcvs_a_OBJECTS): $(FNMATCH_H)
fnmatch.h: fnmatch_.h
	cp $(srcdir)/fnmatch_.h $@-t
	mv $@-t $@
MOSTLYCLEANFILES += fnmatch.h fnmatch.h-t

# For GNULIB's vasnprintf module.
libcvs_a_SOURCES += printf-args.h printf-parse.h vasnprintf.h

# For GNULIB's xalloc module.
libcvs_a_SOURCES += xalloc.h xmalloc.c xstrdup.c

# for backwards compatibility with the old makefiles
realclean: maintainer-clean
.PHONY: realclean
