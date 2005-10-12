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

###############################################################################
###############################################################################
###############################################################################
#
# THIS SCRIPT IS PROBABLY BROKEN.  REMOVING THE -T SWITCH ON THE #! LINE ABOVE
# WOULD FIX IT, BUT THIS IS INSECURE.  WE RECOMMEND FIXING THE ERRORS WHICH THE
# -T SWITCH WILL CAUSE PERL TO REPORT BEFORE RUNNING THIS SCRIPT FROM A CVS
# SERVER TRIGGER.  PLEASE SEND PATCHES CONTAINING THE CHANGES YOU FIND
# NECESSARY TO RUN THIS SCRIPT WITH THE TAINT-CHECKING ENABLED BACK TO THE
# <@PACKAGE_BUGREPORT@> MAILING LIST.
#
# For more on general Perl security and taint-checking, please try running the
# `perldoc perlsec' command.
#
###############################################################################
###############################################################################
###############################################################################

# Perl filter to handle the log messages from the checkin of files in
# a directory.  This script will group the lists of files by log
# message, and mail a single consolidated log message at the end of
# the commit.
#
# This file assumes a pre-commit checking program that leaves the
# names of the first and last commit directories in a temporary file.
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
# the committer (by themselves, neither of these are unique, but
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
#

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
# Where do you want the RCS ID and delta info?
# 0 = none,
# 1 = in mail only,
# 2 = in both mail and logs.
#
$rcsidinfo = 2;

#if you are using CVS web then set this to some value... if not set it to ""
#
# When set properly, this will cause links to aspects of the project to
# print in the commit emails.
#$CVSWEB_SCHEME = "http";
#$CVSWEB_DOMAIN = "nongnu.org";
#$CVSWEB_PORT = "80";
#$CVSWEB_URI = "source/browse/";
#$SEND_URL = "true";
$SEND_DIFF = "false";


# Set this to a domain to have CVS pretend that all users who make
# commits have mail accounts within that domain.
#$EMULATE_LOCAL_MAIL_USER="nongnu.org"; 


############################################################
#
# Constants
#
############################################################
$STATE_NONE    = 0;
$STATE_CHANGED = 1;
$STATE_ADDED   = 2;
$STATE_REMOVED = 3;
$STATE_LOG     = 4;

$TMPDIR        = $ENV{'TMPDIR'} || '/tmp';
$FILE_PREFIX   = '#cvs.';

$LAST_FILE     = "$TMPDIR/${FILE_PREFIX}lastdir";  # Created by commit_prep!
$ADDED_FILE    = "$TMPDIR/${FILE_PREFIX}files.added";
$REMOVED_FILE  = "$TMPDIR/${FILE_PREFIX}files.removed";
$LOG_FILE      = "$TMPDIR/${FILE_PREFIX}files.log";
$BRANCH_FILE   = "$TMPDIR/${FILE_PREFIX}files.branch";
$SUMMARY_FILE  = "$TMPDIR/${FILE_PREFIX}files.summary";

$MAIL_CMD      = "| /usr/lib/sendmail -i -t";
#$MAIL_CMD      = "| /var/qmail/bin/qmail-inject";
$SUBJECT_PRE   = 'CVS update:';


############################################################
#
# Subroutines
#
############################################################

sub format_names {
    local($dir, @files) = @_;
    local(@lines);

    $lines[0] = sprintf(" %-08s", $dir);
    foreach $file (@files) {
        if (length($lines[$#lines]) + length($file) > 60) {
            $lines[++$#lines] = sprintf(" %8s", " ");
        }
        $lines[$#lines] .= " ".$file;
    }
    @lines;
}

sub cleanup_tmpfiles {
    local(@files);

    opendir(DIR, $TMPDIR);
    push(@files, grep(/^${FILE_PREFIX}.*\.${id}\.${cvs_user}$/, readdir(DIR)));
    closedir(DIR);
    foreach (@files) {
        unlink "$TMPDIR/$_";
    }
}

sub write_logfile {
    local($filename, @lines) = @_;

    open(FILE, ">$filename") || die ("Cannot open log file $filename: $!\n");
    print(FILE join("\n", @lines), "\n");
    close(FILE);
}

sub append_to_file {
    local($filename, $dir, @files) = @_;

    if (@files) {
        local(@lines) = &format_names($dir, @files);
        open(FILE, ">>$filename") || die ("Cannot open file $filename: $!\n");
        print(FILE join("\n", @lines), "\n");
        close(FILE);
    }
}

sub write_line {
    local($filename, $line) = @_;

    open(FILE, ">$filename") || die("Cannot open file $filename: $!\n");
    print(FILE $line, "\n");
    close(FILE);
}

sub append_line {
    local($filename, $line) = @_;

    open(FILE, ">>$filename") || die("Cannot open file $filename: $!\n");
    print(FILE $line, "\n");
    close(FILE);
}

sub read_line {
    local($filename) = @_;
    local($line);

    open(FILE, "<$filename") || die("Cannot open file $filename: $!\n");
    $line = <FILE>;
    close(FILE);
    chomp($line);
    $line;
}

sub read_line_nodie {
    local($filename) = @_;
    local($line);
    open(FILE, "<$filename") || return ("");

    $line = <FILE>;
    close(FILE);
    chomp($line);
    $line;
}

sub read_file_lines {
    local($filename) = @_;
    local(@text) = ();

    open(FILE, "<$filename") || return ();
    while (<FILE>) {
        chomp;
        push(@text, $_);
    }
    close(FILE);
    @text;
}

sub read_file {
    local($filename, $leader) = @_;
    local(@text) = ();

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
    local($filename, $leader) = @_;
    local(@text) = ();

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
    local($out, @filenames) = @_;
    local($file, $rcsfile, $line, $vhost, $cvsweb_base);

    while (@filenames) {
        $file = shift @filenames;

        if ("$file" eq "") {
            next;
        }

        $delta = "";
        $rcsfile = "$update_dir/$file";

        if ($oldrev{$file}) {
            open(RCS, "-|") || exec "$cvsbin/cvs", '-Qn', 'log',
				    "-r$newrev{$file}",
				    '--', $file;
            while (<RCS>) {
                if (/^date:.*lines:([^;]+);.*/) {
                    $delta = $1;
                    last;
                }
            }
            close(RCS);
        }

        $diff = "\n\n";
        $vhost = $path[0];
        if ($CVSWEB_PORT eq "80") {
          $cvsweb_base = "$CVSWEB_SCHEME://$vhost.$CVSWEB_DOMAIN/$CVSWEB_URI";
        }
        else {
          $cvsweb_base = "$CVSWEB_SCHEME://$vhost.$CVSWEB_DOMAIN:$CVSWEB_PORT/$CVSWEB_URI";
        }
        if ($SEND_URL eq "true") {
          $diff .= $cvsweb_base . join("/", @path) . "/$file";
        }

        #
        # If this is a binary file, don't try to report a diff; not only is
        # it meaningless, but it also screws up some mailers.  We rely on
        # Perl's 'is this binary' algorithm; it's pretty good.  But not
        # perfect.
        #
        if (($file =~ /\.(?:pdf|gif|jpg|mpg)$/i) || (-B $file)) {
          if ($SEND_URL eq "true") {
            $diff .= "?rev=" . $newrev{$file};
	    $diff .= "&content-type=text/x-cvsweb-markup\n\n";
          }
          if ($SEND_DIFF eq "true") {
            $diff .= "\t<<Binary file>>\n\n";
          }
        }
        else {
            #
            # Get the differences between this and the previous revision,
            # being aware that new files always have revision '1.1' and
            # new branches always end in '.n.1'.
            #
            if ($SEND_URL eq "true") {
              if (!$oldrev{$file} || !$newrev{$file}) {
                $diff .= "?rev=" . $oldrev{$file};
		$diff .= "&content-type=text/x-cvsweb-markup\n\n";
              } else {
                $diff .= ".diff?r1=$oldrev{$file}&r2=$newrev{$file}\n\n";
              }
	    }

            if ($SEND_DIFF eq "true") {
              $diff .= "(In the diff below, changes in quantity "
                    . "of whitespace are not shown.)\n\n";
              open(DIFF, "-|")
                || exec "$cvsbin/cvs", '-Qn', 'diff', '-N', @diffargs,
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
    local($header);
    delete $ENV{'TZ'};
    local($sec,$min,$hour,$mday,$mon,$year) = localtime(time);

    $header = sprintf("  User: %-8s\n  Date: %02d/%02d/%02d %02d:%02d:%02d",
                       $cvs_user, $year%100, $mon+1, $mday,
                       $hour, $min, $sec);
#    $header = sprintf("%-8s    %02d/%02d/%02d %02d:%02d:%02d",
#                       $login, $year%100, $mon+1, $mday,
#                       $hour, $min, $sec);
}


sub derive_subject_from_changes_file ()
{
  my $subj = "";

  for ($i = 0; ; $i++)
  {
    open (CH, "<$CHANGED_FILE.$i.$id.$cvs_user") or last;

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
      my $added = &read_line_nodie("$ADDED_FILE.$i.$id.$cvs_user");
      if ($added ne "") {
          $subj .= "ADDED: $added "; 
      }
    
#    print "derive_subject_from_changes_file().. added== $added \n";
    
       ## NPM: See if there's any file-removal notications.
      my $removed = &read_line_nodie("$REMOVED_FILE.$i.$id.$cvs_user");
      if ($removed ne "") {
          $subj .= "REMOVED: $removed "; 
      }
    
#    print "derive_subject_from_changes_file().. removed== $removed \n";
    
      ## NPM: See if there's any branch notifications.
      my $branched = &read_line_nodie("$BRANCH_FILE.$i.$id.$cvs_user");
      if ($branched ne "") {
          $subj .= "BRANCHED: $branched"; 
      }
    
#    print "derive_subject_from_changes_file().. branched== $branched \n";
    
      ## NPM: DEFAULT: DIRECTORY CREATION (c.f. "Check for a new directory first" in main mody)
      if ($subj eq "") {
          my $subject = join("/", @path);
          $subj = "NEW: $subject"; 
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
    local($addr_list, @text) = @_;
    local ($mail_to, $mail_from);

    my $subj = &derive_subject_from_changes_file ();

    if ($EMULATE_LOCAL_MAIL_USER) {
      $mail_from = "$cvs_user\@$EMULATE_LOCAL_MAIL_USER";
    } else {
      $mail_from = "$cvs_user\@" . `hostname`;
      chomp $mail_from;
    }

    $mail_to = join(", ", @{$addr_list});

    print "Mailing the commit message to $mail_to (from $mail_from)\n";

    $ENV{'MAILUSER'} = $mail_from;
    # Commented out on hocus, so comment it out here.  -kff
    # $ENV{'QMAILINJECT'} = 'f';

    open(MAIL, "$MAIL_CMD -f$mail_from");
    print MAIL "From: $mail_from\n";
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
#   -m EMAIL	- Set mailto address.
#   -p PROJECT	- Set full repository path.
#   -r TAG	- operate only on changes with tag TAG
#   -r BRANCH	- operate only on changes in branch TAG
#		  Use -r "" for only changes to HEAD.
#   -u USER	- Set CVS username to USER.
sub process_argv
{
    local(@argv) = @_;
    local(@files);
    local($arg);
    print "Processing log script arguments...\n";

    while (@argv) {
	$arg = shift @argv;
	if ($arg eq '-d') {
	    $SEND_DIFF = "true";
	} elsif ($arg eq '-D') {
	    push @diffargs, shift @argv;
	    $SEND_DIFF = "true";
	} elsif ($arg eq '-m') {
	    push @mailto, split (/[ ,]+/, shift @argv);
	} elsif ($arg eq '-p') {
	    $update_dir = shift @argv;
	} elsif ($arg eq '-r') {
	    $have_r_opt = 1;
	    $onlytag = shift @argv;
	} elsif ($arg eq '-u' && !defined($cvs_user)) {
	    $cvs_user = shift @argv;
	} else {
	    ($donefiles) && die "Too many arguments!\n";
	    $donefiles = !$UseNewInfoFmtStrings;

	    if ($arg eq '- New directory') {
		$new_directory = 1;
	    } elsif ($arg eq '- Imported sources') {
		$imported_sources = 1;
	    } elsif ($UseNewInfoFmtStrings) {
		push @file, $arg;
		$oldrev{$arg} = shift @argv
		    or die "Not enough modifiers for $arg";
		$newrev{$arg} = shift @argv
		    or die "Not enough modifiers for $arg";
		$oldrev{$arg} = 0 if $oldrev{$arg} eq "NONE";
		$newrev{$arg} = 0 if $newrev{$arg} eq "NONE";
	    } else {
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

    return @files;
}


#############################################################
#
# Main Body
#
############################################################
#
# Setup environment
#
umask (002);

# Connect to the database
$cvsbin = "/usr/bin";

#
# Initialize basic variables
#
$id = getpgrp();
$state = $STATE_NONE;
$cvs_user = $ENV{'USER'} || getlogin || (getpwuid($<))[0] || sprintf("uid#%d",$<);
$new_directory = 0;             # Is this a 'cvs add directory' command?
$imported_sources = 0;          # Is this a 'cvs import' command?
$have_r_opt = 0;		# Whether -r was seen on the command line.
$onlytag = "";			# With $have_r_opt, only send mail for changes
				# on this branch.
$branch = "";			# The branch being processed.
@mailto = ();			# Email addresses to send mail to.
$update_dir = "";		# The relative directory in the repo the
				# sandbox is rooted in.
@diffargs = ();			# Diff options.

@files = process_argv @ARGV;

# Set defaults that could have been overridden on the command line.
$update_dir = `cat CVS/Repository` unless $update_dir;
chomp $update_dir;
die "Could not determine update dir" unless $update_dir;

push @diffargs, "-ub" unless @diffargs;


@path = split '/', $files[0];
if ($#path == 0) {
    $dir = ".";
} else {
    $dir = join '/', @path[1..$#path];
}


#print("ARGV  - ", join(":", @ARGV), "\n");
#print("files - ", join(":", @files), "\n");
#print("path  - ", join(":", @path), "\n");
#print("dir   - ", $dir, "\n");
#print("id    - ", $id, "\n");


##########################
#
# Check for a new directory first.  This will always appear as a
# single item in the argument list, and an empty log message.
#
if ($new_directory) {
    $header = &build_header;
    @text = ();
    push(@text, $header);
    push(@text, "");
    push(@text, "  ".$files[0]." - New directory");
    &mail_notification ([@mailto], @text);
    exit 0;
}

#
# Iterate over the body of the message collecting information.
#
while (<STDIN>) {
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
    s/[ \t\n]+$//;              # delete trailing space
    
    push (@changed_files, split) if ($state == $STATE_CHANGED);
    push (@added_files,   split) if ($state == $STATE_ADDED);
    push (@removed_files, split) if ($state == $STATE_REMOVED);
}
# Proces the /Log Message/ section now, if it exists.
# Do this here rather than above to deal with Log messages
# that include lines that confuse the state machine.
if (!eof(STDIN)) {
    while (<STDIN>) {
        next unless ($state == $STATE_LOG); # eat all STDIN

        if ($state == $STATE_LOG) {
            if (/^PR:$/i ||
                /^Reviewed by:$/i ||
                /^Submitted by:$/i ||
                /^Obtained from:$/i) {
                next;
            }
            push (@log_lines,     $_);
        }
    }
}

#
# Strip leading and trailing blank lines from the log message.  Also
# compress multiple blank lines in the body of the message down to a
# single blank line.
# (Note, this only does the mail and changes log, not the rcs log).
#
while ($#log_lines > -1) {
    last if ($log_lines[0] ne "");
    shift(@log_lines);
}
while ($#log_lines > -1) {
    last if ($log_lines[$#log_lines] ne "");
    pop(@log_lines);
}
for ($i = $#log_lines; $i > 0; $i--) {
    if (($log_lines[$i - 1] eq "") && ($log_lines[$i] eq "")) {
        splice(@log_lines, $i, 1);
    }
}

#
# Find the log file that matches this log message
#
for ($i = 0; ; $i++) {
    last if (! -e "$LOG_FILE.$i.$id.$cvs_user");
    @text = &read_logfile("$LOG_FILE.$i.$id.$cvs_user", "");
    last if ($#text == -1);
    last if (join(" ", @log_lines) eq join(" ", @text));
}

#
# Spit out the information gathered in this pass.
#
&write_logfile("$LOG_FILE.$i.$id.$cvs_user", @log_lines);
&append_to_file("$BRANCH_FILE.$i.$id.$cvs_user",  $dir, @branch_lines);
&append_to_file("$ADDED_FILE.$i.$id.$cvs_user",   $dir, @added_files);
&append_to_file("$CHANGED_FILE.$i.$id.$cvs_user", $dir, @changed_files);
&append_to_file("$REMOVED_FILE.$i.$id.$cvs_user", $dir, @removed_files);
if ($rcsidinfo) {
  &change_summary ("$SUMMARY_FILE.$i.$id.$cvs_user",
		   (@changed_files, @added_files, @removed_files));
}

#
# Check whether this is the last directory.  If not, quit.
#
if (-e "$LAST_FILE.$id.$cvs_user") {
   $_ = &read_line("$LAST_FILE.$id.$cvs_user");
   $tmpfiles = $files[0];
   $tmpfiles =~ s,([^a-zA-Z0-9_/]),\\$1,g;
   if (! grep(/$tmpfiles$/, $_)) {
        print "More commits to come...\n";
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
@text = ();
push(@text, $header);
push(@text, "");
for ($i = 0; ; $i++) {
    last if (! -e "$LOG_FILE.$i.$id.$cvs_user");
    push(@text, &read_file("$BRANCH_FILE.$i.$id.$cvs_user", "Branch:"));
    push(@text, &read_file("$CHANGED_FILE.$i.$id.$cvs_user", "Modified:"));
    push(@text, &read_file("$ADDED_FILE.$i.$id.$cvs_user", "Added:"));
    push(@text, &read_file("$REMOVED_FILE.$i.$id.$cvs_user", "Removed:"));
    push(@text, "  Log:");
    push(@text, &read_logfile("$LOG_FILE.$i.$id.$cvs_user", "  "));
    if ($rcsidinfo == 2) {
        if (-e "$SUMMARY_FILE.$i.$id.$cvs_user") {
            push(@text, "  ");
            push(@text, "  Revision  Changes    Path");
            push(@text, &read_logfile("$SUMMARY_FILE.$i.$id.$cvs_user", "  "));
        }
    }
    push(@text, "");
}

#
# Now generate the extra info for the mail message..
#
if ($rcsidinfo == 1) {
    $revhdr = 0;
    for ($i = 0; ; $i++) {
        last if (! -e "$LOG_FILE.$i.$id.$cvs_user");
        if (-e "$SUMMARY_FILE.$i.$id.$cvs_user") {
            if (!$revhdr++) {
                push(@text, "Revision  Changes    Path");
            }
            push(@text, &read_logfile("$SUMMARY_FILE.$i.$id.$cvs_user", ""));
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
    &mail_notification ([@mailto], @text);
}
&cleanup_tmpfiles;
exit 0;
