#
# This file is part of MooseX-Attribute-Deflator
#
# This software is Copyright (c) 2011 by Moritz Onken.
#
# This is free software, licensed under:
#
#   The (three-clause) BSD License
#

package Class::MOP::Module;
BEGIN {
  $Class::MOP::Module::AUTHORITY = 'cpan:STEVAN';
}
BEGIN {
  $Class::MOP::Module::VERSION = '1.9902'; # TRIAL
}

use strict;
use warnings;

use Carp         'confess';
use Scalar::Util 'blessed';

use base 'Class::MOP::Package';

sub _new {
    my $class = shift;
    return Class::MOP::Class->initialize($class)->new_object(@_)
        if $class ne __PACKAGE__;

    my $params = @_ == 1 ? $_[0] : {@_};
    return bless {
        # Need to quote package to avoid a problem with PPI mis-parsing this
        # as a package statement.

        # from Class::MOP::Package
        'package' => $params->{package},
        namespace => \undef,

        # attributes
        version   => \undef,
        authority => \undef
    } => $class;
}

sub version {  
    my $self = shift;
    ${$self->get_or_add_package_symbol('$VERSION')};
}

sub authority {  
    my $self = shift;
    ${$self->get_or_add_package_symbol('$AUTHORITY')};
}

sub identifier {
    my $self = shift;
    join '-' => (
        $self->name,
        ($self->version   || ()),
        ($self->authority || ()),
    );
}

sub create {
    confess "The Class::MOP::Module->create method has been made a private object method.\n";
}

sub _instantiate_module {
    my($self, $version, $authority) = @_;
    my $package_name = $self->name;

    Class::MOP::_is_valid_class_name($package_name)
        || confess "creation of $package_name failed: invalid package name";

    no strict 'refs';
    scalar %{ $package_name . '::' };    # touch the stash
    ${ $package_name . '::VERSION' }   = $version   if defined $version;
    ${ $package_name . '::AUTHORITY' } = $authority if defined $authority;

    return;
}

1;

# ABSTRACT: Module Meta Object



=pod

=head1 NAME

Class::MOP::Module - Module Meta Object

=head1 VERSION

version 1.9902

=head1 DESCRIPTION

A module is essentially a L<Class::MOP::Package> with metadata, in our
case the version and authority.

=head1 NAME 

Class::MOP::Module - Module Meta Object

=head1 INHERITANCE

B<Class::MOP::Module> is a subclass of L<Class::MOP::Package>.

=head1 METHODS

=over 4

=item B<< $metamodule->version >>

This is a read-only attribute which returns the C<$VERSION> of the
package, if one exists.

=item B<< $metamodule->authority >>

This is a read-only attribute which returns the C<$AUTHORITY> of the
package, if one exists.

=item B<< $metamodule->identifier >>

This constructs a string which combines the name, version and
authority.

=item B<< Class::MOP::Module->meta >>

This will return a L<Class::MOP::Class> instance for this class.

=back

=head1 AUTHOR

Stevan Little <stevan@iinteractive.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Infinity Interactive, Inc..

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

