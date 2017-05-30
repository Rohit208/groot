use strict;
use warnings;

use Employee::Details;

my $app = Employee::Details->apply_default_middlewares(Employee::Details->psgi_app);
$app;

