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



# AT_CVS_BANNER([TEXT])
# ---------------------
# Expand the AT_BANNER([TEXT]) macro only once so that we can include files
# multiple times via AT_CVS_INCLUDE().
m4_define([AT_CVS_BANNER],
[m4_expand_once([AT_BANNER([$1])])])



# cvs_project_init()
# ------------------
# 
# Initialize the repository, check out a default project, and cd into the
# default project, monitoring all CVS actions via AT_CHECK.
#
# This function should only be called from within an AT_CVS_SETUP test group.
m4_divert_text([DEFAULTS],
[cvs_project_init() {
AT_CHECK([cvs init])dnl

#
# Create the default project
#
AT_CHECK([cvs -Q co -l -d top .])dnl
cd top
mkdir project
AT_CHECK([cvs -Q add project])dnl
cd ..
AT_CHECK([cvs -Q release -d top])dnl
# Checkout the default project
AT_CHECK([cvs -Q co project])dnl
}])dnl



# AT_CVS_SETUP(DESCRIPTION)
# -------------------------
# Set up a CVS test with description DESCRIPTION.
#
# This macro sets up a CVSROOT, initializes it, initializes projects at the
# top level named, `project', checks out the project, and cds
# into the project directory.
#
# This macro also puts some information in the envirionment that might be
# needed by tests:
#
#   $CVS_SERVER		The path to the CVS server executable to use.
#   $SPROG		The basename of the CVS server, for output
#                       verification.
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
AT_CHECK([cvs --version |grep client || exit 77], 0, ignore)dnl
AT_CHECK([$server --version |grep server || exit 77], 0, ignore)dnl
CVS_SERVER=$server; export CVS_SERVER
method=:fork:],
[AT_KEYWORDS([local])dnl
method=])dnl m4_ifvaln AT_CVS_clientserver
CVSROOT=$method$CVSROOT_DIR
export CVSROOT
SPROG=`basename $server`

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

cvs_project_init || exit 1

#
# cd into the default project for the workspace.
#
# I'm checking for error returns from the cd and printing error messages since,
# for instance, if the CVS executable picks up a ~/.cvsrc which causes empty
# directories to be pruned by checkout, the project directory will not be
# created but the `cvs co' will not return an error.
#
cd project ||
  AS_ERROR([Couldn't cd to \`project'.  Did \$HOME get set incorrectly?])

###
### End AT_CVS_SETUP([$1])
###])# AT_CVS_SETUP



# AT_CVS_REMOTE(TEXT-IF-REMOTE,TEXT-OTHERWISE)
# --------------------------------------------
# Replace with TEXT-IF-REMOTE in remote mode, otherwise replace with
# TEXT-OTHERWISE.
#
# INPUTS
#   AT_CVS_clientserver		empty or `-r', per AT_CVS_INCLUDE
#
m4_define([AT_CVS_REMOTE],
[m4_ifval(m4_quote(AT_CVS_clientserver),
[$1],[$2])dnl m4_ifval(AT_CVS_clientserver)
])# AT_CVS_REMOTE



# AT_CVS_LOCAL(TEXT)
# ------------------
# Replace with TEXT only in local mode.
#
# INPUTS
#   AT_CVS_clientserver		empty or `-r', per AT_CVS_INCLUDE
#
m4_define([AT_CVS_LOCAL],[AT_CVS_REMOTE([$2],[$1])])



# AT_CVS_CHECK_NORMALIZED(COMMANDS, [STATUS = 0], [STDOUT = ``''],
#                         [STDERR = ``''], [RUN-IF-FAIL], [RUN-IF-PASS])
# ----------------------------------------------------------------------
# Like AT_CHECK, but normalize output from CVS to remove differences between
# client and server operation.
#
# Replaces:
#   1. s/^(($CPROG|$SPROG) \[?)[a-z]*( aborted\])?/\1command\3/
#   2. s/^P /U /
#   3. RFC ???? Dates, as generated by `cvs diff' with RFCDATE
m4_define([AT_CVS_CHECK_NORMALIZED],
[AT_CHECK([$1],[$2],[stdout],[stderr],[$5])

dnl The sed commands below need to be quoted twice so that all the autotest
dnl quotes make it through to the sed commands.
[sed \
    -e "s/[0-9][0-9]* [a-zA-Z][a-zA-Z]* [0-9][0-9]* [0-9:][0-9:]* -0000/RFCDATE/" \
    -e "s/^P /U /" \
    <stdout >nstdout]
rm stdout

AT_CHECK_NOESCAPE([(cat nstdout; cat stderr >&2)],,[$3],[$4],[$5],[$6])
rm stderr nstdout])# AT_CVS_CHECK_NORMALIZED



# AT_CVS_CHECK_ANNOTATE(COMMANDS, [STATUS = 0], [STDOUT = ``''],
#                       [STDERR = ``''], [RUN-IF-FAIL], [RUN-IF-PASS])
#
# Like AT_CVS_CHECK_NORMALIZED, but designed specifically for `cvs annotate'.
# Specifically, replace the username date portion of each line annotation
# with the string `USERNAME DATE'.
# --------------------------------------------------------------------
m4_defun([AT_CVS_CHECK_ANNOTATE],
[AT_KEYWORDS([annotate])dnl
# Skip this group if we don't know our username
AT_CHECK([$as_cvs_have_username || exit 77])

# Set $nsrname to $username normalized to account for the fact that most CVS
# output is optimized to print $username in 8 characters.
nsrname=`echo "$username        " |sed 's/^\(........\).*$/\1/'`

# Now for the actual test
AT_CHECK([$1],[$2],[stdout],[stderr],[$5])

# Normalize the output of the previous command
dnl The sed commands below need to be quoted twice so that all the autotest
dnl quotes make it through to the sed commands.
[sed -e "s/($nsrname [0-9][0-9]-[A-Z][a-z][a-z]-[0-9][0-9])/(USERNAME DATE)/" \
    <stdout >nstdout]
rm stdout

AT_CHECK([(cat nstdout; cat stderr >&2)],,[$3],[$4],[$5],[$6])
rm stderr nstdout])# AT_CVS_CHECK_ANNOTATE



# AT_CVS_CHECK_LOG(COMMANDS, [STATUS = 0], [STDOUT = ``''],
#                  [STDERR = ``''], [RUN-IF-FAIL], [RUN-IF-PASS])
#
# Like AT_CVS_CHECK_NORMALIZED, but specifically for testing `cvs log'.
# Specifically, this replaces dates with the string `DATE' and the current
# username in the author field with the string `USERNAME'.
# --------------------------------------------------------------------
m4_defun([AT_CVS_CHECK_LOG],
[AT_KEYWORDS([log])dnl
# Skip this group if we don't know our username
AT_CHECK([$as_cvs_have_username || exit 77])

# Set $nsrname to $username normalized to account for the fact that most CVS
# output is optimized to print $username in 8 characters.
nsrname=`echo "$username" |sed 's/^\(.\{1,8\}\).*$/\1/'`

# Now for the actual test
AT_CHECK([$1],[$2],[stdout],[stderr],[$5])

# Normalize the output of the previous command
dnl The sed commands below need to be quoted twice so that all the autotest
dnl quotes make it through to the sed commands.
[sed -e "s,^date: 2[0-9][0-9][0-9]/[01][0-9]/[0-3][0-9] [0-2][0-9]:[0-6][0-9]:[0-6][0-9];  author: $nsrname;  ,date: DATE;  author: USERNAME;  ," \
    <stdout >nstdout]
rm stdout

AT_CHECK_NOESCAPE([(cat nstdout; cat stderr >&2)],,[$3],[$4],[$5],[$6])
rm stderr nstdout])# AT_CVS_CHECK_LOG



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
])# AT_CVS_INCLUDE



# AS_CVS_FIND_TOOL([VARIABLE],[GNU-TOOL],[TEST])
# -------------------------------------------------------------------------
# If shell code TEST fails, then look for a GNU replacement.  The
# environment variable $VARIABLE will contain the path to the current tool to
# be tested when the shell code TEST is run.  Assign result to shell variable
# VARIABLE.  Sets as_cvs_have_VARIABLE to `:' if a usable tool is found and to
# `false' otherwise.
m4_defun([AS_CVS_FIND_TOOL],
[$1=$2
as_cvs_process=:
as_cvs_have_$1=false
_AS_PATH_WALK([$PATH$PATH_SEPERATOR/usr/local/bin$PATH_SEPERATOR/usr/contrib/bin$PATH_SEPERATOR/usr/gnu/bin$PATH_SEPERATOR/local/bin$PATH_SEPERATOR/local/gnu/bin$PATH_SEPERATOR/gnu/bin],
[AS_IF([$as_cvs_process && $3],
[as_cvs_have_$1=:
break])
as_cvs_process=false
# prefer the GNU versions of tools
for tool in g$2 $2; do
  AS_IF([test -f $as_dir/$tool && test -r $as_dir/$tool &&
         RES=`$as_dir/$tool --version </dev/null 2>/dev/null`],
        [AS_IF([test "X$RES" != "X--version" && test "X$RES" != "X"],
               [$1=$as_dir/$tool; as_cvs_process=:; break])])
done])dnl _AS_PATH_WALK
])# AS_CVS_FIND_TOOL
