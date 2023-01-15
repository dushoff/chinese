#!/usr/bin/perl -w

use strict;
use 5.10.0;

# undef $/;

my %dict;

while(<>){
	next if /^#/;
	chomp;
	my ($zi, $pinyin, $def) = split /\t/, $_;
	$dict{$_}=$pinyin;
}

foreach (sort {$dict{$a} cmp $dict{$b}} keys %dict){
	say;
}

