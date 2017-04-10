#! usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Data::Dumper;

my %hash = (
   "dan" => "norman",
   "robert" => "anson",
   "christopher" => "fowler",
   "dan" => "simmons",
   "robert" => "harris"
);
chomp(my $name =<STDIN>);

print("\n Full name =$name  $hash{$name}");

($hash{$name},$hash{$name}) = qw/martin joseph/ ;
print Dumper %hash;

print "\n\n\n";

while((my $k,my $v) = each %hash )
{
print  "$k"." =>  $v\n";
}
