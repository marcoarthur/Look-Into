# NAME

Look::Into - Just look into a class to have a view of its parents, methods and
attributes.

# SYNOPSIS

    use Look::Into;
    my $l = Look::Into->new;
    $l->this('Mojo::UserAgent');
    $l->draw; # will draw a picture showing class public methods.
    # OR
    my $l = Look::Into->new( classes => [ qw( DBD::Pg DBD::SQLite ) ] );
    $l->draw;
    $ OR
    Look::Into->new( classes => [ qw( DBD::Pg DBD::SQLite ) ] )->draw;

# DESCRIPTION

Look::Into to be used when you want to poke into a class fast and shallow drawing 
it optionally.

# AUTHOR

Marco Arthur <arthurpbs@gmail.com>

# COPYRIGHT

Copyright 2020- Marco Arthur

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO
