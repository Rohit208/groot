#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

my $str = "Did you feed the dog today?";
my $feedindex = index $str,'feed';
my $feedlength = length 'feed';
my $feed = substr $str,$feedindex,$feedlength;
print "$feed\n";

my $dogindex = index $str,'dog';
my $doglength = length 'dog';
substr $str,$dogindex,$doglength,'cat';
print "$str\n";

substr $str,$dogindex,$doglength,'labrador';
print "$str\n";
