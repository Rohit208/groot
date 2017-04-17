#!/usr/bin/perl -w

#
# infinitewhile.pl
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

my @numbers=();
while(1){ 
	print "Enter  number or 'quit' to end::";
	chomp(my $num = <STDIN>);
	last if($num eq 'quit');
    push @numbers,$num;
}

print "All numbers:: @numbers\n";
print  "Amount::: ",scalar(@numbers),"\n";

my ($sum,$min,$max)=(0,$numbers[0],0);
foreach my $num (@numbers){
  $sum += $num;
  $min = $num if ($min > $num);
  $max = $num if ($max < $num); 
}
print "Sum of all elements : $sum\n";
print "Average:",$sum/@numbers,"\n";
print "smallest::$min   largest::$max\n";
