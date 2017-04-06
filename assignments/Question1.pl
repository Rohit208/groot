#! usr/bin/perl;

#Menu driven program to add ,delete, Modify records and Display record of the employee attendance in a IT  company using binary file.

use strict;
use warnings;
use diagnostics;
use feature "say";
use Switch;


my %details = ();
my @student = ();


#Show
sub Show {
 
 for my $key(keys %details) {
	
	say "\nid for the student = $key";
	say "Details of the student are as follows::";
	
	print "-->>$details{$key}" ;
 }
}


#add
sub Add {
    
    if(! exists  $details{$_[0]} ) {
     my @student = Taker();
     $details{$_[0]} = "@student";
   }
   else{ say 'leave...no use'; }
}

#delete
sub Delete {
    
   if(exists($details{$_[0]})) {
     delete $details{$_[0]};
  }
  else{ say 'leave... no use'; }
}

#modify
sub Modify {
    
  if(exists($details{$_[0]})) {
	  my @student = Taker();
     $details{$_[0]} = "@student";
  }
  else{ say 'leave... no use'; }
}
#value Adder
sub Taker {
   
    say 'enter the name of the student:::';
     my $name = <>;
    chomp $name;
    
    say 'enter the name of the department:::';
     my $dept = <>;
    chomp $dept;
    
	say 'enter the name of the percentage:::';
     my $perc = <>;
     chomp $perc;
     
     my @student = ("$name","$dept","$perc");

 return @student;
}
#BinaryTransfer
sub BinaryTransfer {
	
my $binarySample = FollowValues(); 
my $chars = length($binarySample);
my @packArray = pack("B$chars",$binarySample);
print "@packArray\n";
}

#FollowValues
sub FollowValues  {
 my $ value;
 for my $key(keys %details) {
	
	  $ value .= "$key---$details{$key}---" ;
 }
 return $value;
}

#Read from the file
sub ReadFile  {
	
 my $emp_file ="employee.txt";
 open my $FH,'<',$emp_file or die "Can't open file: $_";
 while(my $info = <$FH>)
  {
	chomp($info);
	print $info;
 }
close $FH or die "couldn't close : $_";
}

#append to the file
sub AppendFile {
	
 my $emp_file ="employee.txt";
 open my $FH,'>>',$emp_file or die "can't open file : $_";
 my $value = FollowValues();
 print $FH "$value" ;
 close $FH or die "couldn't close : $_";
}

while(1)
{
  	say "1::  ADD value of student\n2::  Delete value of the student\n3::  Modify the value\n4::  Display result\n5:: read file\n6:: write to file \n7:: convert to binary file";
	 my $option = <STDIN>;
    chomp($option);
  
  	say 'enter the name of the id:::';
     my $id = <STDIN>;
     chomp($id);
     
  switch($option)
  {
	case 1  { Add($id);        }
	case 2  { Delete($id);     }
	case 3  { Modify($id);     }  
	case 4  { Show();          } 
	case 5  { ReadFile();      }
	case 6  { AppendFile();    }
	case 7  { BinaryTransfer();}
	else    { say  "try again"; next; }
  }
  
  	say '\n Enter "exit" to Quit';
	 my $g = <>;
	 chomp ($g);
	 
       if($g eq "exit"){
	       last;
       }
}

