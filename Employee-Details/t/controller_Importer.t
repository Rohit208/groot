use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Employee::Details';
use Employee::Details::Controller::Importer;

ok( request('/importer')->is_success, 'Request should succeed' );
done_testing();
