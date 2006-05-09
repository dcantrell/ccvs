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

#
# <s>Where do you want the RCS ID and delta info?</s> What additional info do you want in your mail?
# 0 = none,
# 1 = <s>in mail only,</s> summaries
# 2 = <s>in both mail and logs.</s> summaries twice??
#
my $rcsidinfo = 2;

#if you are using CVS web then set this to some value... if not set it to ""
#
# When set properly, this will cause links to aspects of the project to
# print in the commit emails.
my $CVSWEB_SCHEME = "http";
my $CVSWEB_DOMAIN = "cvs.sv.gnu.org";
my $CVSWEB_PORT = "80";
my $CVSWEB_URI = "viewcvs";
my $SEND_URL = "true";

my $SEND_DIFF = "false";
my $SUPPRESS_DIFFS_AGAINST_EMPTIES = "false";


# Set this to a domain to have CVS pretend that all users who make
# commits have mail accounts within that domain.
# my $EMULATE_LOCAL_MAIL_USER="nongnu.org"; 
my $EMULATE_LOCAL_MAIL_USER=''; 


############################################################
#
# Constants
#
############################################################
my $STATE_NONE    = 0;
my $STATE_CHANGED = 1;
my $STATE_ADDED   = 2;
my $STATE_REMOVED = 3;
my $STATE_LOG     = 4;

my $TMPDIR        = '/tmp';
my $FILE_PREFIX   = '#cvs.';

my $CVSBIN = "/usr/bin";
my $MAIL_CMD      = "| /usr/lib/sendmail -i -t";
#$MAIL_CMD      = "| /var/qmail/bin/qmail-inject";

my $SUBJECT_PRE   = '';
#my $SUBJECT_PRE   = 'CVS update:';


############################################################
#
# Global variables
#
############################################################

my $update_dir = "";		# The relative directory in the repo the
				# sandbox is rooted in.
my @diffargs = ();		# Diff options.
my $branch = "";		# The branch being processed.
my $have_r_opt = 0;		# Whether -r was seen on the command line.
my $onlytag = "";		# With $have_r_opt, only send mail for changes
				# on this branch.
my @mailto = ();		# Email addresses to send mail to.
my $new_directory = 0;          # Is this a 'cvs add directory' command?
my $imported_sources = 0;       # Is this a 'cvs import' command?
my $hook_identifier = '';	# Unique identifier to support multiple hooks

my $id = getpgrp();
my $cvs_user = $ENV{'USER'} || getlogin || (getpwuid($<))[0] || sprintf("uid#%d",$<);
my %oldrev;
my %newrev;

my @files;

# Temporary filenames
my $ADDED_FILE;
my $CHANGED_FILE;
my $REMOVED_FILE;
my $BRANCH_FILE;


############################################################
#
# Subroutines
#
############################################################

sub format_names {
    my ($dir, @files) = @_;
    my (@lines);

    $lines[0] = sprintf(" %-08s", $dir);
    foreach my $file (@files) {
        if (length($lines[$#lines]) + length($file) > 60) {
            $lines[++$#lines] = sprintf(" %8s", " ");
        }
        $lines[$#lines] .= " ".$file;
    }
    @lines;
}

sub cleanup_tmpfiles {
    my (@files);

    opendir(DIR, $TMPDIR);
    push(@files, grep(/^${FILE_PREFIX}${hook_identifier}.${id}.*\.$/, readdir(DIR)));
    closedir(DIR);
    foreach (@files) {
        unlink "$TMPDIR/$_";
    }
}

sub write_logfile {
    my ($filename, @lines) = @_;

    open(FILE, ">$filename") || die ("Cannot open log file $filename: $!\n");
    print(FILE join("\n", @lines), "\n");
    close(FILE);
}

sub append_to_file {
    my ($filename, $dir, @files) = @_;

    if (@files) {
        my (@lines) = &format_names($dir, @files);
        open(FILE, ">>$filename") || die ("Cannot open file $filename: $!\n");
        print(FILE join("\n", @lines), "\n");
        close(FILE);
    }
}

sub write_line {
    my ($filename, $line) = @_;

    open(FILE, ">$filename") || die("Cannot open file $filename: $!\n");
    print(FILE $line, "\n");
    close(FILE);
}

sub append_line {
    my ($filename, $line) = @_;

    open(FILE, ">>$filename") || die("Cannot open file $filename: $!\n");
    print(FILE $line, "\n");
    close(FILE);
}

sub read_line {
    my ($filename) = @_;
    my ($line);

    open(FILE, "<$filename") || die("Cannot open file $filename: $!\n");
    $line = <FILE>;
    close(FILE);
    chomp($line);
    $line;
}

sub read_line_nodie {
    my ($filename) = @_;
    my ($line);
    open(FILE, "<$filename") || return ("");

    $line = <FILE>;
    close(FILE);
    chomp($line);
    $line;
}

sub read_file_lines {
    my ($filename) = @_;
    my (@text) = ();

    open(FILE, "<$filename") || return ();
    while (<FILE>) {
        chomp;
        push(@text, $_);
    }
    close(FILE);
    @text;
}

sub read_file {
    my ($filename, $leader) = @_;
    my (@text) = ();

    open(FILE, "<$filename") || return ();
    while (<FILE>) {
        chomp;
        push(@text, sprintf("  %-10s  %s", $leader, $_));
        $leader = "";
    }
    close(FILE);
    @text;
}

sub read_logfile {
    my ($filename, $leader) = @_;
    my (@text) = ();

    open(FILE, "<$filename") || die ("Cannot open log file $filename: $!\n");
    while (<FILE>) {
        chomp;
        push(@text, $leader.$_);
    }
    close(FILE);
    @text;
}

#
# do an 'cvs -Qn status' on each file in the arguments, and extract info.
#
sub change_summary {
    my ($out, $module, @filenames) = @_;
    my ($file, $rcsfile, $line, $vhost);

    while (@filenames) {
        $file = shift @filenames;

        if ("$file" eq "") {
            next;
        }

        my $delta = "";
        $rcsfile = "$update_dir/$file";

        if ($oldrev{$file}) {
            open(RCS, "-|") || exec "$CVSBIN/cvs", '-Qn', 'log',
				    "-r$newrev{$file}",
				    "--", $file;
            while (<RCS>) {
                if (/^date:.*lines:([^;]+);.*/) {
                    $delta = $1;
                    last;
                }
            }
            close(RCS);
        }

        my $diff = "\n\n";

	if ($SEND_URL eq "true")
        {
	    # FIXME: Store this in a separate list.

	    die "internal error - module empty" unless $module =~ m#^([^/]+)#;
	    my $project = $1;

	    $diff = "$CVSWEB_SCHEME://$CVSWEB_DOMAIN";
	    $diff .= ":$CVSWEB_PORT" unless $CVSWEB_PORT eq "80";
	    $diff .= "/$CVSWEB_URI/$project/$module/$file";
        }

        #
        # If this is a binary file, don't try to report a diff; not only is
        # it meaningless, but it also screws up some mailers.  We rely on
        # Perl's 'is this binary' algorithm; it's pretty good.  But not
        # perfect.
        #
        if ($file =~ /\.(?:pdf|gif|jpg|mpg)$/i or -B $file) {
          if ($SEND_URL eq "true")
	  {
            $diff .= "&pathrev=" . $newrev{$file};
	    $diff .= "&content-type=application/octet-stream\n\n";
          }
	  $diff .= "\t[Binary file]\n\n" if $SEND_DIFF eq "true";
        }
        else {
            #
            # Get the differences between this and the previous revision,
            # being aware that new files always have revision '1.1' and
            # new branches always end in '.n.1'.
            #
            if ($SEND_URL eq "true") {
              if (!$oldrev{$file} || !$newrev{$file}) {
                $diff .= "&rev=" . $oldrev{$file};
		$diff .= "&content-type=text/x-cvsweb-markup\n\n";
              } else {
                $diff .= "&r1=$oldrev{$file}&r2=$newrev{$file}\n\n";
              }
	    }

            if ($SEND_DIFF eq "true"
		and ($SUPPRESS_DIFFS_AGAINST_EMPTIES eq "false"
		     or ($oldrev{$file} and $newrev{$file}))) {
	      # Depends on user options, so let's remove that:
              #$diff .= "(In the diff below, changes in quantity "
              #      . "of whitespace are not shown.)\n\n";
              open(DIFF, "-|")
                || exec "$CVSBIN/cvs", '-Qn', 'diff', '-N', @diffargs,
                "-r$oldrev{$file}", "-r$newrev{$file}", '--', $file;

              while (<DIFF>) {
                $diff .= $_;
              }
              close(DIFF);

              $diff .= "\n\n";
           }
        }

        &append_line($out, sprintf("%-9s%-12s%s%s",
				   $newrev{$file} ? $newrev{$file} : "dead",
				   $delta, $rcsfile, $diff));
    }
}


sub build_header {
    my ($header);
    delete $ENV{'TZ'};
    my ($sec,$min,$hour,$mday,$mon,$year) = localtime(time);

    $header = sprintf("  User: %-8s\n  Date: %02d/%02d/%02d %02d:%02d:%02d",
                       $cvs_user, $year%100, $mon+1, $mday,
                       $hour, $min, $sec);
#    $header = sprintf("%-8s    %02d/%02d/%02d %02d:%02d:%02d",
#                       $login, $year%100, $mon+1, $mday,
#                       $hour, $min, $sec);
}


sub derive_subject_from_changes_file ()
{
  my ($module) = @_;
  my $subj = "";

  my $i;
  for ($i = 0; ; $i++)
  {
    open (CH, "<$CHANGED_FILE.$i") or last;

    while (my $change = <CH>)
    {
      # A changes file looks like this:
      #
      #  src      foo.c newfile.html
      #  www      index.html project_nav.html
      #
      # Each line is " Dir File1 File2 ..."
      # We only care about Dir, since the subject line should
      # summarize. 
      
      $change =~ s/^[ \t]*//;
      $change =~ /^([^ \t]+)[ \t]*/;
      my $dir = $1;
      # Fold to rightmost directory component
      $dir =~ /([^\/]+)$/;
      $dir = $1;
      if ($subj eq "") {
        $subj = $dir;
      } else {
        $subj .= ", $dir"; 
      }
    }
    close (CH);
  }

  if ($subj ne "") {
      $subj = "MODIFIED: $subj ..."; 
  }
  else {
      # NPM: See if there's any file-addition notifications.
      my $added = &read_line_nodie("$ADDED_FILE.$i");
      if ($added ne "") {
          $subj .= "ADDED: $added "; 
      }
    
#    print "derive_subject_from_changes_file().. added== $added \n";
    
       ## NPM: See if there's any file-removal notications.
      my $removed = &read_line_nodie("$REMOVED_FILE.$i");
      if ($removed ne "") {
          $subj .= "REMOVED: $removed "; 
      }
    
#    print "derive_subject_from_changes_file().. removed== $removed \n";
    
      ## NPM: See if there's any branch notifications.
      my $branched = &read_line_nodie("$BRANCH_FILE.$i");
      if ($branched ne "") {
          $subj .= "BRANCHED: $branched"; 
      }
    
#    print "derive_subject_from_changes_file().. branched== $branched \n";
    
      ## NPM: DEFAULT: DIRECTORY CREATION (c.f. "Check for a new directory first" in main mody)
      if ($subj eq "") {
          $subj = "NEW: $module"; 
      }    
  }

  if ($branch)
  {
    $subj = "[$branch] $subj"
  }


  return $subj;
}

sub mail_notification
{
    my ($addr_list, $module, @text) = @_;
    my ($mail_to, $mail_from);

    my $subj = &derive_subject_from_changes_file ($module);

    if ($EMULATE_LOCAL_MAIL_USER) {
	$mail_from = "$cvs_user\@$EMULATE_LOCAL_MAIL_USER";
    }

    $mail_to = join(", ", @{$addr_list});

    print "Mailing the commit message to $mail_to (from "
	. ($mail_from ? $mail_from : $cvs_user) . ")\n";

    $ENV{'MAILUSER'} = $mail_from;
    # Commented out on hocus, so comment it out here.  -kff
    # $ENV{'QMAILINJECT'} = 'f';

    if ($mail_from) {
	open(MAIL, "$MAIL_CMD -f$mail_from");
	print MAIL "From: $mail_from\n";
    } else {
	# Let the system determine (correctly) how to send mail
	open(MAIL, "$MAIL_CMD");
    }

    print MAIL "To: $mail_to\n";
    print MAIL "Subject: $SUBJECT_PRE $subj\n\n";
    print(MAIL join("\n", @text));
    close(MAIL);

#    print "Mailing the commit message to $MAIL_TO...\n";
#
#    #added by jrobbins@collab.net 1999/12/15
#    # attempt to get rid of anonymous
#    $ENV{'MAILUSER'} = 'commitlogger';
#    $ENV{'QMAILINJECT'} = 'f';
#
#    open(MAIL, "| /var/qmail/bin/qmail-inject");
#    print(MAIL "To: $MAIL_TO\n"); 
#    print(MAIL "Subject: cvs commit: $ARGV[0]\n"); 
#    print(MAIL join("\n", @text));
#    close(MAIL);
}

## process the command line arguments sent to this script
## it returns an array of files, %s, sent from the loginfo
## command
#
#   -d		- Send diffs in emails.
#   -D DIFF_ARG - Pass DIFF_ARG to `cvs diff' when generating diffs.  Defaults
#		  to `-ub'.  Multiple invocations will pass all DIFF_ARGS
#		  (though first invocation always removes the default `-ub').
#		  Implies `-D'.
#   -E		- Suppress diffs against added and removed (empty) files.
#		  Implies `-D'.
#   -m EMAIL	- Set mailto address.
#   -p PROJECT	- Set full repository path.
#   -r TAG	- operate only on changes with tag TAG
#   -r BRANCH	- operate only on changes in branch TAG
#		  Use -r "" or -r "HEAD " for only changes to HEAD.
#   -u USER	- Set CVS username to USER.
sub process_argv
{
    my (@argv) = @_;
    my ($arg, $donefiles);
    my $module;

    while (@argv) {
	$arg = shift @argv;
	if ($arg eq '-d') {
	    $SEND_DIFF = "true";
	} elsif ($arg eq '-D') {
	    push @diffargs, shift @argv;
	    $SEND_DIFF = "true";
	} elsif ($arg eq '-E') {
	    $SUPPRESS_DIFFS_AGAINST_EMPTIES = "true";
	    $SEND_DIFF = "true";
	} elsif ($arg eq '-m') {
	    push @mailto, split (/[ ,]+/, shift @argv);
	} elsif ($arg eq '-p') {
	    $update_dir = shift @argv;
	} elsif ($arg eq '-r') {
	    $have_r_opt = 1;
	    $onlytag = shift @argv;
	    # Empty branch means HEAD
	    if ($onlytag eq 'HEAD') {
		$onlytag = '';
	    }
	} elsif ($arg eq '-u') {
	    my $param = shift @argv;
	    if (!defined($cvs_user)) {
		$cvs_user = $param;
	    }
	} elsif ($arg eq '-T') {
	    my $param = shift @argv;
	    if ($param =~ /^([a-zA-Z0-9_.-]+)$/) {
		$hook_identifier = $1;
	    } else {
		die "Invalid identifier passed to option -T: $param";
	    }
	} else {
	    ($donefiles) && die "Too many arguments!\n";
	    $donefiles = !$UseNewInfoFmtStrings;

	    if ($arg eq '- New directory') {
		$new_directory = 1;
	    } elsif ($arg eq '- Imported sources') {
		$imported_sources = 1;
	    } elsif ($UseNewInfoFmtStrings) {
		$module = $arg; # current directory
		while (@argv) {
		    my $filename = shift @argv;
		    if ($filename =~ m#^([^/]+)$#)
		    {
			$filename = $1;
		    }
		    else
		    {
			die "path in file name `$filename'";
		    }
			
		    push @files, $filename;
		    $oldrev{$filename} = shift @argv
			or die "No previous revision given for $filename";
		    $newrev{$filename} = shift @argv
			or die "No new revision given for $filename";

		    # Simplify diffs.
		    $oldrev{$filename} = 0 if $oldrev{$filename} eq "NONE";
		    $newrev{$filename} = 0 if $newrev{$filename} eq "NONE";

		    # Untaint.
		    if ($oldrev{$filename} =~ /^([0-9.]+)$/)
		    {
			$oldrev{$filename} = $1;
		    }
		    else
		    {
			die "invalid old revision $oldrev{$filename}";
		    }
		    if ($newrev{$filename} =~ /^([0-9.]+)$/)
		    {
			$newrev{$filename} = $1;
		    }
		    else
		    {
			die "invalid new revision $newrev{$filename}";
		    }
		}
	    } else {
		my @files;
		push @files, split (' ', $arg);
		for (@files)
		{
		    s/,([^,]+),([^,]+)$//
			or die "Not enough modifiers for $_";
		    $oldrev{$_} = $1;
		    $newrev{$_} = $2;
		    $oldrev{$_} = 0 if $oldrev{$_} eq "NONE";
		    $newrev{$_} = 0 if $newrev{$_} eq "NONE";
		}
	    }
	}
    }

    # Sanity checks.
    die "No email destination specified.\n" unless @mailto;

    return $module;
}



#############################################################
#
# Main Body
#
############################################################
#
# Setup and clean up environment
#
umask (002);
$ENV{"PATH"} = "/bin";
delete @ENV{qw(IFS CDPATH ENV BASH_ENV)};
 

#
# Initialize basic variables
#
print join(' ', @ARGV); print "\n"; #debug
my $module = process_argv @ARGV;

my $state = $STATE_NONE;
my @branch_lines;
my @changed_files;
my @added_files;
my @removed_files;
my @log_lines;
my $header;

my $LAST_FILE     = "$TMPDIR/${FILE_PREFIX}${hook_identifier}.$id.lastdir";  # Created by commit_prep!
my $LOG_FILE      = "$TMPDIR/${FILE_PREFIX}${hook_identifier}.$id.log";
my $SUMMARY_FILE  = "$TMPDIR/${FILE_PREFIX}${hook_identifier}.$id.summary";
$ADDED_FILE    = "$TMPDIR/${FILE_PREFIX}${hook_identifier}.$id.added";
$CHANGED_FILE  = "$TMPDIR/${FILE_PREFIX}${hook_identifier}.$id.changed";
$REMOVED_FILE  = "$TMPDIR/${FILE_PREFIX}${hook_identifier}.$id.removed";
$BRANCH_FILE   = "$TMPDIR/${FILE_PREFIX}${hook_identifier}.$id.branch";


# Set defaults that could have been overridden on the command line.
$update_dir = `/bin/cat CVS/Repository` unless $update_dir;
chomp $update_dir;
die "Could not determine update dir" unless $update_dir;

push @diffargs, "-ub" unless @diffargs;



#print("ARGV  - ", join(":", @ARGV), "\n");
print("files - ", join(":", @files), "\n");
#print("dir   - ", $dir, "\n");
#print("id    - ", $id, "\n");


##########################
#
# Check for a new directory first.  This will always appear as a
# single item in the argument list, and an empty log message.
#
if ($new_directory) {
    $header = &build_header;
    my @text;
    push @text, $header;
    push @text, "";
    push @text, "  $module - New directory";
    &mail_notification ([@mailto], $module, @text);
    exit 0;
}

#
# Iterate over the body of the message collecting information.
#
while (<STDIN>) {
    print $_;
    chomp;                      # Drop the newline
    if (/^\s*(Tag|Revision\/Branch):\s*(\w+)/) {
	$branch = $2;
	# Is there really a good reason to keep track of this?
        push (@branch_lines, $2);
        next;
    }
#    next if (/^[ \t]+Tag:/ && $state != $STATE_LOG);
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
		print "matched $files[$i]\n";
		$m = $i if !defined $m or length $files[$m] < length $files[$i];
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
        next unless ($state == $STATE_LOG); # eat all STDIN

        if (/^\s*\[(bug|pr|task) #(\d+)\]/)
        {
	    # FIXME: Set the bug/patch ID to "$1 #$2" so that the issue
	    # database may be updated.
	}
        push (@log_lines, $_);
    }
}

#
# Strip leading and trailing blank lines from the log message.  Also
# compress multiple blank lines in the body of the message down to a
# single blank line.
# (Note, this only does the mail and changes log, not the rcs log).
#
while ($#log_lines > -1) {
    last unless $log_lines[0] eq "";
    shift @log_lines;
}
while ($#log_lines > -1) {
    last unless $log_lines[$#log_lines] eq "";
    pop @log_lines;
}
for (my $i = $#log_lines - 1; $i > 0; $i--) {
    if (($log_lines[$i - 1] eq "") && ($log_lines[$i] eq "")) {
        splice(@log_lines, $i, 1);
    }
}

#
# Find the log file that matches this log message
#
my $i;
for ($i = 0; ; $i++) {
    last if (! -e "$LOG_FILE.$i");
    my @text = &read_logfile("$LOG_FILE.$i", "");
    last if ($#text == -1);
    last if (join(" ", @log_lines) eq join(" ", @text));
}

#
# Spit out the information gathered in this pass.
#
&write_logfile("$LOG_FILE.$i", @log_lines);
&append_to_file("$BRANCH_FILE.$i",  $module, @branch_lines);
&append_to_file("$ADDED_FILE.$i",   $module, @added_files);
&append_to_file("$CHANGED_FILE.$i", $module, @changed_files);
&append_to_file("$REMOVED_FILE.$i", $module, @removed_files);
if ($rcsidinfo) {
  &change_summary ("$SUMMARY_FILE.$i", $module,
		   (@changed_files, @added_files, @removed_files));
}

#
# Check whether this is the last directory.  If not, quit.
#
if (-e "$LAST_FILE") {
   $_ = &read_line("$LAST_FILE");
   my $tmpfiles = $module;
   # Characters escape for use in regexp:
   $tmpfiles =~ s,([^a-zA-Z0-9_/]),\\$1,g;
   if (! grep(/$tmpfiles$/, $_)) {
        # print "More commits to come...\n";
        exit 0
   }
}

#
# This is it.  The commits are all finished.  Lump everything together
# into a single message, fire a copy off to the mailing list, and drop
# it on the end of the Changes file.
#
$header = &build_header;

#
# Produce the final compilation of the log messages
#
my @text = ();
push(@text, $header);
push(@text, "");
for (my $i = 0; ; $i++) {
    last if (! -e "$LOG_FILE.$i");
    push(@text, &read_file("$BRANCH_FILE.$i", "Branch:"));
    push(@text, &read_file("$CHANGED_FILE.$i", "Modified:"));
    push(@text, &read_file("$ADDED_FILE.$i", "Added:"));
    push(@text, &read_file("$REMOVED_FILE.$i", "Removed:"));
    push(@text, "  Log:");
    push(@text, &read_logfile("$LOG_FILE.$i", "  "));
    if ($rcsidinfo == 2) {
        if (-e "$SUMMARY_FILE.$i") {
            push(@text, "  ");
            push(@text, "  Revision  Changes    Path");
            push(@text, &read_logfile("$SUMMARY_FILE.$i", "  "));
        }
    }
    push(@text, "");
}

#
# Now generate the extra info for the mail message..
#
if ($rcsidinfo == 1) {
    my $revhdr = 0;
    for (my $i = 0; ; $i++) {
        last if (! -e "$LOG_FILE.$i");
        if (-e "$SUMMARY_FILE.$i") {
            if (!$revhdr++) {
                push(@text, "Revision  Changes    Path");
            }
            push(@text, &read_logfile("$SUMMARY_FILE.$i", ""));
        }
    }
    if ($revhdr) {
        push(@text, "");        # consistancy...
    }
}



#
# Mail out the notification.
#
if (!$have_r_opt || $onlytag eq $branch) {
    &mail_notification ([@mailto], $module, @text);
}
&cleanup_tmpfiles;
exit 0;
