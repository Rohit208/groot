#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

my $PIN = '0123';

foreach (1..3)
{
chomp(my $PIN2 = <STDIN>);
print $PIN eq $PIN2 ?'RIGHT PIN':'wrong PIN :: try again' ;
}
