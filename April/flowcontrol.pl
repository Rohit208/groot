#!/usr/bin/perl -w

#
# flowcontrol.pl
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

print "\n(a)::\n";

my $counter=0;
my @array =(1..10);
for $counter (@array)
{
  print ++$counter," "
}#in case of iterating through array, the control variable retrieves its original value.
print "\n the whole array :: @array\n";
print "\$counter :: $counter\n";# -->0;


print "\n(b)::\n";

my $count=0;
for $count (1..10)   #while using a list the control variable changes
{
  print ++$counter," "
}#after the any looping statements the control variable retrieves its value 
#but not in the case of a list.
print "\nThe whole array:\n @array\n";
print "\$counter :: $counter\n"; #-->10
