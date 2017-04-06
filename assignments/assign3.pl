 use strict;
   use warnings;
   
   #original string
   my $original="my name is Rohit rehni";
   print "$original\n";
   #offset of 3
   my $offset=substr($original,3);
   print "$offset\n";
   #offset of 3 and length 8
  my $off=substr($original,3,8);
  print "$off\n";
  #replace the string with new string
  my $rep=substr($original,3,8,"Rohit rehni");
  print "$rep\n";
