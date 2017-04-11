#!usr/bin/perl;

use strict;
use warnings;
use diagnostics;
use Switch;
use Text::CSV_XS;
use Text::Table;

my  @DB;
my $new;
my $string;
my $file = $ARGV[0] or die "file not loaded\n";

sub CSV()
{ 
  my $csv = Text::CSV_XS-> new({ binary => 1, eol => $/});
  open my $FILE,"<",$file or die "couldn't open $file : $!";
  while(my $value = $csv->getline($FILE)) {
  push(@DB,$value);
   }
close($FILE) or die "couldn't close";
}

sub Table()
{
my $tb = Text::Table->new("Name","DateOfBirth","Department","DateOfJoining","Salary","Email");
$tb->load(@DB);
print $tb;
}

sub NewEmployee()
{
print "\n::::Details of the Empolyee ::::\n";
print "Enter the Email_ID :: ";
my $Email = <STDIN>;
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
if($val==1){ 
  $string = join(",",@newrecord);
  Append();
 } 
if($val==2) { 
  $new = \@newrecord;
  }
}

sub Writer()
{
 open my $DATA,">",$file or die "couldn't open";
 foreach my $v (@DB)
  {
   if(defined $v){
      my @record = @{$v};
      $record[4]= '"'.$record[4].'"';
      $string = join(',',@record);
      @record = ();
      print $DATA "$string\n";
    }
  }
 close $DATA or die "Writer not closed";
}

sub Append()
{
 open my $DATA,">>",$file or die "couldn't open";
   print $DATA "$string\n";
 close $DATA or die  "Appender not closed";
}

sub validate() {
my $count = 0;
print "Enter Email_ID for validation ::\n";
chomp(my $Email=<STDIN>);
foreach my $v (0..$#DB) {
my $gmail = ${$DB[$v]}[5];
 if($Email eq $gmail ) {
   $count++;
   print "Already available try a NEW Record\n";
   print "Do you want to do with Record ::Delete-1 \t Edit-2\t ";
   chomp(my $val =<STDIN>);
   if($val==1) {
      $DB[$v] = undef;
      Writer();
      print "DONE!";
      last;
    }
   if($val ==2) { 
        NewEmployee();
        $DB[$v] = $new;
        Writer();
        print "DONE!";
        last;
    }
  }
 }
if($count == 0) { NewEmployee(); print "NEW RECORD!!"; }
}

while(1)  {
print "\n  1::List of Employees\n  2::Add employee\n  3::Edit employee\n  4::Delete Employee\n\n Any other key to STOP" ;
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

