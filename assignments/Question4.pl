#! usr/bin/perl;

#print the sum of diagonals of the matrix.

use strict;
use warnings;
use diagnostics;

print "enter For N*N value for matrix\n";
my $a = <STDIN>;
my @rowarray;
my @colarray;

for (my $i = 0; $i < $a; $i++) { 
  for(my $j=0; $j < $a; $j++) {
   my $numb = <STDIN>;
   push(@colarray,"$numb");
  }
  push(@rowarray,"@colarray");
  @colarray = ();
}

my ($count,$last) = (0,"$#rowarray"); 
my ($d1,$d2) = (0,0);

print "\n Matrix Is printed--->\n";
for my $r(@rowarray) {
	print "\$y is a number\n" if !($r & ~$r);
  @colarray = split('\n',$r);
  $d1 += $colarray[$count];
  $d2 += $colarray[$last];
  $count++;
  $last--;
 }

print "sumof diagonal1 ::  $d1 \n";
print "sum of diagonal2 :: $d2 \n";
