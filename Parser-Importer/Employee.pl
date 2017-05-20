#!/usr/bin/perl -w

#
# Employee.pl
#
# Developed by Rohit Rehni <Rohit@exceleron.com>
# Copyright (c) 2017 Exceleron Software, LLC
# All rights reserved.
#
# Changelog:
# 2017-05-11 - created
#

use strict;
no warnings;
use diagnostics;

use EmpParser;
use EmpImportor;
use Text::Table;
use EmployeeDetails;
use Switch;

my $try = EmpParser->new(
    {
        file_Path     => 'first.csv',
        separate_char => ';',
    }
);

my $May_try = EmpImportor->new(
    {
        DatabaseName => 'rohit',
        TableName    => 'employee_enquiry',
        user         => 'rohit',
        password     => '12345',
    }
);

sub display_table {
    my @db;
    my $tb = Text::Table->new(
        \'|    ', "Name",       \'|    ', "DateOfBirth",
        \'|    ', "Department", \'|    ', "DateOfJoining",
        \'|    ', "Salary",     \'|    ', "Email",
        \'     |'
    );
    foreach my $v ( values( $try->parser ) ) {
     
		push( @db, $v );
    }
    $tb->load(@db);
    my $rule = $tb->rule(qw/- +/);
    my @arr  = $tb->body;
    print $rule, $tb->title, $rule;
    print $_. $rule for @arr;

}

print
"\n---------------------------------------------Employee Details---------------------------------------------\n";
display_table();


sub new_details {
        print "\n::::Details of the Empolyee ::::\n";
        
		print "Enter the Emailid of the Employee :: ";
		chomp(my $email = <STDIN>);

        print "Enter the Name of Employee :: ";
        chomp(my $name = <STDIN> );

        print "Enter the DOB of Employee :: 'Ex-> 1994-01-01'\t ";
        chomp(my $dob = <STDIN> );

		print "Enter the Department of Employee ::\t ";
        chomp(my $dept = <STDIN> );

        print "Enter the DOJ of Employee :: 'Ex-> 1994-01-01' \t ";
        chomp(my $doj = <STDIN> );

        print "Enter the Salary of Employee ::\t ";
        chomp(my $salary = <STDIN> );

    my @newrecord = ( $name, $dob, $dept, $doj, $salary, $email );
   my $employee_obj;   
   eval { $employee_obj = EmployeeDetails->new(@newrecord)} ? print "pass to data" : return 0 ;
   $employee_obj = undef;
  unless(exists $try->data->{$email}){
       $try->data->{$email} = \@newrecord;
	   print "--DONE\n";
	 return 1;
   }
  else {
	  my @update_array;
      print "-->Email Exists Already\n";
			$try->data->{$email} = \@newrecord; 
			push(@update_array,$email);		
		   $May_try->refined->{Update} = \@update_array;
		   print "Updated..1\n";
		   return 1;
   } 
}

while (1) {
    print
"\n  1::Add employee\n  2::Edit employee\n  3::Delete Employee\n  4::List Of Employee\n\n Any other key to STOP\n Option-> \t";
    chomp( my $val = <STDIN> );
    switch ($val)
	{
        case 1 {   print "::: Invalid details :::\n" unless(new_details());     }
        case 2 {   print "::: Invalid details :::\n" unless(new_details($val)); 	}
		case 3 {
		    print "Enter the Emailid of the Employee :: ";
		    chomp(my $email = <STDIN>);
           my @delete_array;
			push (@delete_array,$email) ;
			$May_try->refined->{Delete} = \@delete_array;
			delete $try->data->{$email} if(exists $try->data->{$email});
	        print "Deleted..1\n";
		 }
        case 4 { display_table();   }
        else { $val = 0; }
    }
    if ( $val == 0 ) { last; }
}

$May_try->importor($try);

$| = 1;

# vim: ts=4
# vim600: fdm=marker fdl=0 fdc=3

