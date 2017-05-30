use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Employee::Details';
use Employee::Details::Controller::Parser;

ok( request('/parser')->is_success, 'Request should succeed' );
done_testing();
