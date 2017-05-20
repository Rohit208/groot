# ========================================================================== #
# MyDBI.pm  - Desc											
# Copyright (C) 2017 Exceleron Software, LLC           			             
# ========================================================================== #
package MyDBI;

use Moose;
use namespace::autoclean;
use DBI;
# ========================================================================== #

=head1 NAME

	DBI - <<<description of module>>>

	=head1 SYNOPSIS

	  use MyDBI;
	  my $xxx = MyDBI->new({
                    dbname =>$self->{DatabaseName},
                    user => $self->{user},
                    password => $self->{password}}
      );	

	=head1 DESCRIPTION

	The Connect module allows you ...

	<<< 	* This will have all DB related method    >>>

	=head2 methods

	=over 4

	=cut

# ========================================================================== #

	=item C<test>

	Params : <<<host,port,dbname,user,password>>>


	Returns: <<<returns Updated Database>>>

	Desc   : <<<Insert->Insert Into Database , Update-> Update To database>>>

=cut

has 'host' => (
	is => 'rw',
	isa => 'Str',
	default => sub {
		my ($self) = @_;
		my $host = '127.0.0.1';
		return $host;
	},
);

has 'port' => (
	is =>'rw',
	isa => 'Int',
	default => sub {
		my ($self) = @_;
		my $port = 5432;
		return $port;    
	},
);

has 'dbname'=>(
	is => 'rw',
	isa => 'Str',
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

has 'dbi_con' =>(
	is => 'rw',
	lazy => 1,
	builder => '_build_dbi_con',
	init_arg => 1,
);


sub _build_dbi_con {
	my $self = shift;
	my $dsn = "DBI:Pg:dbname = $self->{dbname}";
	my $userid = $self->{user};
	my $password = $self->{password};
	my $dbHandle = DBI->connect($dsn,$userid,$password) or die $DBI::errstr ;
	$self->{dbi_con} = $dbHandle;
};

sub select {
  my ($self,$primary_key,$table_name) = @_;
  my $str = "select $primary_key from $table_name";
  my $stathandle = $self->dbi_con->prepare($str);
    $stathandle->execute() or die $DBI::errstr;
	my $row;
  $row = $stathandle->fetchall_arrayref(); 
  $stathandle->finish();
  return $row;
}

sub insert{
  my ($self,$table_name,$Columns,$Values) = @_;
  $" = ',';
  my @val = @{$Values};
  my $ColumnCount = @{$Columns};
  my $str = qq/insert into $table_name (@{$Columns}) values(/;
  for (0..$ColumnCount-2){
    $str .= '?,';
  } 
 $str .= '?)'; 
 my $stathandle = $self->dbi_con->prepare($str);
  $stathandle->execute(@val) or die $DBI::errstr;
 $stathandle->finish();
}


sub update {
 my ($self,$table_name,$Columns,$Values,$primary_key,$email) = @_;
   my $str = qq/update Employee_Enquiry SET /;
  my @Columns = @{$Columns};
  my $count = 0;
   for my $index (@Columns){
     $count++;
    if($count == $#Columns){
	  $str .= "$index = ? ";
	  last;
	}
	$str .= "$index = ?,";
   }
   $str .= "where $primary_key = ?";
   my $stathandle = $self->dbi_con->prepare($str);
    $stathandle->execute(@{$Values}) or die $DBI::errstr;
 $stathandle->finish();
}


sub delete {
my ($self,$table_name,$primary_key,$Value) = @_;             
 my $str = qq/delete from $table_name where $primary_key = '$Value'/;
  my $stathandle = $self->dbi_con->prepare($str);
   $stathandle->execute() or die $DBI::errstr;
  $stathandle->finish();
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

