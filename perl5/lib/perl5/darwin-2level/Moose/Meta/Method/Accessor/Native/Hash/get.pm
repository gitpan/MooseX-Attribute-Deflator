#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package Moose::Meta::Method::Accessor::Native::Hash::get;
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Hash::get::AUTHORITY = 'cpan:STEVAN';
}
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Hash::get::VERSION = '1.9902'; # TRIAL
}

use strict;
use warnings;

use Scalar::Util qw( looks_like_number );

use Moose::Role;

with 'Moose::Meta::Method::Accessor::Native::Reader' => {
    -excludes => [
        qw(
            _minimum_arguments
            _inline_check_arguments
            )
    ],
    },
    'Moose::Meta::Method::Accessor::Native::Hash';

sub _minimum_arguments { 1 }

sub _inline_check_arguments {
    my $self = shift;

    return (
        'for (@_) {',
            $self->_inline_check_var_is_valid_key('$_'),
        '}',
    );
}

sub _return_value {
    my $self = shift;
    my ($slot_access) = @_;

    return '@_ > 1 '
             . '? @{ (' . $slot_access . ') }{@_} '
             . ': ' . $slot_access . '->{$_[0]}';
}

no Moose::Role;

1;
