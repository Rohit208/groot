#!/usr/bin/perl -w
use strict;
use warnings;
use diagnostics;

@ARGV or die "no file found";
my $filename = shift;
open FILE,$filename or die "can't open file::$!";
$/ = ",";

while (<FILE>){
  chomp;
  print "{{{$_}}}\n";
}

close FILE;
