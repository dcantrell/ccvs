#### Under Windows NT and Microsoft Visual C++, we use cvsnt.mak, not
#### this makefile.  However, we need this file in order for 'make
#### dist' to work properly on Unix machines.

DISTFILES = \
  ChangeLog \
  config.h options.h \
  alloca.h pwd.h

all:

.PHONY: all install uninstall
all install uninstall:

.PHONY: tags TAGS
tags TAGS:

.PHONY: ls
ls:
	@echo ${DISTFILES}

.PHONY: clean distclean realclean mostlyclean
clean distclean realclean mostlyclean:

.PHONY: lint
lint:

.PHONY: dist-dir
dist-dir:
	mkdir ${DISTDIR}
	ln ${DISTFILES} ${DISTDIR}
