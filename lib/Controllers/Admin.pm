package Controllers::Admin;

use base Controllers::AbstractController;
use Models::Authors;
use Digest::MD5 qw(md5_hex);

sub login
# Purpose:  Controller method to log an author/user in
# Input:    1. A reference to self 
# Output:   1. A data hr
{
    my ($self) = @_;

    my $cgi_obj             = $self->{cgi_obj};
    my $session_obj         = $self->{session_obj};

    my $username            = $cgi_obj->param("username");
    my $password            = $cgi_obj->param("password");
    my $missing_credentials = 0;
    my $data_stack  = {};

    if ( !$username )
    {
       push @{$data_stack->{error_messages}}, 'Please supply a username';
        $missing_credentials = 1;
    }

    if ( !$password )
    {
        push @{$data_stack->{error_messages}}, 'Please supply a password';
        $missing_credentials = 1;
    }

    if ($missing_credentials)
    {
        $self->action('index');
        return $data_stack;
    }

    if ( my $user_obj = Models::Authors->get_authors( query => [ 'username' => $username ] )->[0] )
    {
        if ( md5_hex($password) eq $user_obj->password )
        {
            $session_obj->param("first_name", $user_obj->first_name);
            $data_stack = { first_name => $user_obj->first_name };
        }
        else
        {
            push @{$data_stack->{error_messages}}, "Incorrect password";
        }
    }
    else
    {
        push @{$data_stack->{error_messages}}, "Invalid username";
    }
     
    return $data_stack;
}

1;
