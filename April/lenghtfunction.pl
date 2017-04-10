#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

my @list = qw(the quick brown fox jumps over the lazy perl programmer);
#print length(@list),"\n"; ### lenght function is used to the lrnght of substring not for counting elements of arrays and hashes;

print scalar(@list),"\n";

