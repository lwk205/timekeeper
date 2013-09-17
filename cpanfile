requires 'perl', '5.008001';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

requires 'Mojolicious::Lite';
requires 'Plack';
requires 'Plack::Builder';
requires 'Starman';