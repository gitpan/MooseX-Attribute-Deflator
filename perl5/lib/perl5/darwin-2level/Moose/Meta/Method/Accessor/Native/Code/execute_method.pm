#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package Moose::Meta::Method::Accessor::Native::Code::execute_method;
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Code::execute_method::AUTHORITY = 'cpan:STEVAN';
}
BEGIN {
  $Moose::Meta::Method::Accessor::Native::Code::execute_method::VERSION = '1.9902'; # TRIAL
}

use strict;
use warnings;

use Moose::Role;

with 'Moose::Meta::Method::Accessor::Native::Reader';

sub _return_value {
    my $self = shift;
    my ($slot_access) = @_;

    return $slot_access . '->($self, @_)';
}

no Moose::Role;

1;
