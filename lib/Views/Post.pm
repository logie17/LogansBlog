package Views::Post;
use base Views::AbstractView;

sub view
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

    return $html;
}

1;
