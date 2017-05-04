#! usr/bin/perl;
use strict;
use warnings;

use Data::Dumper;
use April11::OOPs;

my $shopper = April11::OOPs->new(
    {
        name   => 'Robin',
        budget => '200',
    }
);

$shopper->buy( 'beer', ('coffee') x 2, ('ravioli') x 2, 'beer', );

print $shopper->get_invoice;
