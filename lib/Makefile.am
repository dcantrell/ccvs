## Process this file with automake to produce Makefile.in
# Makefile for library files used by GNU CVS.
# Copyright (C) 1986, 1988-1994, 2000 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

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
	ftruncate.c \
	getdate.y \
	getline.c \
	getopt.c \
	getopt1.c \
	md5.c \
	regex.c \
	savecwd.c \
	sighandle.c \
	stripslash.c \
	xgetwd.c \
	yesno.c \
	getline.h \
	getopt.h \
	fnmatch.h \
	regex.h \
	system.h \
	wait.h \
	md5.h \
	savecwd.h
## because @LIBOBJS@ is included below, automake automatically knows about
##     dup2.c
##     fncase.c
##     fnmatch.c
##     hostname.c
##     memmove.c
##     mkdir.c
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

# for backwards compatibility with the old makefiles
realclean: maintainer-clean
.PHONY: realclean
