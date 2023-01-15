use strict;
use 5.10.0; 

while(<>){
	my $tpr = "";
	chomp;
	s///;
	if (s/Taiwan pr[ .]*\[[^\/]*//){
		$tpr = $&;
		s|]|] / NTPR|;
		## say;
	}
	say;
	if ($tpr){
		$tpr =~ s/.*\[//;
		s/\[[^\]]*]/[$tpr/;
		s/NTPR/TPR/;
		say;
	}
}
