#!usr/bin/perl;

use strict;
use warnings;
use Data::Dumper



print "Enter the first name==";
my $first = <>;

print "Enter the last name==";
my $last = <>;

my @personal = ("$first","$last");
 
print @personal;
 
my %collector = (
	"first" => "$first",
	"last" => "$last",
);
 print "Hash:",Dumper\%collector;

while (my ($k,$v) = each %collector) {
	
	print "$k is $v";
}

foreach my $key (keys %collector) {
	print "$key is $collector{$key}";
};
