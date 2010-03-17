package Test::Views::Default;

use base Test::AbstractTest;
use strict;
use warnings;
use Test::More;
use Test::MockClass;

sub  test_use_01 : Test(1)
{
    my ($self) = @_;
    use_ok( 'Views::Default');
}

sub test_run : Test(5)
{
    my ($self) = @_;

    my $mock_cgi_class = $self->setup_mock_cgi;

    my $mock_cgi_obj = CGI->new;

    use_ok( 'Views::Default');

    my $view_obj = Views::Default->new(cgi_obj => $mock_cgi_obj);
    
    isa_ok($view_obj, 'Views::Default', "Is the object View?");
    can_ok($view_obj, 'new');
    can_ok($view_obj, 'index');
    
    is ( ref $view_obj->index, '', "Should return a string");
}

1;
