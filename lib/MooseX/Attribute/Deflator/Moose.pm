# 
# This file is part of MooseX-Attribute-Deflator
# 
# This software is Copyright (c) 2010 by Moritz Onken.
# 
# This is free software, licensed under:
# 
#   The (three-clause) BSD License
# 
package MooseX::Attribute::Deflator::Moose;
BEGIN {
  $MooseX::Attribute::Deflator::Moose::VERSION = '1.100990';
}
# ABSTRACT: Deflators for Moose type constraints

use MooseX::Attribute::Deflator;
use JSON;


deflate 'HashRef', via { JSON::encode_json($_) };
inflate 'HashRef', via { JSON::decode_json($_) };

deflate 'ArrayRef', via { JSON::encode_json($_) };
inflate 'ArrayRef', via { JSON::decode_json($_) };

deflate 'ScalarRef', via { $$_ };
inflate 'ScalarRef', via { \$_ };

deflate 'Item', via { $_ };
inflate 'Item', via { $_ };

deflate 'HashRef[]', via {
    my ($obj, $constraint, $deflate) = @_;
    my $value = {%$_};
    while(my($k,$v) = each %$value) {
        $value->{$k} = $deflate->($value->{$k}, $constraint->type_parameter);
    }
    return $deflate->($value, $constraint->parent);
};

inflate 'HashRef[]', via {
    my ($obj, $constraint, $inflate) = @_;
    my $value = $inflate->($_, $constraint->parent);
    while(my($k,$v) = each %$value) {
        $value->{$k} = $inflate->($value->{$k}, $constraint->type_parameter);
    }
    return $value;
};

deflate 'ArrayRef[]', via {
    my ($obj, $constraint, $deflate) = @_;
    my $value = [@$_];
    $_ = $deflate->($_, $constraint->type_parameter) for(@$value);
    return $deflate->($value, $constraint->parent);
};

inflate 'ArrayRef[]', via {
    my ($obj, $constraint, $inflate) = @_;
    my $value = $inflate->($_, $constraint->parent);
    $_ = $inflate->($_, $constraint->type_parameter) for(@$value);
    return $value;
};

deflate 'Maybe[]', via {
    my ($obj, $constraint, $deflate) = @_;
    return $deflate->($_, $constraint->type_parameter);
};

inflate 'Maybe[]', via {
    my ($obj, $constraint, $inflate) = @_;
    return $inflate->($_, $constraint->type_parameter);
};

1;



=pod

=head1 NAME

MooseX::Attribute::Deflator::Moose - Deflators for Moose type constraints

=head1 VERSION

version 1.100990

=head1 SYNOPSIS

  use MooseX::Attribute::Deflator::Moose;

=head1 DESCRIPTION

Using this module registers sane type deflators and inflators for Moose's built in types.

Some notes:

=over

=item * HashRef and ArrayRef deflate/inflate using JSON

=item * ScalarRef is dereferenced on deflation and returns a reference on inflation

=back

=head1 AUTHOR

  Moritz Onken

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Moritz Onken.

This is free software, licensed under:

  The (three-clause) BSD License

=cut


__END__

