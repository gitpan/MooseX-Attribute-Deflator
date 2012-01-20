#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2012 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package Types;

use MooseX::Types -declare => ['MyHashRef'];
use MooseX::Types::Moose qw/HashRef/;
use MooseX::Attribute::Deflator;

use JSON;

subtype MyHashRef, 
	as HashRef;
	
deflate MyHashRef,
	via { encode_json($_) };


1;