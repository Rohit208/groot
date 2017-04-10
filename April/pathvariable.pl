#!usr/bin/perl;


use strict;
use warnings;
use diagnostics;

my $Sep;
if($^O eq "MSWIN32"){
 $Sep =';';
}
else {
 $Sep =':';
}
my $path = $ENV{PATH};

my @dirs = split $Sep,$path;

print "--------------\n";
print "Number of directories::",scalar(@dirs),"\n";
$" = "\n"; 
print "Directories: \n @dirs \n";

print "--------------\n";
print "Directories: \n", join("::::",@dirs);


