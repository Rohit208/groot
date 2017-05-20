# ========================================================================== #
# EmployeeDetails.pm  - Desc
# Copyright (C) 2017 Exceleron Software, LLC
# ========================================================================== #

package EmployeeDetails;

use Moose;
use Email::Valid;
use Moose::Util::TypeConstraints;

subtype 'String'
     => as 'Str',
     => where {/^[a-zA-Z _]+$/} ,
     => message {"$_ is a String"};

subtype 'Date'
	  => as 'Str',
	  => where {/^(19|20)\d\d-(0[1-9]|1[0-2])-(0[0-9]|[12][0-9]|3[01])$/},
	  =>message {"$_ is not a date"};			     
 
subtype 'Email'
       => as 'Str'
	   => where { Email::Valid->address($_) }
       => message { "$_ is not a valid email address"} ;

subtype 'Email2'
      => as 'Email',
      => where {/^[a-z0-9A-Z]([a-z0-9A-Z.]+[a-z0-9A-Z]).@[a-zA-Z0-9.-]+$/},
      => message {"$_ is not a date"};

 has 'name' => ( 
    isa => 'String',
    is => 'ro',
 );

 has 'date_of_birth' => ( 
  	is => 'ro',
    isa => 'Date',
 );

 has 'department' => ( 
    isa => 'String',
 	is => 'rw',
 );

 has 'date_of_joining' => (
    is  => 'ro',
	isa => 'Date',
 );


 has 'salary' => ( 
	isa => 'Num',
	is => 'rw',
 );

 has 'email' => (
    is => 'rw',
	isa => 'Email2',
 );

around BUILDARGS => sub {
   my $orig = shift;
   my $class = shift;

   if(@_== 6){
     return $class->$orig(
		 name => $_[0],
         date_of_birth => $_[1],
		 department => $_[2],
		 date_of_joining => $_[3],
		 salary => $_[4],
		 email => $_[5],
	 );
   }
};

1;
