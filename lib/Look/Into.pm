package Look::Into;

use Moose;
use 5.028;
use Mojo::Base -signatures;
use Mojo::Loader qw(load_class);
use Carp;
use namespace::autoclean;

our $VERSION = '0.01';

has _loaded => (
    is      => 'ro',
    isa     => 'HashRef',
    default => sub { +{} },
);

has _drawer => (
    is      => 'ro',
    does    => 'Look::Into::Drawer',
    lazy    => 1,
    builder => '_build_drawer',
    handles => [qw( draw )],
);

has default_drawer_module => (
    is      => 'ro',
    isa     => 'Str',
    default => sub { 'Look::Into::Drawer::Nomnoml' }
);

has classes => (
    is      => 'ro',
    isa     => 'ArrayRef',
    default => sub { [] },
);

sub BUILD {
    my $self = shift;

    $self->this($_) for $self->classes->@*;
}

sub this ( $self, $class_or_obj ) {
    $self->_load($class_or_obj);
    my $class = ref $class_or_obj ? ref $class_or_obj : $class_or_obj;
    push @{ $self->classes }, $class;
    $self;
}

sub _load ( $self, $class ) {
    return $self->_loaded->{$class} if $self->_loaded->{$class};

    # Try to load the class
    if ( !ref $class ) {
        my $e = load_class($class);
        croak qq{ Failed loading $class } if $e;
    } else {
        $class = ref $class;
    }

    return $self->_loaded->{$class} = Class::MOP::Class->initialize($class);
}

sub _build_drawer( $self ) {
    my $e = load_class( $self->default_drawer_module );
    croak qq{ Couldn't load drawer } if $e;

    $self->default_drawer_module->new( classes => $self->_loaded );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=encoding utf-8

=head1 NAME

Look::Into - Just look into a class to have a view of its parents, methods and
attributes.

=head1 SYNOPSIS

  use Look::Into;
  my $l = Look::Into->new;
  $l->this('Mojo::UserAgent');
  $l->draw; # will draw a picture showing class public methods.
  # OR
  my $l = Look::Into->new( classes => [ qw( DBD::Pg DBD::SQLite ) ] );
  $l->draw;


=head1 DESCRIPTION

Look::Into to be used when you want to poke into a class fast and shallow drawing 
it optionally.

=head1 AUTHOR

Marco Arthur E<lt>arthurpbs@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2020- Marco Arthur

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

=cut
