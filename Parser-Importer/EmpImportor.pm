# ========================================================================== #
# EmpImportor.pm  - Desc
# Copyright (C) 2017 Exceleron Software, LLC
# ========================================================================== #

package EmpImportor;

use Moose;
use EmpParser;
use namespace::autoclean;
use EmployeeDetails;
use MyDBI;
# ========================================================================== #

=head1 NAME

EmpImportor - <<< it will import the contents of file into a Database>>>

=head1 SYNOPSIS

  use EmpImportor;
  my $xxx = EmpImportor->new({
           DatabaseName => 'Database Name',
           TableName => 'TableName to modify',
           user => 'database username',
           password => 'database password',
       });


=head1 DESCRIPTION

The EmpImportor module allows you ...
<<<

* validate data
* send it to database

>>>

=head2 methods

=over 4

=cut

# ========================================================================== #

=item C<test>

Params : <<<DatabaseName,TableName,user,password-> UserPassword,entity-->contents of the file in the form a dataStructure ( hash Ref ) >>>

Returns: <<<method return  Updated Database >>>

Desc   : <<< Importer --> takes the object/class of the Parser class as argument to  convert the contents of the dataStructure into a Database >>>

=cut

has 'data' => (
    is  => 'rw',
    isa => 'HashRef',
	init_arg => 1,
);

has 'refined' => (
    is => 'rw',
	isa => 'HashRef',
	init_arg => 1,
	builder => '_build_refined',
);

has 'TableName' =>(
    is => 'rw',
	isa => 'Str',
	required => 1,
);

 has 'DatabaseName' => (
   is => 'rw',
   isa => 'Str',
   required => 1,
 );
								    
has 'user' => (
   is =>'rw',
   isa => 'Str',
   required => 1,
 );
																					     
has 'password' => (
  is => 'rw',
  isa => 'Str',
  required => 1,
 );

sub _build_refined {
   my $self = shift;
   my $refined = {};
  return $refined;
}

sub importor {
	my $self = shift;
	my $employee_obj;
	my $parser = shift;
	$self->{data} = $parser->parser;
	my $dbi = MyDBI->new({
			dbname =>$self->{DatabaseName},
			user => $self->{user},
			password => $self->{password},
   });
	
   my $primary_key = $dbi->select('email',$self->{TableName});
	for my $index (@{$primary_key}) {
    	delete($self->data->{$index->[0]})  if(exists $self->data->{$index->[0]}) ;   
	} 

   while (my ($key, $value) = each (%{$self->refined})){
    if($key eq 'Update'){
	  for my $index (@{$value}){
		 pop @{$self->data->{$index}};
	     $dbi->update($self->{TableName},['name','date_of_birth','department','date_of_joining','salary'],$self->data->{$index},'email',$index);
		 delete( $self->data->{$index} );
	   }
	  }
	if($key eq 'Delete'){
	  for my $index (@{$value}){
	    $dbi->delete($self->{TableName},'email',$index);
		delete( $self->data->{$index} );
	   } 
	  }
   	}

	foreach my $keys ( keys %{ $self->data } ) {
      eval{ $employee_obj  = EmployeeDetails->new(@{$self->data->{$keys}}) } ? print "Pass--" : delete( $self->data->{$keys} );
   	  $employee_obj = undef;
    next unless(exists $self->data->{$keys});
	$dbi->insert($self->{TableName},['name','date_of_birth','department','date_of_joining','salary','email'],$self->data->{$keys});
  }
}

1;

__END__

=back
   
=head1 LICENSE

Copyright (C) 2017 Exceleron Software, LLC

=head1 AUTHORS

Rohit Rehni, <Rohit@exceleron.com>

=head1 SEE ALSO

=cut

# vim: ts=4
# vim600: fdm=marker fdl=0 fdc=3

