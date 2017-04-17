#!/usr/bin/perl -w

#
# Total_of_records.pl
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

my $lines;
my $bytes;

while(<>){
	$lines++;
	$bytes +=length;
}

print "lines :: $lines ,  bytes :: $bytes\n";
