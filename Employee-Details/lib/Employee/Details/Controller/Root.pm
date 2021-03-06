package Employee::Details::Controller::Root;
use Moose;
use namespace::autoclean;
use Text::xSV;
use Employee::Details::Schema;
use DBIx::Class::ResultSet;
BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config( namespace => '' );

=encoding utf-8

=head1 NAME

Employee::Details::Controller::Root - Root Controller for Employee::Details

=head1 DESCRIPTION

CURD operations on employee contents and render it on the database.

=head1 METHODS

insert :: it is private method for creating a new record.

delete :: it is a private method for deleting a value in the database requires a email address as the primary key.  

edit :: it is private method for updateing the values of the existing database.

manage :: method for scrolling to the private methods.

manage_data :: method for passing values for the crud operations.

=head2 index
Path                    <<->>      Private
/index                    |
/...                      |          /default
/manage/...               |          /manage  
/manage_data/...          |          /manage_data    
/parser_N_importer/...    |          /parser_N_importer 

=cut

=head2  Private variables

PARAMS :: csv_handler, separate_char, dbi_con

=cut

has 'csv_handler' => (
    is        => 'ro',
    builder   => '_build_csv_handler',
    predicate => '_has_csv_handler',
    init_arg  => undef,
);

has 'separate_char' => (
    is        => 'rw',
    isa       => 'Value',
    lazy      => 1,
    builder   => '_build_separate_char',
    predicate => '_has_separate_char',
);

has 'dbi_con' => (
    is       => 'rw',
    builder  => '_build_dbi_con',
    init_arg => 1,
);

=head2 Build_in DBI connection

SUBROUTINE :: _build_dbi_con 

RETURNS :: DBI Connection Handle

=cut

sub _build_dbi_con {
    my $self     = shift;
    my $dsn      = "DBI:Pg:dbname = employee";
    my $dbHandle = Employee::Details::Schema->connect( $dsn, 'rohit', '12345' );
    $self->{dbi_con} = $dbHandle;
}

=head2 Build_in File Connection

SUBROUTINE :: _build_csv_handler

RETURN ::  File Handle
          
=cut

sub _build_csv_handler {
    my $self        = shift;
    my $csv_handler = Text::xSV->new();
    return $csv_handler;
}

=head2

SUBROUTINE :: _build_separate_char 

RETURNS :: Gets the separate char for seperate entities

=cut

sub _build_separate_char {
    my ( $self, $c ) = @_;
    $self->seperate_char = $c->req->body_param->{seperate_char};
    return $self->separate_char if $self->_has_separate_char;
    my $separate_char = ',';
    return $separate_char;
}


sub index : Path : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'index.tt';
}

=head2 parser_N_importer

PARAMS :: file

return :: CURD operations on the following file.

=cut

sub parser_N_importer : Local {
    my ( $self, $c ) = @_;
    my $file = $c->req->body->{file};

    my $detail_rs = $self->dbi_con->resultset('EmployeeDetail');
    $self->csv_handler->load_file($file);
    $self->csv->read_header();
    while ( $self->csv_handler->get_row() ) {
        my $row = $self->csv_handler->extract_hash();
        $detail_rs->create($row);
    }
    $c->stash->{'template'} = 'index.tt';
}

=head2 insert

PARAMS :: name ,date_of_birth ,department ,date_of_joining ,salary ,email 

RETURNS :: NONE

=cut

sub insert : Private {
    my ( $self, $c ) = @_;
    my $detail_rs = $self->dbi_con->resultset('EmployeeDetail');

    #############code to  validate ############

    $detail_rs->create(
        {
            name            => $c->req->body_params->{name},
            date_of_birth   => $c->req->body_params->{date_of_birth},
            department      => $c->req->body_params->{department},
            date_of_joining => $c->req->body_params->{date_of_joining},
            salary          => $c->req->body_params->{salary},
            email           => $c->req->params->{email}
        }
    );

    $c->log->debug("********** Inserted ***********");
    $c->stash->{'error'} ='Success';
	$c->stash->{'template'} = 'index.tt';
}

=head2 manage

PARAMS :: email 

RETURNS :: Redirects to Private Subroutines

=cut

sub manage : Local {
    my ( $self, $c ) = @_;
    my $email = $c->req->body_params->{email};
    if ( $c->req->param('delete') ) {
        $c->detach( 'delete', $email );
    }
    elsif ( $c->req->param('display') ) {
		$c->detach('display');
    }
    $c->stash->{'email'} = "$email";
    $c->stash->{'template'} = 'Employee_Form.tt';
}

=head2 manage_data

PARAMS :: NONE 

RETURNS :: NONE

=cut


sub manage_data :Local {
    my ( $self, $c ) = @_;
    if ( $c->req->param('save') ) {
        $c->detach('insert');
    }
    elsif ( $c->req->param('edit') ) {
        $c->detach('edit');
  }elsif( $c->req->param('cancel') ) {
        $c->stash->{'error'} = "** Cancelled  **";
         $c->stash->{'template'} = 'index.tt'; 
 }
}

=head2 edit

PARAMS :: name ,date_of_birth ,department ,date_of_joining ,salary ,email 

RETURNS :: NONE

=cut



sub edit : Private {
    my ( $self, $c ) = @_;
    my $email         = $c->req->params->{email};
    my $detail_rs     = $self->dbi_con->resultset('EmployeeDetail');
    my $detail_rs_obj = $detail_rs->search( { email => $email } );
 
    if ( $detail_rs_obj == 0 && $detail_rs_obj == "") {
		$c->stash->{'error'} = '********* Data Un-available *********';
        $c->stash->{'template'} = 'index.tt';
        return;
    }
    $detail_rs_obj->update(
        {
            name            => $c->req->body_params->{name},
            date_of_birth   => $c->req->body_params->{date_of_birth},
            department      => $c->req->body_params->{department},
            date_of_joining => $c->req->body_params->{date_of_joining},
            salary          => $c->req->body_params->{salary},
        }
    );
    $c->log->debug("******** Updated ********");
	$c->stash->{'error'} ='Success';
    $c->stash->{'template'} = 'index.tt';
}

=head2 insert

PARAMS :: email 

RETURNS :: NONE

=cut


sub delete : Private {
    my ( $self, $c, $email ) = @_;
    my $detail_rs = $self->dbi_con->resultset('EmployeeDetail');

    my $detail_rs_obj = $detail_rs->find(
        {
            email => $c->req->body_params->{email},
        }
    );
    unless ( defined $detail_rs_obj ) {
        $c->stash->{'template'} = 'index.tt';
        return;
    }
    $detail_rs_obj->delete;
    $c->log->debug("******* Deleted *******");
	$c->stash->{'error'} ='Success';
    $c->stash->{'template'} = 'index.tt';
}

=head2 display

PARAMS :: NONE

=cut

sub display : Private {
    my ( $self, $c ) = @_;
    my $detail_rs    = $self->dbi_con->resultset('EmployeeDetail')->search;
    my $emp_data;
    while ( my $employee = $detail_rs->next ) {
        push(
            @$emp_data,
            {
                name            => $employee->name,
                date_of_birth   => $employee->date_of_birth,
                department      => $employee->department,
                date_of_joining => $employee->date_of_joining,
                salary          => $employee->salary,
                email           => $employee->email
            }
        );
    }
    $c->stash(
        template => 'display/details.tt',
        result   => $emp_data
    );
}

=head2 default

Standard 404 error page

=cut

sub default : Path {
    my ( $self, $c ) = @_;
    $c->response->body('Page not found');
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {
    my ( $self, $c ) = @_;
    my @errors = @{ $c->error };
    if (@errors) {
        $c->res->status(500);
        $c->res->body('Internal Server Error');
        $c->clear_error;
    }
}

=head1 AUTHOR

Rohit,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
