package Views::Admin;
use base Views::AbstractView;

sub index
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

sub generate_errors
{
    my ( $self) = @_;

    if ( my @errors = @_ )
    {
        $return_html .= join "<br/>", @errors;
    }
}

sub login
{

    my ($self ) = @_;
    my $data_hr = $self->{data_stack};

    my $return_html;
    
    $return_html = $data_hr->{first_name};

    return $return_html;
}

1;
