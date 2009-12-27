#! /usr/local/bin/perl

use Test::More tests => 5;
use lib '../lib/';

#-------------------------------------------
# SETUP
#-------------------------------------------

#-------------------------------------------
# TESTS
#-------------------------------------------

BEGIN { use_ok( 'Views::Default', "Can we use Views::Default?" ); }

my $views_obj = Views::Default->new;

isa_ok($views_obj, 'Views::Default', "Is the object View?");
can_ok($view_obj, 'new');
can_ok($view_obj, 'default');

is ( ref $view_obj->default, 'HASH', "Should return a hash");
