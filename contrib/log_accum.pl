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
# See option -T / --file-prefix below. 
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
# You usually call log_accum from CVSROOT/loginfo, for example:
# ALL /usr/local/bin/log_accum -T ccvs_1 --config /etc/log_accum.config --mail-to cvs-cvs@nongnu.org --send-diff %p %{sVv}
# ^prog1\(/\|$\) /usr/local/bin/log_accum -T ccvs_2 --config /etc/log_accum.config -m experimental@me.net %p %{sVv}
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
    my ($config, $configs) = @_;

    # Condense the configs.
    while (@$configs)
    {
	my $c = pop @$configs;
	foreach (keys %$c)
	{
	    $config->{$_} = $c->{$_} unless exists $config->{$_};
	}
    }

    # Anything not set will default to false in Perl.

    # Sanity checks.
    die "No email destination specified." unless exists $config->{'mail-to'};
    die "cvsweb CVSROOT specified without --url."
	if exists $config->{'cvsroot'} && !exists $config->{'url'};
    die "--send-diff must be set for --diff-arg, -E, or -S to be meaningful."
	if exists $config->{'send-diff'} && !$config->{'send-diff'}
	   && (exists $config->{'diff-arg'}
	       || exists $config->{'empty-diffs'}
	       || exists $config->{'separate-diffs'});

    # Doc says that --send-diff is implied by -D, -E, -e, & -S.
    $config->{'send-diff'} = 1
	if !exists $config->{'send-diff'}
           && (exists $config->{'diff-arg'}
	       || exists $config->{'empty-diffs'}
               || exists $config->{'separate-diffs'});

    # Set defaults.
    if (!exists $config->{'cvsroot'})
    {
	$config->{'cvsroot'} = $ENV{'CVSROOT'};
	$config->{'cvsroot'} =~ s#^.*/([^/]*)$#$1#;
    }
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



sub new_config
{
    my %config;

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

    return \%config;
}



# This is global for convenience.  It is used in parse_config & process_argv.
my @option_spec = ("config|c=s@",
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

# Parse a config file.  Any long command line option is valid in the config
# file, one option/argument pair per line.  Lines /^\s*#/, empty lines,
# and lines containing only white space are ignored.  For example:
#
#     # This is a sample log_accum config file.
#     config /etc/log_accum_defaults.conf
#     mail-to cvs-cvs@nongnu.org
#     send-diff
#
# Nested configs are priortized in the order you'd expect, with parent options
# overriding any options from included files.
sub parse_config
{
    my ($parsed_configs, $files) = @_;
    my ($config, @configs);

    foreach my $file (@$files)
    {
	local @ARGV = ();

	warn "config loop detected" && next if $parsed_configs->{$file};
	$parsed_configs->{$file} = 1;

	print STDERR "parse_config: parsing $file\n" if $debug;
	open CONFIG, "<$file" or die "can't open $file: $!";

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
	close CONFIG;

	# Get the options from the config file.
	$config = new_config;
	die "argument parsing failed"
	    unless GetOptions $config, @option_spec;

	push @configs, parse_config ($parsed_configs, $config->{'config'})
	    if exists $config->{'config'};

	push @configs, $config;
    }

    return @configs;
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
# * -G DB
#   --gnats-email DB
#		- Interface to Gnats.
#
# cvsweb URL support:
#   -U URL
#   --cvsweb URL
#   --url URL	- Send URLs to diffs in email, using base URL for cvsweb.
#   -C CVSROOT
#   --cvsroot CVSROOT
#		- Use CVSROOT in cvsweb URLs instead of $CVSROOT.
#
# Diff support:
#   -d
#   --diff
#   --send-diff	- (default) Send diffs in emails.
#   -D DIFF_ARG
#   --diff-arg DIFF_ARG
#		- Pass DIFF_ARG to `cvs diff' when generating diffs.  Defaults
#		  to `-ub'.  Multiple invocations will pass all DIFF_ARGS
#		  (though first invocation always removes the default `-ub').
#		  Implies `-d'.
#   -E
#   --suppress-diffs-against-empties
#		- Suppress diffs from added files and to removed files.
#		  Implies `-d'.
#   -e
#   --empty-diffs
#		- (default) Negates `-E'.  Implies `-d'.
#   -S		- Separate diff emails.  Implies `-d'.
#
sub process_argv
{
    my ($arg, $donefiles);
    my ($config, $module, @files, %oldrev, %newrev);
    my @configs;

    # Get the options.
    $config = new_config;
    die "argument parsing failed"
	unless GetOptions $config, @option_spec;

    my %parsed_files;
    push @configs, parse_config \%parsed_files, $config->{'config'}
	if exists $config->{'config'};

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
	# Old style info strings prefaced the module path with $CVSROOT.
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

    # Condense the configs.
    set_defaults $config, \@configs;

    return $config, $module, \@files, \%oldrev, \%newrev;
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
    if (!eof STDIN)
    {
	while (<STDIN>)
	{
	    next unless $state == $STATE_LOG; # eat all STDIN

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
    while ($#log_lines > -1)
    {
	last unless $log_lines[0] =~ /^\s*$/;
	shift @log_lines;
    }
    while ($#log_lines > -1)
    {
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



sub mail_separate_diffs
{
    my ($mail_to, $module, $branch, $username, $fullname, $mailname,
	$header, @diffs) = @_;
    my ($subject, @onediff);

    foreach (@diffs)
    {
	chomp;
	if (/^Index: /)
	{
	    if (@onediff)
	    {
		mail_notification $mail_to, $module, $username, $fullname,
				  $mailname, $subject, @$header, @onediff;
	    }
	    undef @onediff;
	}
	elsif (/^RCS file: (.*)$/)
	{
	    $subject = $1;
	    $subject =~ s/^\Q$ENV{'CVSROOT'}\E//;
	    $subject = "Changes to $subject";
	    $subject .= " [$branch]" if $branch;
	}
	push @onediff, $_;
    }
}



# Return an array containing file names and file name roots:
# (LAST_FILE, LOG_BASE, BRANCH_BASE, ADDED_BASE, CHANGED_BASE, REMOVED_BASE,
#  URL_BASE, CHANGED_REV_BASE, ADDED_REV_BASE, REMOVED_REV_BASE)
sub get_temp_files
{
    my ($tmpdir, $temp_name, $id) = @_;

    print STDERR "get_temp_files: $tmpdir, $temp_name, $id\n" if $debug;

    return "$tmpdir/#$temp_name.$id.lastdir", # Created by commit_prep!
	   "$tmpdir/#$temp_name.$id.log",
	   "$tmpdir/#$temp_name.$id.branch",
	   "$tmpdir/#$temp_name.$id.added",
	   "$tmpdir/#$temp_name.$id.changed",
	   "$tmpdir/#$temp_name.$id.removed",
	   "$tmpdir/#$temp_name.$id.urls",
	   "$tmpdir/#$temp_name.$id.crevs",
	   "$tmpdir/#$temp_name.$id.arevs",
	   "$tmpdir/#$temp_name.$id.rrevs";
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
	s/^.*\s.*$/`$&'/; #` (help Emacs syntax highlighting)
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



# Get the common directory prefix from a list of files.
sub get_topdir
{
    my @list = @_;

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

    print STDERR "get_topdir: Returning ", join ("/", @topsplit), "\n"
	if $debug;

    return join "/", @topsplit;
    # $topdir may be empty.
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

    my $topdir = get_topdir @list;
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

    open FILE, "<$filename" or return;
    while (<FILE>)
    {
	chomp;
	print STDERR "read_logfile: read $_\n" if $debug;
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



sub urlencode
{
    my ($out) = @_;
    $out =~ s#[^\w:/.-]#"%" . ord $&#ge;
    return $out;
}



sub build_cvsweb_urls
{
    my ($url, $cvsroot, $branch, $oldrev, $newrev, $module, @list) = @_;
    my @urls;

    my $baseurl = urlencode "$url/$module";
    my $baseargs = "?cvsroot=" . urlencode $cvsroot;
       $baseargs .= "&only_with_tag=$branch" if $branch;

    # Import and new directories only send a single dir.  Special case it.
    return "$baseurl/$baseargs" unless @list;

    foreach (@list)
    {
	my $out = "$baseurl/" . urlencode ($_);
	my $args = $baseargs;

	# FIXME: if file is -kb, consider binary
        if ($_ =~ /\.(?:pdf|gif|jpg|mpg)$/i or -B $_ || !$oldrev->{$_})
	{
	    # if binary or new, link directly
	    $args .= "&rev=" . $newrev->{$_};
	}
	else
	{
	    # otherwise link to the diff
	    $args .= "&r1=" . $oldrev->{$_};
	    $args .= "&r2=" . $newrev->{$_};
	}

	$out .= $args;
	push @urls, $out;
    }

    return @urls;
}



sub build_diffs
{
    my ($config, $changed_rev_file, $added_rev_file, $removed_rev_file,
        $module, @list) = @_;
    my @diff;
    my @revs;

    push @revs, read_logfile $changed_rev_file;
    push @revs, read_logfile $added_rev_file;
    push @revs, read_logfile $removed_rev_file;
    print STDERR "build_diffs: files = ", join (":", @list), "\n" if $debug;
    print STDERR "build_diffs: revs = ", join (":", @revs), "\n" if $debug;

    # Assertion.
    die "not enough revs for files" unless grep (m#[^/]$#, @list) == (@revs/2);

    # Find the "top" level of the server workspace and CD there.
    my $topdir = get_topdir @list;
    my $offset = length $topdir;
    $offset++ if $offset;
    my $sdir = substr $module, $offset;
    my @dirs = split m#/#, $sdir;
    foreach (@dirs)
    {
	chdir "..";
    }

    my $dir = shift @list;
    die "Darn, $dir doesn't look like a directory!" unless $dir =~ m#/$#;
    $dir = substr $dir, $offset;
    # untaint without security checks, since we know we wrote this.
    $dir =~ /^(.*)$/;
    $dir = $1;

    foreach my $file (@list)
    {
	if ($file =~ m#/$#)
	{
	    $dir = substr $file, $offset;
	    # untaint without security checks, since we know we wrote this.
	    $dir =~ /^(.*)$/;
	    $dir = $1;
	    next;
	}

	# untaint
	die "`$file' contains dir" unless $file =~ m#^([^/]*)$#;
	$file = $1;

	my $oldrev = shift @revs;
	my $newrev = shift @revs;

	# untaint
	die "old rev doesn't look like a revision"
	    unless $oldrev =~ /^([0-9.]*)$/;
	$oldrev = $1;
	die "new rev doesn't look like a revision"
	    unless $newrev =~ /^([0-9.]*)$/;
	$newrev = $1;

	next unless $oldrev && $newrev || $config->{'empty-diffs'};

	open DIFF, "-|"
	    or exec "$CVSBIN/cvs", '-Qn', 'diff', '-N',
		    @{$config->{'diff-arg'}},
		    "-r$oldrev", "-r$newrev", '--', "$dir$file";

	while (<DIFF>)
	{
	    chomp;
	    push @diff, $_;
	}
	close DIFF;
	push @diff, "";
    }

    return @diff;
}



sub write_file
{
    my ($filename, @lines) = @_;

    return unless @lines;

    open FILE, ">$filename" or die "Cannot open file $filename: $!";
    print FILE join ("\n", @lines), "\n";
    close FILE;
}



sub append_file
{
    my ($filename, @lines) = @_;

    return unless @lines;

    open FILE, ">>$filename" or die "Cannot open file $filename: $!";
    print FILE join ("\n", @lines), "\n";
    close FILE;
}



sub build_message_body
{
    my ($config, $toplevel, $module, $branch, $changed_file, $added_file,
	$removed_file, $log_file, $url_file, $changed_rev_file,
	$added_rev_file, $removed_rev_file, $diff_file) = @_;
    my ($subject, @body, @log_text, @diff);
    my (@modified_files, @added_files, @removed_files);

    print STDERR "build_message_body\n" if $debug;

    push_formatted_lists \@body, \@modified_files, $toplevel,
			 "Modified files:", $changed_file;
    push_formatted_lists \@body, \@added_files, $toplevel,
			 "Added files:", $added_file;
    push_formatted_lists \@body, \@removed_files, $toplevel,
			 "Removed files:", $removed_file;
    push @body, "";

    @log_text = read_logfile $log_file;
    push @body, "Log message:";
    push @body, map { "\t$_" } @log_text;

    $subject = compile_subject $branch, @modified_files, @added_files,
			       @removed_files;

    my @urls = read_logfile $url_file;
    if (@urls)
    {
	push @body, "";
	push @body, "CVSWeb URLs:";
	push @body, @urls;
    }

    if ($config->{'send-diff'})
    {
	push @diff, build_diffs $config, $changed_rev_file,
				$added_rev_file, $removed_rev_file,
				$module, @modified_files, @added_files,
				@removed_files;
    }


    return $subject, \@body, \@log_text, \@diff;
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

	if ($config->{'url'})
	{
	    push @body, "";
	    push @body, "CVSWeb URLs:";
	    push @body, build_cvsweb_urls $config->{'url'},
					  $config->{'cvsroot'}, "",
					  undef, undef, $module;
	}

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

	if ($config->{'url'})
	{
	    push @body, "";
	    push @body, build_cvsweb_urls $config->{'url'},
					  $config->{'cvsroot'},
					  $branch_lines->[0], undef, undef,
					  $module;
	}

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
	$REMOVED_BASE, $URL_BASE, $CHANGED_REV_BASE, $ADDED_REV_BASE,
	$REMOVED_REV_BASE) = get_temp_files $TMPDIR, $config->{'file-text'},
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
    append_to_file "$CHANGED_BASE.$i", $module, @$changed_files;
    append_to_file "$ADDED_BASE.$i",   $module, @$added_files;
    append_to_file "$REMOVED_BASE.$i", $module, @$removed_files;

    if ($config->{'url'} || $config->{'send-diff'})
    {
	# Old revisions aren't needed for added files and they
	# confuse the cvsweb and diff algorithms.
	foreach (@$added_files)
	{
	    $oldrev->{$_} = 0;
	}
    }

    if ($config->{'url'})
    {
	append_file "$URL_BASE.$i",
		    build_cvsweb_urls ($config->{'url'}, $config->{'cvsroot'},
				       $branch_lines->[0], $oldrev, $newrev,
				       $module, @$changed_files, @$added_files,
				       @$removed_files);
    }

    if ($config->{'send-diff'})
    {
	my @revs;

	# Diffs need to be delayed until all the directories are known in order
	# to make something that can be piped to patch, so just save the
	# revisions for later.
	foreach (@$changed_files)
	{
	    push @revs, $oldrev->{$_};
	    push @revs, $newrev->{$_};
	}
	append_file "$CHANGED_REV_BASE.$i", @revs;

	undef @revs;
	foreach (@$added_files)
	{
	    push @revs, $oldrev->{$_};
	    push @revs, $newrev->{$_};
	}
	append_file "$ADDED_REV_BASE.$i", @revs;

	undef @revs;
	foreach (@$removed_files)
	{
	    # New revisions for removed files confuse the diff algorithm.
	    push @revs, $oldrev->{$_};
	    push @revs, 0;
	}
	append_file "$REMOVED_REV_BASE.$i", @revs;
    }


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

    for (my $i = 0; ; $i++)
    {
	last if !-e "$LOG_BASE.$i";

	my ($subject, $body, $log_text, $diff) =
	    build_message_body $config, $toplevel, $module, $branch_lines->[0],
			       "$CHANGED_BASE.$i", "$ADDED_BASE.$i",
			       "$REMOVED_BASE.$i", "$LOG_BASE.$i",
			       "$URL_BASE.$i", "$CHANGED_REV_BASE.$i",
			       "$ADDED_REV_BASE.$i", "$REMOVED_REV_BASE.$i";

	my @body_diff;
	if (!$config->{'separate-diffs'} && @$diff)
	{
	    push @body_diff, "";
	    push @body_diff, "Patches:";
	    push @body_diff, @$diff;
	}

	#
	# Mail out the main notification.
	#
	mail_notification $config->{'mail-to'}, $module, $username, $fullname,
			  $mailname, $subject, @header, @$body, @body_diff;

	# Mail out the separate diffs when requested.
	mail_separate_diffs $config->{'mail-to'}, $module, $branch_lines->[0],
			    $username, $fullname, $mailname, \@header, @$diff
	    if $config->{'separate-diffs'};

	#if ($config->{'gnats-email'}
	#    && grep /^\s*\[(bug|pr|sr|task) #(\d+)\]/, @log_text)
	#{
	#    my $pr = $1;
	#    mail_notification $config->{'gnats-email'}, $module, $username,
	#		      $fullname, $mailname, $subject, @header, @$body;
	#}

	write_file $config->{'commit-log'}, @header, @$body, @body_diff
	    if $config->{'commit-log'};
    }

    cleanup_tmpfiles $TMPDIR, $config->{'file-text'}, $id;
    return 0;
}

exit main;
