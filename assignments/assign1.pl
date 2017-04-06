#!/usr/bin/perl
   @capital=("Delhi","Mumbai","Kolkata");
   @population=(10000,1000,100);
  print "$capital[0]\n";
  print "$capital[1]\n";
  print "$capital[2]\n";
  print "$population[0]\n";
  print "$population[1]\n";
  print "$population[2]\n";
 $size=@capital;
 print "capital size:$size\n";
 $size=@population;
 print "population size:$size\n";
  

  push @capital,"Bangalore";
 
  push @population,10;
  print "push bangalore...\n";
  print"@capital\n";
  print"push population 10...\n";
  print"@population\n";
  
  shift @capital;
  print"remove Delhi..\n";
  print "@capital\n";
  
  unshift @capital,"Delhi";
  print "add Delhi..\n";
  print "@capital\n";
  pop @capital;
  print "pop BANGALORE..\n";
print "@capital\n";
