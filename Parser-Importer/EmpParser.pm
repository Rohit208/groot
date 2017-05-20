# ========================================================================== #
# EmpParser.pm  - Desc											
# Copyright (C) 2017 Exceleron Software, LLC           			             
# ========================================================================== #

package EmpParser;

use Moose;
use Text::CSV_XS;
use namespace::autoclean;
# ========================================================================== #
=head1 name
EmpParser - <<<EmpParser will use the contents of the file for basic content operations>>>
=head1 SYNOPSIS
  use EmpParser;
  my $xxx = EmpParser->new(
                 {
                        file_Path     => 'FILE name',
                         separate_char => 'VAlUE separater character',
                   }
        );

=head1 DESCRIPTION
The EmpParser module allows you ...
<<<
*read File  
*Form a Datastructure through the contents of the file   
*Pass value to form a database
>>>
=head2 methods
=over 4
=cut
# ========================================================================== #

=item C<test>

Params : <<<fileName,Seperate character>>>

Returns: <<<method returns Datastructure>>>

Desc   : <<<Parser -- > file convert the file contents into a Datastructure>>>
=cut


 has 'csv_handler' =>(
	   is => 'ro',
	   builder => '_build_csv_handler',
	   predicate => '_has_csv_handler',
	   init_arg => undef,
 );
 
 has 'file_Path' =>(
       is => 'ro',
	   required => 1,
 );

 has 'separate_char' =>(
	   is =>'rw',
	   isa => 'Value',
	   lazy => 1,
	   builder => '_build_separate_char',
	   predicate => '_has_separate_char',
 );

 has 'data' => (
     is => 'rw',
	 isa => 'HashRef',
	 builder => '_build_data',
	 init_arg => undef,
 );

 sub _build_csv_handler{
    my $self = shift;
   my $csv_handler = Text::CSV_XS->new({ binary => 1,eol => $/ });
   return $csv_handler;
 }

 sub _build_separate_char{
   my $self =shift;
       return $self->separate_char if $self->_has_separate_char;
  my  $separate_char = ',';
   return $separate_char;
 }
									
sub _build_data {
  my $self = shift;
    my $data = {};
	return $data;
}

sub parser {
  my $self = shift;
  
  return $self->data if(keys %{$self->data});
  
  open my $fh,'<',$self->file_Path or die "Can't open $!"; 
  $self->csv_handler->sep_char($self->separate_char);    
   while(my $each_row = $self->csv_handler->getline($fh)){
	   $self->data->{$each_row->[5]} =  \@$each_row;
   }
 return $self->data;
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

