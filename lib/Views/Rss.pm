package Views::Rss;
use base Views::AbstractView;

use DateTime::Format::Mail;

use XML::RSS;

sub all
# Purpose:  Displays all RSS
# Input:    1. A ref to self
# Output:   RSS XML
{
    my ($self) = @_;
    my $data_hr = $self->{data_stack};
    my $pf = DateTime::Format::Mail->new;
    
    my $rss = XML::RSS->new (version => '2.0');
 
    $rss->channel( title    =>  "Logans Blog", link => "http://www.loganbell.org", language => "en" );

    for my $entry( @{$data_hr->{entries}} )
    {
        my $title       = $entry->{title};
        my $description = $entry->{html}; 
        my $pubdate     = $pf->format_datetime($entry->post_date);
        my $id          = $entry->{id};

        my $url         = 'http://www.loganbell.org/pages/post/view/' . $id . '/';

        $rss->add_item(title => $title, link=> $url, description=> $description, pubDate => $pubdate);
    }

    return $rss->as_string;
}

sub output
# Purpose:  Since this is RSS we override the abstract output method
# Input:    1. A ref to self
# Output:   RSS XML
{
    my ($self) = @_;
    my $content = $self->html_content;
    return $content;
}

1;
