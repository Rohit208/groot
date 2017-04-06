#! usr/bin/perl;

#Write a program for implementing stack of strings using arrays and display output.


use strict;
use warnings;
use diagnostics;

use Switch;

my @stack;

while(1)  {
print "\n 1::Push  2:: Pop 3:: Display \n";
 my $val = <STDIN>;
  chomp($val);

switch($val)
{
case 1 {
  print "Enter the elemnt to be pushed-->";
   my $val = <STDIN>;
  chomp($val);
  if(($#stack) < 10) {
  push(@stack,"$val");
  }
  else {  print "\nOverflow in stack\n";  } 
  }
case 2 {  if(($#stack) > 0) { pop(@stack); }
	      else {  print "\nUnderflow\n";   }
	   }
case 3 {    display(); }
else { print "try again"; next; }
}

print "Enter any number to exit";
 my $val = <STDIN>;
  chomp($val);
if (!($val & ~$val)){ last; }
}
  
sub display {
	
	for my $r (@stack){
	  print "$r\n";	
	}
	
}
