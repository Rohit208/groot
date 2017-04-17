#!/usr/bin/perl -w

#
# record_seperator.pl
#
# Developed by Sheeju Alex <sheeju@exceleron.com>
# Copyright (c) 2017 Exceleron Software, LLC
# All rights reserved.
#
# Changelog:
# 2017-04-17 - created
#

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
