#!/usr/bin/perl -w

#
# stems.pl
#
# Developed by Sheeju Alex <sheeju@exceleron.com>
# Copyright (c) 2017 Exceleron Software, LLC
# All rights reserved.
#
# Changelog:
# 2017-04-17 - created
#

use strict;
use warnings;
use diagnostics;

use Data::Dumper;

my %stems;

while (<STDIN>) {
	chomp;
	foreach my $count (1..length($_))
	{
		$stems{substr($_, 0, $count)} += 1;# intial value of a undefined hashkey would be undefined. undef in scalar context is 0.
   }
}

foreach my $stem_size (2..6) {
	my $best_stem;
	my $best_count = 0;

	while(my ($stem,$count)= each %stems)	{
	if($stem_size == length($stem) && $count > $best_count) {
	    $best_stem = $stem;
		$best_count = $count;
	 }
	}
   
	if(defined $best_stem){
	 print "Most popular stem of size $stem_size is::". "$best_stem (occurs $best_stem times)\n";
	}

}



