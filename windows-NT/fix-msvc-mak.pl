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
	my $file_name = "cvsnt.dep";
	my $temp_name = $file_name . ".tmp";

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
	my $file_name = "diff/libdiff.mak";
	my $temp_name = $file_name . ".tmp";

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



sub set_default_configuration {
	my ($file_name) = @_;
	my $temp_name = $file_name . ".tmp";

	open FINP, "< " . $file_name or die "open error: ", $file_name;
	open FOUT, "> " . $temp_name or die "open error: ", $temp_name;

	my $found = 0;
	while (<FINP>) {
		if (s/^(CFG=\w+ - Win32 )Release$/$1Debug/)
		{
			$found += 1;
		}
		elsif (s/(Defaulting to \w+ - Win32 )Release\.$/$1Debug/)
		{
			$found += 1;
		}
		print FOUT $_;
	}

	close FOUT;
	close FINP;

	save_edit $found, $file_name, $temp_name;
}



fix_cvsnt_dep;
fix_libdiff_mak;

foreach my $file ("cvsnt.mak", "lib/LIB.mak", "diff/libdiff.mak",
                  "zlib/zlib.mak")
{
	set_default_configuration $file;
}
