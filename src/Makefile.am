## Process this file with automake to produce Makefile.in
# Makefile for GNU CVS program.
# Copyright (C) 1986, 1988-1990, 2000 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

SHELL = /bin/sh

# $(includeopt) is CVS specific and set by configure
##INCLUDES = -I. -I.. -I$(srcdir) -I$(top_srcdir)/lib
INCLUDES = -I$(top_srcdir)/lib -I$(top_srcdir)/diff $(includeopt)

bin_PROGRAMS = cvs
bin_SCRIPTS = cvsbug

# The cvs executable
cvs_SOURCES = add.c admin.c buffer.c checkin.c checkout.c classify.c client.c \
commit.c create_adm.c cvsrc.c diff.c edit.c entries.c error.c expand_path.c \
fileattr.c find_names.c hardlink.c hash.c history.c ignore.c import.c \
lock.c log.c login.c logmsg.c main.c mkmodules.c modules.c myndbm.c no_diff.c \
parseinfo.c patch.c rcs.c rcscmds.c recurse.c release.c remove.c repos.c \
root.c rtag.c scramble.c server.c status.c subr.c filesubr.c run.c \
tag.c update.c watch.c wrapper.c vers_ts.c zlib.c \
buffer.h cvs.h rcs.h hardlink.h hash.h myndbm.h \
update.h server.h client.h error.h fileattr.h edit.h watch.h
cvs_LDADD = version.o ../lib/libcvs.a ../diff/libdiff.a ../zlib/libz.a
cvs_EXTRA_DIST = version.c

cvsbug_EXTRA_DIST = cvsbug.sh

# The cvsbug executable
# version.c is in here so we'll notice if configure was run
cvsbug: cvsbug.sh version.c
	sed -e 's,xLIBDIRx,$(libdir)/cvs,g' \
	    -e "s,xVERSIONx,$(VERSION),g" $< > $@-t
	mv $@-t $@
	chmod a+x $@

# extra clean targets
# wish this could be distclean-hdr-local but it's not part of automake
DISTCLEANFILES = options.h-SAVED cvsbug check.log check.plog

# General
EXTRA_DIST = \
	$(cvs_EXTRA_DIST) \
	$(cvsbug_EXTRA_DIST) \
	.cvsignore \
	ChangeLog-9194 \
	ChangeLog-9395 \
	ChangeLog-96 \
	ChangeLog-97 \
	build_src.com \
	sanity.sh

check-local:
	$(SHELL) $(srcdir)/sanity.sh `pwd`/cvs

.PHONY: remotecheck
remotecheck:
	$(SHELL) $(srcdir)/sanity.sh -r `pwd`/cvs

# for backwards compatibility with the old makefiles
.PHONY: realclean
realclean: maintainer-clean
