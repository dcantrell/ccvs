#! @PERL@ -T
# -*-Perl-*-

# Copyright (C) 1994-2006 The Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# Perl filter to handle the log messages from the checkin of files in
# a directory.  This script will group the lists of files by log
# message, and mail a single consolidated log message at the end of
# the commit.
#
# This file assumes a pre-commit checking program that leaves the
# names of the last commit directory in a temporary file.
#
# IMPORTANT: what the above means is, this script interacts with
# commit_prep, in that they have to agree on the tmpfile name to use.
# See $LAST_FILE below. 
#
# How this works: CVS triggers this script once for each directory
# involved in the commit -- in other words, a single commit can invoke
# this script N times.  It knows when it's on the last invocation by
# examining the contents of $LAST_FILE.  Between invocations, it
# caches information for its future incarnations in various temporary
# files in /tmp, which are named according to the process group and
# TODO the committer (by themselves, neither of these are unique, but
# together they almost always are, unless the same user is doing two
# commits simultaneously).  The final invocation is the one that
# actually sends the mail -- it gathers up the cached information,
# combines that with what it found out on this pass, and sends a
# commit message to the appropriate mailing list.
#
# (Ask Karl Fogel <kfogel@collab.net> if questions.)
#
# Contributed by David Hampton <hampton@cisco.com>
# Roy Fielding removed useless code and added log/mail of new files
# Ken Coar added special processing (i.e., no diffs) for binary files
# Changes by Sylvain Beucler <beuc@beuc.net> (2006-05-08):
# - option -T added again to support multiple log_accum hooks
# - used 'use strict' and added compatibility for 'perl -T' switch
# (and found a ghost variable!)
# - documented some more
# - fixed a bug in processing -u in log_accum
# - cleaned-up the temporary filenames
# - fixed support for UseNewInfoFmtStrings
# - test if files are empty, so they are not reported as binary
# - -r now also accepts 'HEAD' as argument (clearer than '')
# - viewcvs URL's for binary files now use application/octet-stream
# content type; diff URLs are also more compatible with viewcvs
# (removed '.diff')
# - do not perform a diff if a file is added or removed
# Derek Price (2006-05-08):
# - Perform the diff if added or removed unless -E is specified.

use strict;

use Getopt::Long qw(:config gnu_getopt require_order);

############################################################
#
# Configurable options
#
############################################################
#
# The newest versions of CVS have UseNewInfoFmtStrings=yes
# to change the arguments being passed on the command line.
# If you are using %1s on the command line, then set this
# value to 0.
# 0 = old-style %1s format. use split(' ') to separate ARGV into filesnames.
# 1 = new-style %s format. Note: allows spaces in filenames.
my $UseNewInfoFmtStrings = 1;

# If you are using CVS web or ViewCVS, then set these.  When set properly, this
# will cause links to aspects of the commit to print in the commit emails.
my $CVSWEB_SCHEME = "http";
my $CVSWEB_DOMAIN = "cvs.sv.gnu.org";
my $CVSWEB_PORT   = "80";
my $CVSWEB_URI    = "viewcvs";
my $SEND_URL      = "true";

# Paths.
my $CVSBIN        = "/usr/bin";
my $TMPDIR        = "/tmp";

# Set this to a domain to have CVS pretend that all users who make
# commits have mail accounts within that domain.
# my $EMULATE_LOCAL_MAIL_USER="nongnu.org"; 
my $EMULATE_LOCAL_MAIL_USER=''; 
my @MAIL_CMD      = ("/usr/lib/sendmail", "-i", "-t");
my $MAIL_CMD_NEEDS_ADDRS;
#my @MAIL_CMD      = ("/bin/socketmail", $ENVELOP_SENDER);
#my $MAIL_CMD_NEEDS_ADDRS = 1;
#my $MAIL_CMD         = ("/var/qmail/bin/qmail-inject");



############################################################
#
# Constants - DO NOT CHANGE THESE.
#
############################################################
my $STATE_NONE    = 0;
my $STATE_CHANGED = 1;
my $STATE_ADDED   = 2;
my $STATE_REMOVED = 3;
my $STATE_LOG     = 4;



############################################################
#
# Global variables
#
############################################################
my $debug;



############################################################
#
# Subroutines
#
############################################################

# FIXME: Temporarily disabled.
#
# do an 'cvs -Qn status' on each file in the arguments, and extract info.
#
#sub change_summary {
#    my ($out, $toplevel, $module, $oldrev, $newrev, @filenames) = @_;
#    my ($file, $rcsfile, $line, $vhost);
#
#    while (@filenames) {
#        $file = shift @filenames;
#
#        if ("$file" eq "") {
#            next;
#        }
#
#        my $delta = "";
#        $rcsfile = "$module/$file";
#
#        if ($oldrev->{$file}) {
#            open(RCS, "-|") || exec "$CVSBIN/cvs", '-Qn', 'log',
#				    "-r" . $newrev->{$file},
#				    "--", $file;
#            while (<RCS>) {
#                if (/^date:.*lines:([^;]+);.*/) {
#                    $delta = $1;
#                    last;
#                }
#            }
#            close(RCS);
#        }
#
#        my $diff = "\n\n";
#
#	if ($SEND_URL eq "true")
#        {
#	    # FIXME: Store this in a separate list.
#
#	    $diff = "$CVSWEB_SCHEME://$CVSWEB_DOMAIN";
#	    $diff .= ":$CVSWEB_PORT" unless $CVSWEB_PORT eq "80";
#	    $diff .= "/$CVSWEB_URI/$toplevel/$module/$file";
#        }
#
#        #
#        # If this is a binary file, don't try to report a diff; not only is
#        # it meaningless, but it also screws up some mailers.  We rely on
#        # Perl's 'is this binary' algorithm; it's pretty good.  But not
#        # perfect.
#        #
#        if ($file =~ /\.(?:pdf|gif|jpg|mpg)$/i or -B $file) {
#          if ($SEND_URL eq "true")
#	  {
#            $diff .= "&pathrev=" . $newrev->{$file};
#	    $diff .= "&content-type=application/octet-stream\n\n";
#          }
#	  $diff .= "\t[Binary file]\n\n" if $SEND_DIFF eq "true";
#        }
#        else {
#            #
#            # Get the differences between this and the previous revision,
#            # being aware that new files always have revision '1.1' and
#            # new branches always end in '.n.1'.
#            #
#            if ($SEND_URL eq "true") {
#              if (!$oldrev->{$file} || !$newrev->{$file}) {
#                $diff .= "&rev=" . $oldrev->{$file};
#		$diff .= "&content-type=text/x-cvsweb-markup\n\n";
#              } else {
#                $diff .= "&r1=" . $oldrev->{$file};
#		$diff .= "&r2=" . $newrev->{$file}. "\n\n";
#              }
#	    }
#
#            if ($SEND_DIFF eq "true"
#		and ($SUPPRESS_DIFFS_AGAINST_EMPTIES eq "false"
#		     or ($oldrev->{$file} and $newrev->{$file}))) {
#	      # Depends on user options, so let's remove that:
#              #$diff .= "(In the diff below, changes in quantity "
#              #      . "of whitespace are not shown.)\n\n";
#              open(DIFF, "-|")
#                || exec "$CVSBIN/cvs", '-Qn', 'diff', '-N', @diffargs,
#                "-r" . $oldrev->{$file}, "-r" . $newrev->{$file}, '--', $file;
#
#              while (<DIFF>) {
#                $diff .= $_;
#              }
#              close(DIFF);
#
#              $diff .= "\n\n";
#           }
#        }
#
#        append_line $out, sprintf "%-9s%-12s%s%s",
#				  $newrev->{$file} ? $newrev->{$file} : "dead",
#				  $delta, $rcsfile, $diff;
#    }
#}



#######              ######
#######   REVIEWED   ######
#######              ######



# Set the default configuration values.  This should be called after
# process_argv since it assumes that undefined values in config mean that
# the option was not specified on the command line.
#
# Config hash values:
#	mail-to		Reference to array of email destinations.
#	debug		Print debugging information.
#	tag		Reference to array of tags to send email for.
#	url		Base URL for cvsweb.
#	cvsroot		CVSROOT for use with cvsweb.
#	send-diff	Send diffs in email.
#	diff-arg	Reference to array of diff arguments.
#	empty-diffs 	Send diffs from new files or to removed files.
#	file-text	Text to include in temp file names.
sub set_defaults
{
    my ($config) = @_;

    # Anything not set will default to false in Perl.

    # Sanity checks.
    die "No email destination specified." unless exists $config->{'mail-to'};
    die "cvsweb CVSROOT specified without --url."
	if exists $config->{'cvsroot'} && !exists $config->{'url'};
    die "--send-diff must be set for --diff-arg or -E to be meaningful."
	if exists $config->{'send-diff'} && !$config->{'send-diff'}
	   && (exists $config->{'empty-diffs'}
	       || exists $config->{'diff-arg'});

    # Set defaults.
    $config->{'send-diff'} = 1 if !exists $config->{'send-diff'};
    $config->{'empty-diffs'} = 1 if !exists $config->{'empty-diffs'};
    $config->{'diff-arg'} = ["-ub"] if !exists $config->{'diff-arg'};
    $config->{'file-text'} = "cvs" if !exists $config->{'file-text'};

    # Just set $debug in a global.  It's easier.
    $debug = $config->{'debug'};

    if ($debug)
    {
	for ("debug", "tag", "url", "cvsroot", "send-diff",
	     "empty-diffs", "file-text")
	{
	    print STDERR "config{$_} => ", $config->{$_}, "\n";
	}
	for ("mail-to", "diff-arg")
	{
	    print STDERR "config{$_} => ", join (":", @{$config->{$_}}), "\n";
	}
    }
}



## process the command line arguments sent to this script
## it returns an array of files, %s, sent from the loginfo
## command
#
# Required:
#   -m EMAIL
#   --mail-to EMAIL
#		- Add mailto address.
#
# Optional features:
#   -c CONFIG
#   --config CONFIG
#		- Read configuration from CONFIG.  Command line options will
#		  always override values in CONFIG.
#   -r TAG
#   --only-tag TAG
#   --tag TAG	- operate only on changes in tag/branch TAG
#		  Use -r "", -rHEAD, or -rTRUNK for only changes to TRUNK.
#   -T TEXT
#   --file-text TEXT
#   --file-prefix TEXT
#		- use TEXT in temporary file names.
#   -u USER	- Set CVS username to USER (deprecated).
#   -v		
#   --verbose
#   --debug	- Output debugging information.
#
# Optional output:
#   -f LOGFILE
#   --commit-log LOGFILE
#		- Output copy of commit emails to LOGFILE.
# * -G DB	- Interface to Gnats.
#
# cvsweb URL support:
# * -U URL
#   --cvsweb URL
#   --url URL	- Send URLs to diffs in email, using base URL for cvsweb.
# * -C CVSROOT
#   --cvsroot CVSROOT
#		- Use CVSROOT in cvsweb URLs instead of $CVSROOT.
#
# Diff support:
# * -d
#   --diff
#   --send-diff	- (defult) Send diffs in emails.
# * -D DIFF_ARG
#   --diff-arg DIFF_ARG
#		- Pass DIFF_ARG to `cvs diff' when generating diffs.  Defaults
#		  to `-ub'.  Multiple invocations will pass all DIFF_ARGS
#		  (though first invocation always removes the default `-ub').
#		  Implies `-d'.
# * -E
#   --suppress-diffs-against-empties
#		- Suppress diffs from added files and to removed files.
#		  Implies `-d'.
#   -e
#   --empty-diffs
#		- (default) Negates -E.  Implies `-d'.
# * -S		- Separate diff emails.  Implies `-d'.
#
sub process_argv
{
    my ($arg, $donefiles);
    my (%config, $module, @files, %oldrev, %newrev);

    my @option_spec = ("config|c=s",
		       "mail-to|m=s@",
		       "tag|only-tag|r=s@",
		       "file-prefix|file-text|T=s", "user|u=s",
		       "debug|verbose|v!",
		       "quiet|q!",
		       "commit-log|f=s",
		       "url|cvsweb|U=s",
		       "cvsroot|C=s",
		       "send-diff|diff|d!",
		       "diff-arg|D=s@",
		       "suppress-diffs-against-empties|E!",
		       "empty-diffs|e!",
		       "separate-diffs|S!");

    # Set up the option processing functions.
    $config{'only-tags'} =
	sub
	{
	    $_[1] = '' if $_[1] eq "HEAD" || $_[1] eq "TRUNK";
	    push @{$config{'tag'}}, $_[1];
	};
    $config{'quiet'} =
	sub
	{
	    $config{'verbose'} = !$_[1];
	};
    $config{'file-prefix'} =
	sub
	{
	    die "Invalid identifier passed to option $_[0]: $_[1]"
		unless $_[1] =~ /^([a-zA-Z0-9_.-]+)$/;
	    $config{'file-text'} = $1;
	};
    $config{'user'} =
	sub
	{
	    warn "Using deprecated -u option. Use -T instead.";
	    &{$config{'file-text'}} (@_);
	};
    $config{'suppress-diffs-against-empties'} =
	sub
	{
	    $config{'empty-diffs'} = !$_[1];
	};
	
    # Copy @ARGV to reuse it.
    my @args = @ARGV;

    # Get the options.
    die "argument parsing failed"
	unless GetOptions (\%config, @option_spec);

    if (exists $config{'config'})
    {
	@ARGV = ();
	open CONFIG, "<" . $config{'config'}
	    or die "can't open ", $config{'config'}, ": $!";
	while (<CONFIG>)
	{
	    # Skip comments and lines with nothing but blanks.
	    next if /^\s*(#.*)?$/;

	    # Split it.
	    chomp;
	    /^(\S*)(\s+(.*))?$/;

	    # Save the option.
	    push @ARGV, "--$1";

	    # There is a difference between no argument and an empty string
	    # argument.
	    push @ARGV, $3 if $2;
	}

	# Get the options from the config file.
	die "argument parsing failed"
	    unless GetOptions (\%config, @option_spec);

	# Reparse the command line options so they may overide the config file.
	@ARGV = @args;
	die "argument parsing failed"
	    unless GetOptions (\%config, @option_spec);
    }

    # Get the path and the file list.
    $module = shift @ARGV;
    if ($UseNewInfoFmtStrings)
    {
	while (@ARGV)
	{
	    my $filename = shift @ARGV;
	    die "path in file name `$filename'"
		unless $filename =~ m#^([^/]+)$#;
	    $filename = $1;
	    push @files, $filename;

	    $oldrev{$filename} = shift @ARGV
		or die "No previous revision given for $filename";
	    $newrev{$filename} = shift @ARGV
		or die "No new revision given for $filename";

	    # Simplify diffs.
	    $oldrev{$filename} = 0 if $oldrev{$filename} eq "NONE";
	    $newrev{$filename} = 0 if $newrev{$filename} eq "NONE";

	    # Untaint.
	    die "invalid old revision $oldrev{$filename}"
		unless $oldrev{$filename} =~ /^([0-9.]+)$/;
	    $oldrev{$filename} = $1;
	    die "invalid new revision $newrev{$filename}"
		unless $newrev{$filename} =~ /^([0-9.]+)$/;
	    $newrev{$filename} = $1;
	}
    }
    else
    {
	# Old style info strings preficed the module path with $CVSROOT.
	my $module =~ s/^\Q$ENV{'CVSROOT'}\E//;

	my @files;
	push @files, split ' ', shift @ARGV;
	for (@files)
	{
	    s/,([^,]+),([^,]+)$//
		or die "Not enough modifiers for $_";
	    $oldrev{$_} = $1;
	    $newrev{$_} = $2;
	    $oldrev{$_} = 0 if $oldrev{$_} eq "NONE";
	    $newrev{$_} = 0 if $newrev{$_} eq "NONE";
	}

	die "Too many arguments." if @ARGV;
    }

    set_defaults \%config;

    return \%config, $module, \@files, \%oldrev, \%newrev;
}



# Turn the log input on STDIN into useful data structures.
sub process_stdin
{
    my ($module, @files) = @_;
    my $state = $STATE_NONE;
    my (@branch_lines, @changed_files, @added_files,
	@removed_files, @log_lines);

    #
    # Iterate over the body of the message collecting information.
    #
    while (<STDIN>)
    {
	chomp;                      # Drop the newline
	if (/^\s*(Tag|Revision\/Branch):\s*(\w+)/)
	{
	    push @branch_lines, $2;
	    next;
	}
	if (/^Modified Files/) { $state = $STATE_CHANGED; next; }
	if (/^Added Files/)    { $state = $STATE_ADDED;   next; }
	if (/^Removed Files/)  { $state = $STATE_REMOVED; next; }
	if (/^Log Message/)    { $state = $STATE_LOG;     last; }

	next if $state == $STATE_NONE || $state == $STATE_LOG;
	next if /^\s*$/;              # ignore empty lines

	# Sort the file list.  This algorithm is a little cumbersome, but it
	# handles file names with spaces.
	my @matched;
	while (!/^\s*$/)
	{
	    my $m;
	    for (my $i = 0; $i <= $#files; $i++)
	    {
		if (/^\t\Q$files[$i]\E /)
		{
		    #print "matched $files[$i]\n";
		    $m = $i if !defined $m
			       or length $files[$m] < length $files[$i];
		}
	    }
	    last if !defined $m;

	    s/^\t\Q$files[$m]\E /\t/;
	    push @matched, $files[$m];
	    splice @files, $m, 1;
	}

	# Assertions.
	die "unrecognized file specification: `$_'" unless @matched;
	die "unrecognized file(s): `$_'" unless /^\s*$/;

	# Store.
	push @changed_files, @matched and next if $state == $STATE_CHANGED;
	push @added_files, @matched and next if $state == $STATE_ADDED;
	push @removed_files, @matched and next if $state == $STATE_REMOVED;

	# Assertion.
	die "unknown file state $state";
    }

    # Process the /Log Message/ section now, if it exists.
    # Do this here rather than above to deal with Log messages
    # that include lines that confuse the state machine.
    if (!eof(STDIN)) {
	while (<STDIN>) {
	    next unless $state == $STATE_LOG; # eat all STDIN

	    if (/^\s*\[(bug|pr|task) #(\d+)\]/)
	    {
		# FIXME: Set the bug/patch ID to "$1 #$2" so that the issue
		# database may be updated.
	    }
	    chomp;
	    push @log_lines, $_;
	}
    }

    #
    # Strip leading and trailing blank lines from the log message.  Also
    # compress multiple blank lines in the body of the message down to a
    # single blank line.
    # (Note, this only does the mail and changes log, not the rcs log).
    #
    while ($#log_lines > -1) {
	last unless $log_lines[0] =~ /^\s*$/;
	shift @log_lines;
    }
    while ($#log_lines > -1) {
	last unless $log_lines[$#log_lines] =~ /^\s*$/;
	pop @log_lines;
    }
    for (my $i = $#log_lines - 1; $i > 0; $i--)
    {
	splice @log_lines, $i, 1
	    if $log_lines[$i - 1] =~ /^\s*$/ && $log_lines[$i] =~ /^\s*$/;
    }

    return \@branch_lines, \@changed_files, \@added_files,
	   \@removed_files, \@log_lines;
}



sub build_header
{
    my ($toplevel, $branch, $username, $fullname, $mailname) = @_;
    my @header;
    delete $ENV{'TZ'};
    my ($sec, $min, $hour, $mday, $mon, $year) = localtime time;

    push @header, "CVSROOT:\t$ENV{CVSROOT}";
    push @header, "Module name:\t$toplevel";
    push @header, "Branch:\t\t$branch" if $branch;

    push @header,
	 sprintf "Changes by:\t%s%s<%s>\t%02d/%02d/%02d %02d:%02d:%02d",
                 $fullname, $fullname ? " " : "",
		 $mailname ? $mailname : $username,
		 $year%100, $mon+1, $mday, $hour, $min, $sec;

    push @header, "";

    return @header;
}



# Return username, fullname, and email for the change's author, when
# available.
sub getuserdata
{
    my ($username, $fullname, $mailname);

    if ($ENV{'CVS_USER'})
    {
	# Only set via pserver access.

	$username = $ENV{'CVS_USER'};

	# FIXME: Should look up an email address in the CVSROOT/users file
	# used by `cvs watch'.  For now, let the mailer determine an address
	# itself.
    }
    elsif (my @pwent = getpwuid $<)
    {
	if (@pwent)
	{
	    $username = $pwent[0];

	    if ($pwent[6] =~ /^([^<]*)\s+<(\S+@\S+)>/)
	    {
		$fullname = $1;
		$mailname = $2;
	    }
	    else
	    {
		$fullname = $pwent[6];
		$fullname =~ s/,.*$//;

		# Don't set $mailname - let the mailer determine one itself if
		# an explicit one cannot be found.
	    }
	}
    }
    else
    {
	$username = sprintf "uid#%d", $<;

	# Don't set $mailname - let the mailer come up with one itself if an
	# explicit one cannot be found.
    }

    # Replace the mail name when requested.
    $mailname = "$username\@$EMULATE_LOCAL_MAIL_USER"
	if $EMULATE_LOCAL_MAIL_USER;

    return $username, $fullname, $mailname;
}



sub mail_notification
{
    my ($addr_list, $module, $username, $fullname, $mailfrom,
	$subject, @text) = @_;

    my $mail_to = join ", ", @$addr_list;

    my @mailcmd;

    print STDERR "Mailing the commit message to $mail_to (from "
		 . ($mailfrom ? $mailfrom : $username) . ")\n" if $debug;

    $ENV{'MAILUSER'} = $mailfrom if $mailfrom;
 
    push @mailcmd, @MAIL_CMD;
    push @mailcmd, @$addr_list if $MAIL_CMD_NEEDS_ADDRS;
    push @mailcmd, "-f$mailfrom" if $mailfrom;
    # else let the system determine how to send mail.

    open MAIL, "|-" or exec @mailcmd;

    # Parent.
    $SIG{'PIPE'} = sub {die "whoops, pipe broke."};

    print MAIL "To: $mail_to\n";
    # $fullname may be empty, but the extra spaces won't hurt.
    print MAIL "From: $fullname <$mailfrom>\n" if $mailfrom;
    print MAIL "Subject: $subject\n";
    print MAIL "\n";
    print MAIL join "\n", @text;

    close MAIL or warn "child exited $?";
}



# Return an array containing file names and file name roots:
# (LAST_FILE, LOG_BASE, BRANCH_BASE, ADDED_BASE, CHANGED_BASE,
#  REMOVED_BASE, URL_BASE)
sub get_temp_files
{
    my ($tmpdir, $temp_name, $id) = @_;

    print STDERR "get_temp_files: $tmpdir, $temp_name, $id\n" if $debug;

    # Created by commit_prep!
    return "$tmpdir/#$temp_name.$id.lastdir",
	   "$tmpdir/#$temp_name.$id.log",
	   "$tmpdir/#$temp_name.$id.branch",
	   "$tmpdir/#$temp_name.$id.added",
	   "$tmpdir/#$temp_name.$id.changed",
	   "$tmpdir/#$temp_name.$id.removed",
	   "$tmpdir/#$temp_name.$id.urls";
}



sub format_names
{
    my ($toplevel, $dir, @files) = @_;
    my @lines;

    $dir =~ s#^\Q$toplevel\E/##;
    $dir =~ s#/$##;
    $dir = "." if $dir eq "";

    my $format = "\t%-";
    $format .= sprintf "%d", length ($dir) > 15 ? length ($dir) : 15;
    $format .= "s%s ";

    $lines[0] = sprintf $format, $dir, ":";

    print STDERR "format_names(): dir = ", $dir, "; files = ",
		 join (":", @files), ".\n"
	if $debug;

    foreach (@files)
    {
	s/^.*\s.*$/`$&'/;
	$lines[++$#lines] = sprintf $format, " ", " "
	    if length ($lines[$#lines]) + length ($_) > 65;
	$lines[$#lines] .= $_ . " ";
    }

    @lines;
}



sub format_lists
{
    my ($toplevel, @lines) = @_;
    my (@text, @files, $dir);

    print STDERR "format_lists(): ", join (":", @lines), "\n" if $debug;

    $dir = shift @lines;	# first thing is always a directory
    die "Damn, $dir doesn't look like a directory!" if $dir !~ m#.*/$#;

    foreach my $line (@lines)
    {
	if ($line =~ m#.*/$#)
	{
	    push @text, format_names $toplevel, $dir, @files;
	    $dir = $line;
	    die "Damn, $dir doesn't look like a directory!" if $dir !~ m#.*/$#;
	    @files = ();
	}
	else
	{
	    push @files, $line;
	}
    }

    push @text, format_names $toplevel, $dir, @files;

    return @text;
}



sub compile_subject
{
    my ($branch, @list) = @_;
    my $text;

    # This uses the simplifying assumptions that no dir is equal to `' or `.'
    # and that all directories have been normalized,  This is okay because
    # commit_prep rejects the toplevel project as input and all the directory
    # names were normalized before being written to the change files.

    print STDERR "compile_subject(): ", $branch ? "[$branch] " : "",
		 join (":", @list), "\n"
	if $debug;

    # Find the highest common directory.
    my @dirs = grep m#/$#, @list;
    map s#/$##, @dirs;
    my @topsplit = split m#/#, $dirs[0];
    for (my $i = 1; $i <= $#dirs; $i++)
    {
	my @dirsplit = split m#/#, $dirs[$i];
	for (my $j = 0; $j <= $#topsplit and $j <= $#dirsplit; $j++)
	{
	    if ($topsplit[$j] ne $dirsplit[$j])
	    {
		splice @topsplit, $j;
		last;
	    }
	}
	last unless @topsplit;
    }

    my $topdir = join "/", @topsplit;
    # $topdir may be empty.

    # strip out directories and the common prefix $topdir.
    my $offset = length $topdir;
    $offset++ if $offset > 0;

    my @out;
    push @out, $topdir if $topdir;

    
    my $dir = shift @list;
    die "Darn, $dir doesn't look like a directory!" unless $dir =~ s#/$##;
    $dir = substr $dir, $offset;

    # Build the list of files with directories prepended.
    foreach (@list)
    {
	if (m#/$#)
	{
	    $dir = $_;
	    $dir = substr $dir, $offset;
	    next;
	}

	my $file = "$dir$_";
	$file = "`$file'" if $file =~ /\s/;
	push @out, $file;
    }

    # put it together and limit the length.
    $text = join " ", @out;
    substr $text, 47, length ($text), "..." if length ($text) > 50;

    $text .= " [$branch]" if $branch;

    return $text;
}



sub read_logfile
{
    my ($filename) = @_;
    my @text;

    open FILE, "<$filename" or die "Cannot open log file $filename: $!";
    while (<FILE>)
    {
        chomp;
        push @text, $_;
    }
    close FILE;
    return @text;
}


sub push_formatted_lists
{
    my ($text, $subject_files, $toplevel, $section, $filename) = @_;

    print STDERR "push_formatted_lists(): $section $filename\n" if $debug;

    my @lines = read_logfile $filename;
    if (@lines)
    {
	push @$text, $section;
	push @$text, format_lists $toplevel, @lines;
	push @$subject_files, @lines if $subject_files;
    }
}



sub append_to_file
{
    my ($filename, $dir, @files) = @_;

    if (@files)
    {
	open FILE, ">>$filename" or die "Cannot open file $filename: $!";

	# Normalize $dir, removing ./ indirections and condensing consecutive
	# slashes.
	$dir =~ s#(^|/)(\./)+#$1#g;
	$dir =~ s#//+#/#g;
	print FILE $dir, "/\n";

	print FILE join ("\n", @files), "\n";
	close FILE;
    }
}



sub build_message_body
{
    my ($toplevel, $branch,
	$changed_file, $added_file, $removed_file, $log_file) = @_;
    my ($subject, @body, @log_text);
    my @subject_files;

    push_formatted_lists \@body, \@subject_files, $toplevel,
			 "Modified files:", $changed_file;
    push_formatted_lists \@body, \@subject_files, $toplevel,
			 "Added files:", $added_file;
    push_formatted_lists \@body, \@subject_files, $toplevel,
			 "Removed files:", $removed_file;
    push @body, "";

    @log_text = read_logfile $log_file;
    push @body, "Log message:";
    push @body, @log_text;
    push @body, "";

    $subject = compile_subject $branch, @subject_files;

    return $subject, \@body, \@log_text;
}



sub write_file
{
    my ($filename, @lines) = @_;

    open FILE, ">$filename" or die "Cannot open file $filename: $!";
    print FILE join ("\n", @lines), "\n";
    close FILE;
}



sub append_file
{
    my ($filename, @lines) = @_;

    open FILE, ">>$filename" or die "Cannot open file $filename: $!";
    print FILE join ("\n", @lines), "\n";
    close FILE;
}



sub cleanup_tmpfiles
{
    my ($tmpdir, $prefix, $id) = @_;
    my @files;

    die "$tmpdir does not exist" unless -d $tmpdir;
    opendir DIR, $tmpdir or die "Can't read $tmpdir: $!";

    push @files, grep /^#\Q$prefix\E\.$id.*\.$/, readdir DIR;
    closedir DIR;

    foreach (@files)
    {
        unlink "$tmpdir/$_";
    }
}



sub read_line
{
    my ($filename) = @_;
    my $line;

    open FILE, "<$filename" or die "Cannot open file $filename: $!";
    $line = <FILE>;
    close FILE;
    chomp $line;
    return $line;
}



#############################################################
#
# Main Body
#
############################################################
sub main
{
    #
    # Setup and clean up environment
    #
    umask (002);
    $ENV{"PATH"} = "/bin";
    delete @ENV{qw(IFS CDPATH ENV BASH_ENV)};

    #
    # Initialize basic variables
    #
    my $id = getpgrp();  # NOTE: You *must* use a shell which does setpgrp().
    my ($username, $fullname, $mailname) = getuserdata;

    my ($config, $module, $files, $oldrev, $newrev) = process_argv;

    $module =~ m#^([^/]*)#;
    my $toplevel = $1;

    if ($debug)
    {
	print STDERR "module -", $toplevel, "\n";
	print STDERR "dir -", $module, "\n";
	print STDERR "files -", join (":", @$files), "\n";
	print STDERR "id -", $id, "\n";
    }


    ##########################
    #
    # Check for a new directory first.  This will always appear as a
    # single item in the argument list, and an empty log message.
    #
    if (($UseNewInfoFmtStrings ? $files->[0] : join " ", @$files)
	eq "- New directory")
    {
	my @header = build_header $toplevel, "",
				  $username, $fullname, $mailname;
	my $sdir = $module;
	$sdir =~ s#^\Q$toplevel\E/##;

	my @body;
	push @body, "New directory:";
	push @body, "\t$sdir";

	mail_notification $config->{'mail-to'}, $module, $username, $fullname,
			  $mailname, $module, @header, @body;

	write_file $config->{'commit-log'}, @header, @body,
	    if $config->{'commit-log'};

	while (<STDIN>)
	{
	    # Read the rest of the input to avoid sending broken pipe errors
	    # to our parent.
	}

	cleanup_tmpfiles $TMPDIR, $config->{'file-text'}, $id;
	return 0;
    }

    # The import email may need a log message, so process stdin.
    my ($branch_lines, $changed_files, $added_files,
	$removed_files, $log_lines) = process_stdin $module, @$files;

    # Exit if specific tag information was requested and this isn't it.
    return 0 if exists $config->{'tag'}
		&& grep /^\Q$branch_lines->[0]\E$/, @{$config->{'tag'}};

    # Check for imported sources.
    if (($UseNewInfoFmtStrings ? $files->[0] : join " ", @$files)
	eq "- Imported sources")
    {
	my @header = build_header $toplevel, "",
				  $username, $fullname, $mailname;
	my @body;
	push @body, $module;
	push @body, "";
	push @body, "Log message:";
	push @body, @$log_lines;

	mail_notification $config->{'mail-tp'}, $module, $username, $fullname,
			  $mailname, "Import $module", @header, @body;

	write_file $config->{'commit-log'}, @header, @body
	    if $config->{'commit-log'};

	cleanup_tmpfiles $TMPDIR, $config->{'file-text'}, $id;
	return 0;
    }

    #
    # Find the log file that matches this log message
    #
    my ($LAST_FILE, $LOG_BASE, $BRANCH_BASE, $ADDED_BASE, $CHANGED_BASE,
	$REMOVED_BASE, $URL_BASE) = get_temp_files $TMPDIR,
						   $config->{'file-text'},
						   $id;

    my @text;
    my $i;
    for ($i = 0; ; $i++)
    {
	last if !-e "$LOG_BASE.$i";
	@text = read_logfile "$LOG_BASE.$i";
	last if !@text;
	print STDERR "comparing: {", join (" ", @$log_lines), "} and {",
		     join (" ", @text), "}\n"
	    if $debug;
	last if join (" ", @$log_lines) eq join (" ", @text);
    }

    #
    # Spit out the information gathered in this pass.
    #
    write_file "$LOG_BASE.$i", @$log_lines if !-e "$LOG_BASE.$i" or !@text;
    append_to_file "$BRANCH_BASE.$i",  $module, @$branch_lines;
    append_to_file "$ADDED_BASE.$i",   $module, @$added_files;
    append_to_file "$CHANGED_BASE.$i", $module, @$changed_files;
    append_to_file "$REMOVED_BASE.$i", $module, @$removed_files;

    #
    # Check whether this is the last directory.  If not, quit.
    #
    if (-e $LAST_FILE)
    {
	my $dir = read_line $LAST_FILE;
	print STDERR "checking last dir: $dir\n" if $debug;

	if ($module ne $dir)
	{
	    print STDERR "More commits to come...\n" if $debug;
	    return 0;
	}
    }

    ###
    ### End of Commits!
    ###

    #
    # This is it.  The commits are all finished.  Lump everything together
    # into a single message, fire a copy off to the mailing list, and drop
    # it on the end of the Changes file.
    #

    #
    # Produce the final compilation of the log messages
    #
    my @header = build_header $toplevel, $branch_lines->[0],
			      $username, $fullname, $mailname;

    for ($i = 0; ; $i++)
    {
	last if !-e "$LOG_BASE.$i";

	my ($subject, $body, $log_text) =
	    build_message_body $toplevel, $branch_lines->[0],
			       "$CHANGED_BASE.$i", "$ADDED_BASE.$i",
			       "$REMOVED_BASE.$i", "$LOG_BASE.$i";

	#
	# Mail out the notification.
	#
	mail_notification $config->{'mail-to'}, $module, $username, $fullname,
			  $mailname, $subject, @header, @$body;

	write_file $config->{'commit-log'}, @header, @$body
	    if $config->{'commit-log'};
    }

    cleanup_tmpfiles $TMPDIR, $config->{'file-text'}, $id;
    return 0;
}

exit main;
