package Views::Admin;
use base Views::AbstractView;

#-------------------------------------------
# CONSTANTS
#-------------------------------------------

#-------------------------------------------
# ACTIONS
#-------------------------------------------

sub admintools
# Purpose:  Admin tools view, only if logged in
# Input:    1. Ref to self
# Output:   1. HTML
{
    my ( $self) = @_;

    if ( $self->logged_in )
    {
        return 'Welcome to admin tools';
    }
    
}

sub index
# Purpose:  Index View
# Input:    1. Ref to self
# Output:   1. HTML
{
    my ($self) = @_;
    my $data_hr = $self->{data_stack};

    my $url = 'http://www.loganbell.org/pages/admin/login/';


    my $return_html = qq~
        <form id="login" action="$url" method="post">
            <input type="text" name="username" value="Username"/>
            <input type="password" name="password" value=""/>
            <input type="hidden" name="view" value="admin"/>
            <input type="hidden" name="action" value="login"/>
            <input type="submit" name="login" value="Login"/>
        </form>
    ~;

    return $return_html;
}

sub login
# Purpose:  Login View
# Input:    1. Ref to self
# Output:   1. HTML
{

    my ($self ) = @_;
    my $data_hr = $self->{data_stack};

    my $return_html;
    
    $return_html = $data_hr->{first_name};

    return $return_html;
}


#-------------------------------------------
# OTHER METHODS
#-------------------------------------------

sub _generate_errors
# Purpose:  Helper method to format errors
# Input:    1. Ref to self
# Output:   1. HTML
{
    my ( $self) = @_;

    if ( my @errors = @_ )
    {
        $return_html .= join "<br/>", @errors;
    }
}


1;
