package Views::Default;
use strict;
use warnings;

use base qw(Views::AbstractView);

sub index
# Purpose:  
# Input:    1. Reference to self
# Output:   2. HTML
{
    my ($self) = @_;

    my $data_hr = $self->{data_stack};

    my $html = join "", 
    map 
    { 
        '<div class="newsbox">
            <div class="body">
                <h2><a href="http://www.loganbell.org/pages/post/view/' . $_->{id} . '/">' . $_->{title} . '</a></h2>' . 
                $_->{html} . 
                '<div class="post_date">Posted On:' . $_->{post_date} . '</div> 
            </div>
        </div>' 
    } @{$data_hr->{entries}};   

    #if

    my $previous_page_html  = $data_hr->{previous_page_number} ? '<a href="/pages/default/index/' . $data_hr->{previous_page_number} . '/">Previous Page</a>' : '';
    my $next_page_html      = $data_hr->{next_page_number} ? '<a href="/pages/default/index/' . $data_hr->{next_page_number} . '/">Next Page</a>' : '';

    $html .= qq~<div class="post_navigation">
                    <div id="previous_page">$previous_page_html</div>       
                    <div id="next_page">$next_page_html</div>
                </div>
    ~;
    

    return $html;
}

1;
