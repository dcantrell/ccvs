#! @PERL@ -w

use strict;

sub save_edit {
	my ($found, $file_name, $temp_name) = @_;

	if ($found <= 0) {
		unlink $temp_name;
		print "no change: ", $file_name, "\n";
	} else {
		rename $temp_name, $file_name;
		print "save edit: ", $file_name, "\n";
	}
}

sub fix_cvsnt_dep {
	my $file_base = "cvsnt";
	my $file_name = $file_base . ".dep";
	my $temp_name = $file_base . ".tmp";

	open FINP, "< " . $file_name or die "open error: ", $file_name;
	open FOUT, "> " . $temp_name or die "open error: ", $temp_name;

	my $found = 0;
	while (<FINP>) {
		if (/basetsd\.h/) {
			$found += 1;
		} else {
			print FOUT $_;
		}
	}

	close FOUT;
	close FINP;

	save_edit $found, $file_name, $temp_name;
}

sub fix_libdiff_mak {
	my $file_base = "diff/libdiff";
	my $file_name = $file_base . ".mak";
	my $temp_name = $file_base . ".tmp";

	open FINP, "< " . $file_name or die "open error: ", $file_name;
	open FOUT, "> " . $temp_name or die "open error: ", $temp_name;

	my $found = 0;
	while (<FINP>) {
		if (/^[ \t]+cd[ \t]+"\\.*\\[Ll][Ii][Bb]"$/) {
			$found += 1;
			s/cd[ \t]+.*/cd "..\\lib"/;
		}
		print FOUT $_;
	}

	close FOUT;
	close FINP;

	save_edit $found, $file_name, $temp_name;
}

fix_cvsnt_dep;
fix_libdiff_mak;
