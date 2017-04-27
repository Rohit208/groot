#!/usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Data::Dumper;

my $data = {
	"Cricket" => ['a|india', 'b|us', 'c|canada', 'f|india', 'z|us', 'g|india','p|india'],
	"Football" => ['c|india', 'd|us', 'e|canada','fgh|canada','dfg|us','kjh|us'],
};

my $expected_ds = {

	india => {
		"Cricket" => ['a', 'd'],
	    "Football" => ['c']	
	},

};

my %builded_ds;

foreach my $keys (keys %$data){
   my %hash = map {my ( $v,$k ) = split ('\|');  ($k,$v) } @{$data->{$keys}};
   $builded_ds{$keys} = \%hash;
}
print Dumper $expected_ds;
print "==============================\n";
print Dumper $data;
print "==============================\n";
my $cons_ds;
 

foreach my $game (keys %$data){
	foreach my $val (@{$data->{$game}}) {
		my ($player, $country) = split '\|', $val;
		if(exists $cons_ds->{$country}{$game}){
	    	$cons_ds->{$country}{$game}  = [ref($cons_ds->{$country}{$game})?@{$cons_ds->{$country}{$game}}:$cons_ds->{$country}{$game},$player];
	    	next;
		}
		$cons_ds->{$country}{$game} = $player;
	}
} 

print Dumper $cons_ds;
$| = 1;
