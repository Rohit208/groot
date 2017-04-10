#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;

my %machines = (
   'user1' => 'yogi',
   'user2'=>  'booboo',
   'user3'=>  'rupert',
   'user4'=>  'teddy',
   'user5'=>  'care',
   'user6'=>  'winnie',
   'user7'=>  'sooty',
   'user8'=>  'padders',
   'user9'=>  'polar',
   'user10'=> 'bungle',
   'user11'=> 'baloo',
   'user12'=> 'bagira',
   'user13'=> 'hair',
   'user14'=> 'fozzie',
   'user15'=> 'huggy',
   'user16'=> 'barney',
   'user17'=> 'stuwart'
);

my @keyarray = keys %machines;
my @valuearray = values %machines;

print "\@keyarray :\n", (join ':::',@keyarray), "\n";
print "\@valuearray :\n", (join ':::',@valuearray), "\n";

print "\n=-------------------=\n";

$" = ':';
print "@keyarray \n";
print "@valuearray \n";



$machines{user15} = undef;

$machines{user16} = 'stinson';

$machines{user18} = $machines{user17};
delete $machines{user17};

my @mac = delete @machines{'user5','user6','user7'};

while((my $key,my $val) = each %machines)
{
 if(defined $val)
 {
   print "$key : $val\n";
 }
}

print "\n-----unallocated machines---\n";
@mac = sort @mac;
print "@mac\n";

