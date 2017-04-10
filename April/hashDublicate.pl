#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

my %hash = (
  'sub1' =>  'history',
  'sub2' =>  'maths', 
  'sub3' =>  'english',
  'sub4' =>  'maths',
  'sub5' =>  'science'
);
my %Hash2;
for my $key (keys %hash)
{
my $value = $hash{$key};
if (! exists $Hash2{$value}) {
  $Hash2{$value} = undef;
}else {
   print "Duplicate value: $value\n";
 }
}


