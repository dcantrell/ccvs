dnl Copyright (C) 2003 Derek Price, Ximbiot,
dnl			& The Free Software Foundation, Inc.
dnl
dnl This program is free software; you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation; either version 2, or (at your option)
dnl any later version.
dnl
dnl This program is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.



m4_define([AT_CVS_BANNER],
[m4_expand_once([AT_BANNER([$1])])])



# AT_CVS_SETUP(DESCRIPTION)
# ------------
m4_define([AT_CVS_SETUP],
[AT_SETUP([$1]m4_quote(AT_CVS_clientserver)m4_quote(AT_CVS_linkroot))dnl
dnl This is minor overhead and it avoids us having to run the init.at
dnl tests every run.
dnl AT_KEYWORDS([testthis])
m4_ifval(m4_quote(AT_CVS_linkroot),
[AT_KEYWORDS([link-root])dnl
mkdir $at_group_dir/realcvsroot ||
  AS_ERROR([Cannot create directory \`$at_group_dir/realcvsroot'])
dnl Skip this test if we cannot create a link
AT_CHECK([ln -s realcvsroot $at_group_dir/cvsroot || exit 77])
],
[AT_KEYWORDS([no-link-root])])dnl m4_ifval AT_CVS_linkroot

CVSROOT_DIR=$at_group_dir/cvsroot
m4_ifvaln(m4_quote(AT_CVS_clientserver),
[AT_KEYWORDS([remote])dnl
AT_CHECK([cvs --version |grep client || exit 77], 0, ignore)
AT_CHECK([$server --version |grep server || exit 77], 0, ignore)
CVS_SERVER=$server
export CVS_SERVER
method=:fork:],
[AT_KEYWORDS([local])dnl
method=])dnl m4_ifvaln AT_CVS_clientserver
CVSROOT=$method$CVSROOT_DIR
export CVSROOT

AT_CHECK([cvs init || exit 77])dnl
])dnl AT_CVS_SETUP



# AT_CVS_REMOTE_ONLY
# ------------------
# Exit with a SKIP error code if not testing client/server code.
dnl m4_define([AT_CVS_REMOTE_ONLY], [AT_CHECK(
dnl [if $remote; then
dnl   if $client_support && $server_support; then :; else
dnl     exit 77
dnl   fi
dnl fi
dnl :
dnl ])dnl AT_CHECK
dnl ])dnl AT_CVS_REMOTE_ONLY

# AT_CVS_INCLUDE(FILE)
# --------------------
# Include a test description file, once for each combinations of testing modes.
# Warn on multiple inclusions by the user.
#
# Modes are:
#
#  AT_CVS_clientserver		Client/server mode.
#    <empty>			Test local mode only.
#    -r				Test client/server operationa
#
#  AT_CVS_linkroot		Root symlink mode.
#    <empty>			CVSROOT points to a real directory.
#    -l				CVSROOT points to a symlink to a real
#				directory.
m4_define([AT_CVS_INCLUDE],
[m4_include_unique([$1])dnl
m4_foreach([AT_CVS_clientserver], [[[]], [[-r]]],
[m4_foreach([AT_CVS_linkroot], [[[]], [[-l]]],
[m4_builtin([include],[$1])])dnl   m4_foreach AT_CVS_linkroot
])dnl m4_foreach AT_CVS_clientserver
])dnl AT_CVS_INCLUDE
