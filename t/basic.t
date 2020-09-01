use strict;
use Test::More;
use Look::Into;

#Look::Into->new( classes => ['Mojo::UserAgent'] )->draw;

# replace with the actual test
my $l = Look::Into->new;
$l->this('Mojo::UserAgent');

ok 1;

done_testing;
