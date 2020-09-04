requires 'List::Util';
requires 'Mojo::Base';
requires 'Mojo::Loader';
requires 'Moo';
requires 'Moo::Role';
requires 'Moose';
requires 'namespace::autoclean';
requires 'perl', '5.028';

on configure => sub {
    requires 'Module::Build::Tiny', '0.034';
};

on test => sub {
    requires 'Test::More';
};


