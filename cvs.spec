Summary: Concurrent Versions System
Name: cvs
Version: @VERSION@
Release: 1
Copyright: GPL
Group: Development/Version Control
Source: ftp.cyclic.com:/pub/cvs-@VERSION@.tar.gz
Buildroot: /

%description
CVS is a freely available collection of programs that provide for
software release and revision control functions in a UNIX environment.
It is designed to work on top of the RCS distribution, V4 and later.
CVS does understand how to parse older RCS formats, but cannot do any
of the fancier features (like vendor branch support) without RCS
branch support.

%prep
%setup

%build
./configure --prefix=$RPM_BUILD_ROOT/usr
make CFLAGS="$RPM_OPT_FLAGS -DRCSBIN_DFLT=\\\"/usr/bin\\\" -DSERVER_FLOWCONTROL" LDFLAGS=-s 

%install
make installdirs
make install
rm -f $RPM_BUILD_ROOT/usr/info/cvs*
make install-info
gzip -9nf $RPM_BUILD_ROOT/usr/info/cvs*

%files
%doc BUGS COPYING COPYING.LIB ChangeLog ChangeLog.zoo FAQ HACKING
%doc INSTALL MINOR-BUGS NEWS PROJECTS README TESTS TODO
/usr/bin/cvs
/usr/bin/cvsbug
/usr/bin/rcs2log
/usr/man/man1/cvs.1
/usr/man/man5/cvs.5
/usr/man/man8/cvsbug.8
/usr/info/cvs*
/usr/lib/cvs
