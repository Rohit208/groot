#!usr/bin/perl;

#use strict;
#use warnings;
#use diagnostics;

my @local = localtime;
print "@local\n";

@week = qw(Sun Mon Tues Wednes Thurs Fri Sat);
$weekday = $local[6];
print "$week[$weekday]\n";

print "Today is ",(Sun,Mon,Tues,Wednes,Thurs,Fri,Sat)[(localtime)[6]], "day\n";
