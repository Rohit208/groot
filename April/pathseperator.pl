#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

my $str = "/usr/local/lib/locale/US_C.C/messages.dat";
my @array = split '/',$str;
print "folders to the directories::",join "\n",@array,"\n";

print "-------------\n";

$"="\n";
print "folders to the directories::\n @array \n";
