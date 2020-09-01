package Look::Into::Drawer::Nomnoml;

use Moo;
use Mojo::Base -signatures;

with qw( Look::Into::Drawer );

sub draw_class ( $self, $class, $metaclass ) {
    my @methods = sort map { $_->name . "()" } $metaclass->get_all_methods;

    if ( $self->only_public ) {
        @methods = grep { $_ =~ /^[^_]/ } @methods;
    }

    my $mlist = join ';', @methods;

    my $noml = <<~EOT;
    [ $class | $mlist ]
    EOT

    return $noml;
}

1;

__END__

=encoding utf-8

=head1 NAME

Look::Into::Drawer::Nomnoml - drawer for Look::Into

=head1 SYNOPSYS

 use Look::Into::Drawer::Nomnoml;

=head1 DESCRIPTION

Draws using syntax language for Nomnoml

=cut

