use strict;
use Test::More;
use Look::Into;

#Look::Into->new( classes => ['Mojo::UserAgent'] )->draw;

# replace with the actual test
my $l = Look::Into->new;
isa_ok $l, 'Look::Into';
can_ok $l, qw(this draw);
like $l->this('Mojo::UserAgent')->draw, qr/^\s*\[/, "Drawn";

done_testing;
