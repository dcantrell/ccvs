## Process this file with automake to produce Makefile.in
# Makefile for GNU CVS program.
# Copyright (C) 2003 Derek Price, Ximbiot, & The Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

TESTSUITE = $(srcdir)/suite
TESTSUITE_AT = \
	init.at \
	suite.at

EXTRA_DIST = \
	$(TESTSUITE_AT) \
	atspecific.m4 \
	package.m4.in \
	suite

AUTOTEST = $(AUTOM4TE) --language=autotest
$(TESTSUITE): @MAINTAINER_MODE_TRUE@ package.m4 atspecific.m4 $(TESTSUITE_AT)
@MAINTAINER_MODE_TRUE@	$(AUTOTEST) -I $(srcdir) $(srcdir)/suite.at -o $@.tmp
@MAINTAINER_MODE_TRUE@	mv $@.tmp $@

check-local: $(TESTSUITE)

clean-local:
	test ! -f $(TESTSUITE) || $(SHELL) $(TESTSUITE) --clean
	rm -f *.tmp
	rm -rf autom4te.cache
