#!usr/bin/perl;

use strict;
use diagnostics;
use warnings;

my @new = qw!yogi booboo grizzly rupert baloo teddy bungle care!;

splice @new,4,1,qw!greppy!;
push(@new,'greppy');

print "\n @new";
my $new = @new;
print "lenght of array $new";
