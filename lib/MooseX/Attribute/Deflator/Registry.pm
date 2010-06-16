#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2010 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package MooseX::Attribute::Deflator::Registry;
BEGIN {
  $MooseX::Attribute::Deflator::Registry::VERSION = '1.101670';
}
# ABSTRACT: Registry class for attribute deflators
use Moose 1.01;

has deflators => ( 
	traits => ['Hash'],
	is => 'rw', 
	isa => 'HashRef[CodeRef]', 
	default    => sub { {} },
    handles    => { 
		has_deflator => 'get', 
		get_deflator => 'get', 
		set_deflator => 'set',
		add_deflator => 'set',
	}
);

has inflators => ( 
	traits => ['Hash'],
	is => 'rw', 
	isa => 'HashRef[CodeRef]', 
	default    => sub { {} },
    handles    => { 
		has_inflator => 'get', 
		get_inflator => 'get', 
		set_inflator => 'set',
		add_inflator => 'set',
	}
);

sub find_deflator {
    my ($self, $constraint) = @_;
    ( my $name = $constraint->name ) =~ s/\[.*\]/\[\]/;
    return $self->get_deflator($name) 
    || ( $constraint->has_parent 
          ? $self->set_deflator($name, $self->find_deflator($constraint->parent)) 
          : undef );
}


sub find_inflator {
    my ($self, $constraint) = @_;
    ( my $name = $constraint->name ) =~ s/\[.*\]/\[\]/;
    return $self->get_inflator($name) 
    || ( $constraint->has_parent 
          ? $self->set_inflator($name, $self->find_inflator($constraint->parent)) 
          : undef );
}

1;



=pod

=head1 NAME

MooseX::Attribute::Deflator::Registry - Registry class for attribute deflators

=head1 VERSION

version 1.101670

=head1 DESCRIPTION

This class contains a registry for deflator and inflator functions.

=head1 ATTRIBUTES

=over 4

=item B<< inflators ( isa => HashRef[CodeRef] ) >>

=item B<< deflators ( isa => HashRef[CodeRef] ) >>

=back

=head1 METHODS

=over 4

=item B<< add_inflator( $type_constraint, $coderef ) >>

=item B<< add_deflator( $type_constraint, $coderef ) >>

=item B<< set_inflator( $type_constraint, $coderef ) >>

=item B<< set_deflator( $type_constraint, $coderef ) >>

Add a inflator/deflator function for C<$type_constraint>. Existing functions
are overwritten.

=item B<< has_inflator( $type_constraint ) >>

=item B<< has_deflator( $type_constraint )  >>

Predicate methods.

=item B<< find_inflator( $type_constraint ) >>

=item B<< find_deflator( $type_constraint )  >>

Finds a suitable deflator/inflator by bubbling up the type hierarchy.

=back

=head1 AUTHOR

Moritz Onken

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2010 by Moritz Onken.

This is free software, licensed under:

  The (three-clause) BSD License

=cut


__END__

