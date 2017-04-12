#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Switch;
use Text::CSV_XS;
use Text::Table;
use Email::Valid;

my %hash;
my  @DB;

my $file = $ARGV[0] or die "file not loaded\n";
my $csv = Text::CSV_XS-> new({ binary => 1, eol => $/});

sub CSV
{ 
  open my $FILE,"<",$file or die "couldn't open $file : $!";
  while(my $value = $csv->getline($FILE)) {
  push(@DB,$value);
   }
close($FILE) or die "couldn't close CSVreader";
}

sub Table
{
my $tb = Text::Table->new(\'| ', "Name",\'| ', "DateOfBirth",\'| ', "Department",\'| ', "DateOfJoining",\'| ', "Salary",\'| ' , "Email",\' |');
$tb->load(@DB);
my $rule = $tb->rule(qw/- +/);
my @arr =$tb->body;
print $rule,$tb->title,$rule;
for(@arr)
 {
  print $_.$rule;
 }
}

sub NewEmployee
{
print "\n::::Details of the Empolyee ::::\n";
my $Email = $_[0];
print "Enter the Name of Employee :: ";
chomp(my $Name=<STDIN>);
print "Enter the DOB of Employee :: ";
chomp(my $DOB=<STDIN>);
print "Enter the Department of Employee :: ";
chomp(my $Dept=<STDIN>);
print "Enter the DOJ of Employee :: ";
chomp(my $DOJ=<STDIN>);
print "Enter the Salary of Employee :: ";
chomp(my $Salary=<STDIN>);
my @newrecord = ($Name,$DOB,$Dept,$DOJ,"$Salary",$Email);
print "Do you want to want to Edit values or Save values::::\n 1--Save\t  2--Edit";
chomp(my $val = <STDIN>);
  my $numregex = $val =~ /^[0-9]+$/;
  if (not $numregex){    print "Give a valid input"; return 0; }
if($val==1){ 
 my $string = join(",",@newrecord);
  Append($string);
 } 
if($val==2) { 
  my  $new = \@newrecord;
  return $new;
 }
}

sub Writer
{
 open my $DATA,">",$file or die "couldn't open";
 foreach my $v (@DB)
  {
   if(defined $v){
      my @record = @{$v};
      $record[4]= '"'.$record[4].'"';
      my $string = join(',',@record);
      @record = ();
      print $DATA "$string\n";
    }
  }
 close $DATA or die "Writer not closed";
}

sub Append
{
 my $string = $_[0];
 open my $DATA,">>",$file or die "couldn't open";
   print $DATA "$string\n";
 close $DATA or die  "Appender not closed";
}

sub validate {
print "Enter Email_ID for validation ::\n";
chomp(my $Email=<STDIN>);
my $address = Email::Valid->address($Email);
my $regex = $Email =~ /^[0-z0-9]([a-z0-9.]+[a-z0-9])?\@[a-z0-9.-]+$/;
if(not $address and not $regex) {
  print "INvalid Email_ID";  return 0;
 }
for my $v(0..$#DB) {
   $hash{${$DB[$v]}[5]} = $v;
 }
if(exists $hash{$Email}) {
   print "Already available try a NEW Record\n";
   print "what Do you want to do with Record ::Delete-1 \t Edit-2\t option->\t ";
   chomp(my $val =<STDIN>);
  my $numregex = $val =~ /^[0-9]+$/;
  if (not $numregex){    print "Give a valid input"; return 0; }
   if($val==1) {
      $DB[$hash{$Email}] = undef;
      Writer();
      print "DONE!";
      return 0;
    }
  
   if($val==2) { 
      my  $new = NewEmployee($Email);
            if($new==0) {  return 0;  }
      $DB[$hash{$Email}] = $new;
       Writer();
       print "DONE!";
       return 0;
    }
} 
else {   print "New Record!";   NewEmployee($Email);   }
}

while(1)  {
print "\n  1::List of Employees\n  2::Add employee\n  3::Edit employee\n  4::Delete Employee\n\n Any other key to STOP\n Option-> \t" ;
chomp(my $val=<STDIN>);
switch($val)
{
 case 1 {
    CSV();
    Table();
   }
 case 2 {
    CSV();
    validate();
   }
 case 3 {
    CSV();
    validate();
   }
 case 4{
    CSV();
    validate();
  }
else{ $val=0; }
}
@DB=();
if($val==0){ last; }
}

