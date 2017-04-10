#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

my @Array = (1..8);
print "@Array\n";

my @new = splice @Array,4;
print "@new\n";

(my $first,@new) = splice @new,0;
print "$first--- @new\n";

push(@Array,@new);
print "@Array\n";



