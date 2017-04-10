#!usr/bin/perl;

use strict;
#use diagnostics;

my @array =qw('a', 'b', 'c');

print @array;


while((my $i,my $v)= each @array) {
   print ("\n $i ==>  $v");
}

#qw() lists contain items separated by whitespace; therefore
 #   commas aren't needed to separate the items.  (You may have used
  #  different delimiters than the parentheses shown here; braces are also
   # frequently used.)
