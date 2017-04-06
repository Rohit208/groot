#!usr/bin/perl

use Data::Dumper

my @stu =(1,2,3);
my %hash = (
   "bananas" => "@stu",
   "apple" => "red",
   "oranges" => "orange"
);

print "Hash:",Dumper\%hash;

foreach $key (keys %hash)
{
	print "$key is $hash{$key}\n";
}
