package Test::AbstractTest;
use base Test::Class;

use Test::MockModule;

Test::AbstractTest->SKIP_CLASS( 1 );

sub setup_mock_session
{
    my ($self, %params) = @_;

    my $session_id = $params{session_id};

    $session_obj = Test::MockModule->new('CGI::Session');

    
    $session_obj->mock('header' => sub { return 'MOCK SESSION HEADER' } );

    return $session_obj;
    
}

sub setup_mock_cgi
{
    my ($self, %params) = @_;

    my $mock_cgi_class = Test::MockModule->new('CGI');

    return $mock_cgi_class;
}

sub normalize
{
    my ($self, $result) = @_;

    $result =~ s/[\n|\r|\s]//g;
    return $result;
}

1;
