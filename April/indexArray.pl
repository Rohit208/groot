#! usr/bin/perl;

use strict;
#use warnings;
#use diagnostics;

my @arr = (0..10);
print "highest index--$#arr\n";

$arr[20]=20;

my $arr = $#arr;
print "highest index now--$arr\n";

$#arr = 5;
print "@arr\n";

$arr[$arr] = 20;
print "@arr\n";

