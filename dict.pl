#!/usr/bin/perl -w
use strict;
use 5.10.0; 


while(<>){
	chomp;
	next if /^#/;

	# Weird dots in compound words
	s/·//g;

	my ($zi, $pinyin, $def) = split /[[\]]/, $_;
	my ($trad, $simp, @deng) = split / /, $zi;

	# Personal typing conventions
	$pinyin =~ s/u:/uw/;

	# Format pinyin for typing
	$pinyin =~ s/ //g;
	$pinyin = lc($pinyin);
	$pinyin =~ tr/12345/70548/;

	print join "\t", @{[$trad, $pinyin, $def]};
	print "\n";
}

