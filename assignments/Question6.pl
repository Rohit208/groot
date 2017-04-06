#! usr/bin/perl;

#Write a single C program to perform each of the following:
#Create a queue of N elements 
#Reverse the queue so that last element becomes first & so on .

my @Track;
my @RevTrack;
 
 
 print "No. of value to enter-->";
 my $var = <STDIN>;
  chomp($var);
 
for(my $i =0;$i < $var; $i++){
  print "Enter the element to be pushed-->";
   my $val = <STDIN>;
   chomp($val);
  push(@Track,"$val");
}
	display(@Track);
	
	print "After Reverse :: \n";
    
    while(1)  {
	if(@Track){
		my $last=pop(@Track);
		push(@RevTrack,"$last");
	}else { last; }
  }
	
	display(@RevTrack);
  
sub display {
	my @aref = @_;
	for my $r (@aref){
	  print "$r\t";	
	}
}
