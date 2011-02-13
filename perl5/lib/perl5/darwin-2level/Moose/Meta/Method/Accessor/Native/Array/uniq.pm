#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package Moose::Meta::Method::Accessor::Native::Array::uniq;
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Array::uniq::AUTHORITY = 'cpan:STEVAN';
}
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Array::uniq::VERSION = '1.9902'; # TRIAL
}

use strict;
use warnings;

use List::MoreUtils ();

use Moose::Role;

with 'Moose::Meta::Method::Accessor::Native::Reader' =>
    { -excludes => ['_maximum_arguments'] };

sub _maximum_arguments { 0 }

sub _return_value {
    my $self = shift;
    my ($slot_access) = @_;

    return 'List::MoreUtils::uniq @{ (' . $slot_access . ') }';
}

no Moose::Role;

1;
