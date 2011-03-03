package Test::Models::Default;

use base Test::AbstractTest;
use strict;
use warnings;
use Test::More;
use Test::MockClass;

sub  test_use_01 : Test(1)
{
    my ($self) = @_;
    use_ok( 'Controllers::Default');
}

sub test_run : Test(5)
{
    my ($self) = @_;

    my $mock_cgi_class = $self->setup_mock_cgi;

    my $mock_cgi_obj = CGI->new;

    use_ok( 'Controllers::Default');

    my $controller_obj = Controllers::Default->new(cgi_obj => $mock_cgi_obj);
    
    isa_ok($controller_obj, 'Controllers::Default', "Is the object Controller?");
    can_ok($controller_obj, 'new');
    can_ok($controller_obj, 'index');
    
    is ( ref $controller_obj->index, 'HASH', "Should return a hash");
}

1;
