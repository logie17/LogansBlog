package Test::Models::Author;

use base Test::AbstractTest;
use strict;
use warnings;
use Test::More;
use Test::MockModule;

sub fixture: Test(setup)
{
    my ($self) = @_;

    require Models::Author;
    Models::DB->register_db(
        driver      => 'SQLite',
        database    => '../db/blog_test.db'
    );
}

sub  test_use_01 : Test(1)
{
    my ($self) = @_;
    print STDERR "HI";
    use_ok( 'Models::Author');
}

sub test_foo_02 : Test(1)
{
    my $obj = Models::Author->new;    
    is $obj->foo,'hi';
}


1;
