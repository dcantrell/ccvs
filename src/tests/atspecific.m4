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
# -------------------------
# Set up a CVS test with description DESCRIPTION.
#
# This macro sets up a CVSROOT, initializes it, initializes a project at the
# top level named, `project', checks out the project, and cds into the project
# directory.
#
# This macro also puts some information in the envirionment that might be
# needed by tests:
#
#   $CVS_SERVER		The path to the CVS server executable to use.
#   $CVSROOT		The CVSROOT.
#   $CVSROOT_DIR	The path portion of $CVSROOT.
#   $method		The method portion of $CVSROOT.
#
#   $HOME		A "home" directory for our test user.
#   $RCSINIT		Cleared, to avoid interfering with CVS's RCS library.
#
# INPUTS
#   AT_CVS_clientserver		empty or `-r', per AT_CVS_INCLUDE
#   AT_CVS_linkroot		empty ot `-l', per AT_CVS_INCLUDE
#
m4_define([AT_CVS_SETUP],
[AT_SETUP([$1]m4_quote(AT_CVS_clientserver)m4_quote(AT_CVS_linkroot))dnl
###
### Begin AT_CVS_SETUP([$1])
###

m4_ifval(m4_quote(AT_CVS_linkroot),
[AT_KEYWORDS([link-root])dnl
#
# Create a symlinked CVSROOT_DIR
#
mkdir $at_group_dir/realcvsroot ||
  AS_ERROR([Cannot create directory \`$at_group_dir/realcvsroot'])
dnl Skip this test if we cannot create a link
AT_CHECK([ln -s realcvsroot $at_group_dir/cvsroot || exit 77])
],
[AT_KEYWORDS([no-link-root])])dnl m4_ifval AT_CVS_linkroot

#
# Set CVSROOT_DIR, method, & CVSROOT
#
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

#
# Clear a possibly damaging inherited environment.
#

# Avoid picking up any stray .cvsrc, etc., from the user running the tests
mkdir home
HOME=$at_group_dir/home; export HOME

# Make sure this variable is not defined to anything that would
# change the format of RCS dates.  Otherwise people using e.g.,
# RCSINIT=-zLT get lots of spurious failures.
RCSINIT=

#
# Initialize the repository
#
AT_CHECK([cvs init])

#
# Create the default project
#
mkdir top
cd top
AT_CHECK([cvs -Q co -l .])
mkdir project
AT_CHECK([cvs -Q add project])
cd ..
rm -r top

#
# Check out the default project and cd into the workspace.
#
# I'm checking for error returns form the cd and printing error messages since,
# for instance, if the CVS executable picks up a ~/.cvsrc which causes empty
# directories to be pruned by checkout, the project directory will not be
# created but the `cvs co' will not return an error.
#
AT_CHECK([cvs -Q co project])
cd project ||
  AS_ERROR([Couldn't cd to \`project'.  Did \$HOME get set incorrectly?])

###
### End AT_CVS_SETUP([$1])
###
])dnl AT_CVS_SETUP



# AT_CVS_REMOTE(TEXT-IF-REMOTE,TEXT-OTHERWISE)
# -------------------
# Replace with TEXT-IF-REMOTE in remote mode, otherwise replace with
# TEXT-OTHERWISE.
#
# INPUTS
#   AT_CVS_clientserver		empty or `-r', per AT_CVS_INCLUDE
#
m4_define([AT_CVS_REMOTE],
[m4_ifval(m4_quote(AT_CVS_clientserver),
[$1],[$2])dnl m4_ifval(AT_CVS_clientserver)
])dnl AT_CVS_REMOTE



# AT_CVS_LOCAL(TEXT)
# ------------------
# Replace with TEXT only in local mode.
#
# INPUTS
#   AT_CVS_clientserver		empty or `-r', per AT_CVS_INCLUDE
#
m4_define([AT_CVS_LOCAL],[AT_CVS_REMOTE([$2],[$1])])dnl AT_CVS_LOCAL



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
