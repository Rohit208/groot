#!/usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Data::Dumper;
$| = 1;

my $countries = {
    "Cricket" => {
        india  => ['a','d'],
        us     => 'b',
        canada => 'c',
    },
    "football" => {
        india  => 'a',
        us     => 'b',
        canada => 'c',
        india  => 'd'
      }

};

print $countries->{'football'}->{'india'} = "sachin";
print "\n";

my $countries2 = {
    "Australia" => {
        Cricket  => 'a',
        Hockey   => 'b',
        Football => 'c'
    },
    "India" => {
        Cricket  => 'a',
        Hockey => 'b',
        Football => 'c'
      }

};

print $countries2->{'India'}->{'GYMnastics'} = 'g';
print "\n";

print Dumper $countries2;
print "==========================================\n";
print Dumper $countries;

