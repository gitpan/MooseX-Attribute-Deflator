#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#
package MooseX::Attribute::Deflator::Meta::Role::Attribute;
BEGIN {
  $MooseX::Attribute::Deflator::Meta::Role::Attribute::VERSION = '1.130001';
}

# ABSTRACT: Attribute meta role to support deflation
use Moose::Role;
use strict;
use warnings;
use MooseX::Attribute::Deflator;
my $REGISTRY = MooseX::Attribute::Deflator->get_registry;
no MooseX::Attribute::Deflator;

sub deflate {
    my ( $self, $obj, $value, $constraint, @rest ) = @_;
    $value ||= $self->get_value($obj)
      if ( $self->has_value($obj) || $self->is_required );
    return undef unless ( defined $value );
    $constraint ||= $self->type_constraint;
    Moose->throw_error( "Cannot deflate " . $self->name )
      unless ( my $via = $REGISTRY->find_deflator($constraint) );
    return
      $via->( $self, $constraint, sub { $self->deflate( $obj, @_ ) },
              $obj, @rest
      ) for ($value);
}

sub inflate {
    my ( $self, $obj, $value, $constraint, @rest ) = @_;
    return undef unless ( defined $value );
    $constraint ||= $self->type_constraint;
    Moose->throw_error( "Cannot inflate " . $self->name )
      unless ( my $via = $REGISTRY->find_inflator($constraint) );
    return
      $via->( $self, $constraint, sub { $self->inflate( $obj, @_ ) },
              $obj, @rest
      ) for ($value);
}

sub has_deflator {
    my $self = shift;
    return unless ( $self->has_type_constraint );
    $REGISTRY->get_deflator( $self->type_constraint->name );
}

sub has_inflator {
    my $self = shift;
    return unless ( $self->has_type_constraint );
    $REGISTRY->get_inflator( $self->type_constraint->name );
}

1;



=pod

=head1 NAME

MooseX::Attribute::Deflator::Meta::Role::Attribute - Attribute meta role to support deflation

=head1 VERSION

version 1.130001

=head1 SYNOPSIS

  package Test;

  use Moose;
  use DateTime;

  use MooseX::Attribute::Deflator;

  deflate 'DateTime', via { $_->epoch };
  inflate 'DateTime', via { DateTime->from_epoch( epoch => $_ ) };

  no MooseX::Attribute::Deflator;

  has now => ( is => 'rw', 
               isa => 'DateTime', 
               required => 1, 
               default => sub { DateTime->now }, 
               traits => ['Deflator'] );

  package main;
  
  my $obj = Test->new;
  my $attr = $obj->meta->get_attribute('now');
  
  my $deflated = $attr->deflate($obj);
  # $deflated is now a number
  
  my inflated = $attr->inflate($obj, $deflated);
  # $inflated is now a DateTime object

=head1 METHODS

These two methods work basically the same. They look up the type constraint 
which is associated with the attribute and try to find an appropriate
deflator/inflator. If there is no deflator/inflator for the exact type
constraint, the method will bubble up the type constraint hierarchy
until it finds one.

=over 4

=item B<< $attr->deflate($instance) >>

Returns the deflated value of the attribute. It does not change the value
of the attribute.

=item B<< $attr->inflate($instance, $string) >>

Inflates a string C<$string>. This method does not set the value of
the attribute to the inflated value.

=item B<< $attr->has_inflator >>
=item B<< $attr->has_deflator >>

=back

=head1 AUTHOR

Moritz Onken

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Moritz Onken.

This is free software, licensed under:

  The (three-clause) BSD License

=cut


__END__

