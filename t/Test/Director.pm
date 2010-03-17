package Test::Director;

use base Test::AbstractTest;
use strict;
use warnings;
use Test::More;
use Test::MockClass;

sub  test_use_01 : Test(1)
{
    my ($self) = @_;
    use_ok( 'Director');
}

sub test_run : Test(5)
{
    my ($self) = @_;

    my ($mock_session_class, $mock_controller_class, $mock_view_class) = $self->setup_mocks;

    use_ok( 'Director');
    my $director_obj = Director->new(lib_path => '../lib/');
    
    isa_ok($director_obj, 'Director', "Is the object Director?");
    can_ok($director_obj, 'new');
    can_ok($director_obj, 'run');
    
    my $results = $self->normalize($director_obj->run);
    
    my $control = 'MOCKSESSIONHEADERbar';
    
    is ($results, $control, "Do results match control?");

}

sub setup_mocks
{
    my ($self) = @_;

    my $mock_session_class = $self->setup_mock_session;

    my $mock_controller_class = Test::MockClass->new('Controllers::Default');
    my $mock_view_class       = Test::MockClass->new('Views::Default');
    
    $mock_controller_class->defaultConstructor;
    $mock_controller_class->addMethod('default' =>sub{return 'foo' });
    
    $mock_view_class->defaultConstructor;
    $mock_view_class->addMethod('output' =>sub{return 'bar'});

    return ($mock_session_class, $mock_controller_class, $mock_view_class);

}


1;
