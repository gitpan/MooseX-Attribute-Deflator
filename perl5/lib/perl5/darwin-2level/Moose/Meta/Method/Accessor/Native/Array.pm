#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package Moose::Meta::Method::Accessor::Native::Array;
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Array::AUTHORITY = 'cpan:STEVAN';
}
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Array::VERSION = '1.9902'; # TRIAL
}

use strict;
use warnings;

use Moose::Role;

use Scalar::Util qw( looks_like_number );

sub _inline_check_var_is_valid_index {
    my $self = shift;
    my ($var) = @_;

    return (
        'if (!defined(' . $var . ') || ' . $var . ' !~ /^-?\d+$/) {',
            $self->_inline_throw_error(
                '"The index passed to ' . $self->delegate_to_method
              . ' must be an integer"',
            ) . ';',
        '}',
    );
}

no Moose::Role;

1;
