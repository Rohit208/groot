#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

my %value;

while(scalar(keys %value)<6) {
 my $rand = int(rand 49) +1;
 $value{$rand} = $rand;
}
my @val = sort keys %value;
print "@val\n"; 
