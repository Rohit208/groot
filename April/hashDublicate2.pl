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

my %temp = reverse %hash;
if (values %hash == keys %temp) { #values %hash == keys %{{reverse %hash}}
print "duplicate not present";
}else { 
 print "duplicate present";
}

