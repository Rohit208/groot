use utf8;
package Employee::Details::Schema::Result::EmployeeDetail;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Employee::Details::Schema::Result::EmployeeDetail

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<EmployeeDetails>

=cut

__PACKAGE__->table('"EmployeeDetails"');

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: '"EmployeeDetails_id_seq"'

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 date_of_birth

  data_type: 'date'
  is_nullable: 0

=head2 department

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 date_of_joining

  data_type: 'date'
  is_nullable: 0

=head2 salary

  data_type: 'money'
  is_nullable: 0

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "\"EmployeeDetails_id_seq\"",
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "date_of_birth",
  { data_type => "date", is_nullable => 0 },
  "department",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "date_of_joining",
  { data_type => "date", is_nullable => 0 },
  "salary",
  { data_type => "money", is_nullable => 0 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);
__PACKAGE__->set_primary_key('id','email');

# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-05-27 17:23:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/wh19E0Whqv6i4gpcJeHDQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
