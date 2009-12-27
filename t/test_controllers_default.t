#! /usr/local/bin/perl

use Test::More tests => 5;
use lib '../lib/';

#-------------------------------------------
# SETUP
#-------------------------------------------

#-------------------------------------------
# TESTS
#-------------------------------------------

BEGIN { use_ok( 'Controllers::Default', "Can we use Controllers::Default?" ); }

my $controller_obj = Controllers::Default->new;

isa_ok($controller_obj, 'Controllers::Default', "Is the object Controller?");
can_ok($controller_obj, 'new');
can_ok($controller_obj, 'default');

is ( ref $controller_obj->default, 'HASH', "Should return a hash");
