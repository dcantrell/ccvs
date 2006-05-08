#! @PERL@ -T
# -*-Perl-*-

# Copyright (C) 1994-2005 The Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# Perl filter to handle pre-commit checking of files.
#
# The CVS workflow is:
# - process all commitinfo hooks
# - actually commit
# - process all loginfo hooks
#
# This program records the last directory where commits will be taking
# place for use by the log_accum.pl script.
#
# IMPORTANT: commit_prep and log_accumy have to agree on the tmpfile
# name to use.  See $LAST_FILE below.
#
# Sample CVSROOT/commitinfo:
# ALL /usr/local/bin/commit_prep -T ccvs_1 %r/%p
# ^prog1\(/\|$\) /usr/local/bin/commit_prep -T ccvs_2 %r/%p
#
# Contributed by David Hampton <hampton@cisco.com>
# Stripped to minimum by Roy Fielding
# Changes by Sylvain Beucler <beuc@beuc.net> (2006-05-08):
# - option -T added again to support multiple log_accum hooks
# - deprecated misleading option -u
# - used 'use strict' and added compatibility for 'perl -T' switch
# - documented some more
# - removed $cvs_user in the temporary filename - its value is not
#   compatible with log_accum's and it's safer to use -T
#
############################################################

use strict;

# CONSTANTS
my $TMPDIR          = '/tmp';
my $FILE_PREFIX     = '#cvs.';


# Options
my $hook_identifier = '';
my $full_directory_path = '';

while (@ARGV) {
    my $arg = shift @ARGV;

    # If see a "-u $USER" argument, then destructively remove it from
    # the argument list, so $ARGV[0] will be the repository dir again,
    # as it used to be before we added the -u flag.
    # This option was used to build $LIST_FILE, but this is not safe
    # wrt multiple hooks. Check -T.
    if ($arg eq '-u') {
	my $param = shift (@ARGV);
	if ($param =~ /^([a-zA-Z0-9_.-]+)$/) { # POSIX
	    $hook_identifier = $1;
	    warn "Using deprecated -u option. Use -T instead."
	} else {
	    die "Invalid username passed to option -u: $param";
	}
    # -T is a string to be included in the $last_file filename. It is
    # necessary to pass different -T options to commit_prep if you
    # need to call it for different scripts in the same commit (eg:
    # call log_accum with different parameters in module/ and in ALL)
    } elsif ($arg eq '-T') {
	my $param = shift (@ARGV);
	if ($param =~ /^([a-zA-Z0-9_.-]+)$/) {
	    $hook_identifier = $1;
	} else {
	    die "Invalid identifier passed to option -T: $param";
	}
    # The non-option argument is the complete path to the current
    # commit directory
    } else {
	# It is written in a file and read by log_accum after being
	# character-escaped. No security issues here. We still check
	# for '..' and ensure this is a full path.
	if (($arg !~ /\/..(\/|\$)/) and ($arg =~ /^(\/.*)$/)) {
	    $full_directory_path = $1;
	} else {
	    die "Commit path must be a full path, not a relative one: $arg";
	}
    }
}

if ($full_directory_path eq '') {
    die "Usage: $0 [-T hook_identifier] current_commit_path"
}


# This needs to match the corresponding var in log_accum.pl, including
# the appending of the pgrp and hook identifier suffixes (see uses of
# this var farther down).
my $id = getpgrp();
my $last_file = "$TMPDIR/${FILE_PREFIX}${hook_identifier}.$id.lastdir";

# Record this directory as the last one checked.  This will be used
# by the log_accumulate script to determine when it is processing
# the final directory of a multi-directory commit.
open(FILE, "> $last_file") || die("Cannot open $last_file: $!\n");
print(FILE $full_directory_path, "\n");
close(FILE);

exit(0);
