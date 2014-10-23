# 
# This file is part of MooseX-Attribute-Deflator
# 
# This software is Copyright (c) 2010 by Moritz Onken.
# 
# This is free software, licensed under:
# 
#   The (three-clause) BSD License
# 
package MooseX::Attribute::Deflator::Structured;
BEGIN {
  $MooseX::Attribute::Deflator::Structured::VERSION = '1.100990';
}
# ABSTRACT: Deflators for MooseX::Types::Structured


use MooseX::Attribute::Deflator;

deflate 'MooseX::Types::Structured::Optional[]', via {
    my ($obj, $constraint, $deflate) = @_;
    return $deflate->($_, $constraint->type_parameter);
};

inflate 'MooseX::Types::Structured::Optional[]', via {
    my ($obj, $constraint, $inflate) = @_;
    return $inflate->($_, $constraint->type_parameter);
};

deflate 'MooseX::Types::Structured::Map[]', via {
    my ($obj, $constraint, $deflate) = @_;
    my $value = {%$_};
    my $constraints = $constraint->type_constraints;
    while(my($k,$v) = each %$value) {
        $value->{$k} = $deflate->($value->{$k}, $constraints->[1]);
    }
    return $deflate->($value, $constraint->parent);
};

inflate 'MooseX::Types::Structured::Map[]', via {
    my ($obj, $constraint, $inflate) = @_;
    my $value = $inflate->($_, $constraint->parent);
    my $constraints = $constraint->type_constraints;
    while(my($k,$v) = each %$value) {
        $value->{$k} = $inflate->($value->{$k}, $constraints->[1]);
    }
    return $value;
};

deflate 'MooseX::Types::Structured::Dict[]', via {
    my ($obj, $constraint, $deflate) = @_;
    my %constraints = @{$constraint->type_constraints};
    my $value = {%$_};
    while(my($k,$v) = each %$value) {
        $value->{$k} = $deflate->($value->{$k}, $constraints{$k});
    }
    return $deflate->($value, $constraint->parent);
};

inflate 'MooseX::Types::Structured::Dict[]', via {
    my ($obj, $constraint, $inflate) = @_;
    my %constraints = @{$constraint->type_constraints};
    my $value = $inflate->($_, $constraint->parent);
    while(my($k,$v) = each %$value) {
        $value->{$k} = $inflate->($value->{$k}, $constraints{$k});
    }
    return $value;
};

deflate 'MooseX::Types::Structured::Tuple[]', via {
    my ($obj, $constraint, $deflate) = @_;
    my @constraints = @{$constraint->type_constraints};
    my $value = [@$_];
    for(my $i = 0; $i < @$value; $i++) {
        $value->[$i] = $deflate->($value->[$i], $constraints[$i] || $constraints[-1]);
    }
    return $deflate->($value, $constraint->parent);
};

inflate 'MooseX::Types::Structured::Tuple[]', via {
    my ($obj, $constraint, $inflate) = @_;
    my @constraints = @{$constraint->type_constraints};
    my $value = $inflate->($_, $constraint->parent);
    for(my $i = 0; $i < @$value; $i++) {
        $value->[$i] = $inflate->($value->[$i], $constraints[$i] || $constraints[-1]);
    }
    return $value;
};

1;



=pod

=head1 NAME

MooseX::Attribute::Deflator::Structured - Deflators for MooseX::Types::Structured

=head1 VERSION

version 1.100990

=head1 SYNOPSIS

  use MooseX::Attribute::Deflator::Structured;

=head1 DESCRIPTION

Using this module registers sane type deflators and inflators for L<MooseX::Types::Structured>.

=head1 AUTHOR

  Moritz Onken

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Moritz Onken.

This is free software, licensed under:

  The (three-clause) BSD License

=cut


__END__

