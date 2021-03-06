package Employee::Details::Model::EmplyeeDB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

__PACKAGE__->config(
    schema_class => 'Employee::Details::Schema',
    
    connect_info => {
        dsn => 'dbi:Pg:dbname=employee',
        user => 'rohit',
        password => '12345',
    }
);

=head1 NAME

Employee::Details::Model::EmplyeeDB - Catalyst DBIC Schema Model

=head1 SYNOPSIS

See L<Employee::Details>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<Employee::Details::Schema>

=head1 GENERATED BY

Catalyst::Helper::Model::DBIC::Schema - 0.65

=head1 AUTHOR

Rohit

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


1;
