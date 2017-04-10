#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

while(1)
{
chomp(my $str=<STDIN>);
if($str eq 'exit')
{ last;  }
print "$str\t"x5;
}
