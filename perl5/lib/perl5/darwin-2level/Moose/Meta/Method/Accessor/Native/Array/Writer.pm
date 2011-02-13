#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package Moose::Meta::Method::Accessor::Native::Array::Writer;
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Array::Writer::AUTHORITY = 'cpan:STEVAN';
}
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Array::Writer::VERSION = '1.9902'; # TRIAL
}

use strict;
use warnings;

use Moose::Role;

with 'Moose::Meta::Method::Accessor::Native::Writer' => {
        -excludes => ['_inline_coerce_new_values'],
    },
    'Moose::Meta::Method::Accessor::Native::Array',
    'Moose::Meta::Method::Accessor::Native::Collection';

sub _new_members { '@_' }

sub _copy_old_value {
    my $self = shift;
    my ($slot_access) = @_;

    return '[ @{(' . $slot_access . ')} ]';
}

1;
