#! /usr/local/bin/perl

use Test::More tests => 5;
use Test::MockClass;

use lib '../lib/';

#-------------------------------------------
# SETUP
#-------------------------------------------

my $mock_controller = Test::MockClass->new('Controllers::Default');
my $mock_view       = Test::MockClass->new('Views::Default');

$mock_controller->defaultConstructor;
$mock_controller->addMethod('default' =>sub{return 'foo' });

$mock_view->defaultConstructor;
$mock_view->addMethod('output' =>sub{return 'bar'});


#-------------------------------------------
# TESTS
#-------------------------------------------

BEGIN { use_ok( 'Director', "Can we use Director?" ); }
my $director_obj = Director->new;

isa_ok($director_obj, 'Director', "Is the object Director?");
can_ok($director_obj, 'new');
can_ok($director_obj, 'run');

my $results = $director_obj->run;
$results =~ s/[\n|\r|\s]//g;

my $control = 'Content-Type:text/html;charset=ISO-8859-1bar';

is ($results, $control, "Do results match control?");

