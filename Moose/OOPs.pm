#!/usr/bin/perl -w

#
# OOPs.pl
#
# Developed by Rohit Rehni <Rohit@exceleron.com>
# Copyright (c) 2017 Exceleron Software, LLC
# All rights reserved.
#
# Changelog:
# 2017-05-03 - created
#

package April11::OOPs;

use strict;
use warnings;
use diagnostics;

use Carp qw/croak carp/;
use Scalar::Util 'looks_like_number';

#our $VERSION ='0.01';

sub new {
    my ( $class, $arg_for ) = @_;
    my $self = bless {}, $class;
    $self->initialize($arg_for);
    return $self;
}

sub initialize {
    my ( $self, $arg_for ) = @_;
    my %arg_for = %$arg_for;
    my $class   = ref $self;
    $self->{purchased_items} = [];
    $self->{money_spent}     = 0;
    my $name = delete $arg_for{name};
    unless ( defined $name ) {
        croak("$class required a name to be set");
    }
    $self->set_budget( delete $arg_for{budget} );
    $self->{attributes}{name} = $name;
    if ( my $remaining = join ', ', keys %arg_for ) {
        croak("Unknown keys to $class \::new: $remaining ");
    }
}

sub get_name {
    my $self = shift;
    return $self->{attributes}{name};
}

sub set_budget {
    my ( $self, $budget ) = @_;
    unless ( looks_like_number($budget) && $budget > 0 ) {
        croak("Budget must be a number greater than zero\n");
    }
    $self->{attributes}{budget} = $budget;
}

sub get_budget {
    my $self = shift;
    return $self->{attributes}{budget};
}

sub buy {
    my ( $self, @list_of_things ) = @_;
    my $remaining_budget = $self->get_budget;
    my $name             = $self->get_name;
    foreach my $item (@list_of_things) {
        my $cost = $self->find_cost_of($item);
        if ( not defined $cost ) {
            carp("$name doesn't know how to buy '$item'");
        }
        elsif ( $cost > $remaining_budget ) {
            carp("$name doesn't have enough money buy '$item'");
        }
        else {
            $remaining_budget -= $cost;
            $self->buy_item($item);
        }
    }
}

sub buy_item {
    my ( $self, $item ) = @_;
    $self->{money_spent} += $self->find_cost_of($item);
    push @{ $self->{purchased_items} }, $item;
}

sub find_cost_of {
    my ( $class, $item ) = @_;
    my %price_of = (
        beer    => 75,
        coffee  => 10,
        ravioli => 15,
    );
  return $price_of{$item};
}

sub get_invoice {
    my $self        = shift;
    my @items       = $self->_purchased_items;
    my $money_spent = $self->_money_spent;
    my $shopper     = $self->get_name;
    my $date        = localtime;
    unless (@items) {
        return "no Items purchased";
    }

    my $invoice = <<"END_HEADER";
 Date :   $date
 shopper: $shopper
 Items    Cost
END_HEADER

    foreach my $item (@items) {
        $invoice .= sprintf "10%s %0.2f\n", $item, $self->find_cost_of($item);
    }
    $invoice .= "\n Total + 10% : $money_spent\n";
    return $invoice;
}

sub _purchased_items {
    @{ shift->{purchased_items} };
}

sub _money_spent {
    my $self = shift;
    return $self->{money_spent} * 1.10;
}

1;
