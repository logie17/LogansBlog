package Views::Admin;
use base Views::AbstractView;
use strict;
use warnings;

#-------------------------------------------
# CONSTANTS
#-------------------------------------------

#-------------------------------------------
# ACTIONS
#-------------------------------------------

#sub view_hook
## Purpose:  See AbstractView - this is a view_hook before any views can be accessed
## Input:    1. Ref to self
## Output:   Boolean
#{
#    my ($self) = @_;
#
#    my $login = $self->logged_in;
#
#    return $self->logged_in;
#}

sub admintools
# Purpose:  Admin tools view, only if logged in
# Input:    1. Ref to self
# Output:   1. HTML
{
    my ( $self) = @_;

    return 'Welcome to admin tools';
    
}

sub index: properties(security => 'ALL')
# Purpose:  Index View
# Input:    1. Ref to self
# Output:   1. HTML
{
    my ($self) = @_;
    my $data_hr = $self->{data_stack};

    my $url = 'http://www.loganbell.org/pages/admin/login/';

    #$self->index_permission;


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

    my $return_html =<<EOF;
    <div class="admin_controls">
        <a href="/pages/admin/post_article/">Post Article</a>
    </div>
EOF

    return $return_html;
}

sub post_article
# Purpose:  View to post a new article
# Input:    1. Ref to self
# Output:   1. HTML
{
    my ($self) = @_;

    my $return_html =<<EOF;
    <div class="admin_post_article">
        <input type="text" name="title" value="Title"/>
        <br/>
        <textarea name="article"></textarea>
    </div>
EOF

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

    my $return_html;

    if ( my @errors = @_ )
    {
        $return_html .= join "<br/>", @errors;
    }

    return $return_html;
}


1;
