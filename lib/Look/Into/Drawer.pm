package Look::Into::Drawer;

use Moo::Role;
use Carp;

requires qw( draw_class );

has classes => (
    is       => 'ro',
    required => 1,
);

has only_public => (
    is       => 'ro',
    required => 1,
    default  => sub { 1 },
);

sub draw {
    my ( $self, $class ) = @_;
    return unless $self->classes;

    # Got a single class to draw
    if ($class) {
        croak qq{ You need first ask Look::Into->this($class) } unless $self->classes->{$class};
        return $self->draw_class( $class, $self->classes->{$class} );
    }

    # Draw all classes
    my @draws;
    for my $class ( keys %{ $self->classes } ) {
        push @draws, $self->draw_class( $class, $self->classes->{$class} );
    }

    return wantarray ? @draws : join( "\n", @draws );
}

1;

__END__

=encoding utf-8

=head1 NAME

Look::Into::Drawer - the base drawer for Look::Into

=head1 SYNOPSYS

  use Look::Into::Drawer;

=head1 DESCRIPTION

Base drawer to Look::Into module. serves to render the information collected 
for the class

=cut

