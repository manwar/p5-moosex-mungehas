use Test::More tests => 3;

use Test::Requires "Moo";

use strict;
use warnings;

subtest $_, \&test_lazy, $_ for qw/ Moo Moose Mouse /;

sub test_lazy {
    my $class = shift;

    plan skip_all => "$class not installed" unless eval "use $class; 1";

    eval q!
        package Foo;

        use Moo;
        use MooseX::MungeHas;

        has bar => (
            is   => 'ro',
            lazy => sub { 'got it' },
        );
    !;

    is Foo->new->bar => 'got it', 'lazy attribute works'; 
}

