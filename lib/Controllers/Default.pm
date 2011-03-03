package Controllers::Default;

use Models::Entries;
use base Controllers::AbstractController;

use constant ENTRY_PER_PAGE => 5;
use constant DEFAULT_PAGE   => 1;

sub index
{
    my ($self) = @_;
    my $cgi_obj     = $self->{cgi_obj};

    my $page_number;

    if ( $cgi_obj->param('parameters') && $cgi_obj->param('parameters')->[0] =~ /^\d+$/ )
    {
        $page_number = $cgi_obj->param('parameters')->[0];
    }
    else
    {
        $page_number = DEFAULT_PAGE;
    }

    my $offset      = ($page_number * ENTRY_PER_PAGE) - ENTRY_PER_PAGE;

    my $parameters = $cgi_obj->param('parameters');

    my $entries                 = Models::Entries->get_entries( sort_by => 'post_date DESC', limit => ENTRY_PER_PAGE, offset => $offset );
    my $current_entry_count     = scalar @{$entries};
    my $total_entry_count       = Models::Entries->get_entries_count;

    my $previous_page_number   = $page_number > 1 ? $page_number - 1 : '';
    my $next_page_number       = ($page_number * ENTRY_PER_PAGE) < $total_entry_count ? $page_number + 1 : '';

    return { entries => $entries, next_page_number => $next_page_number, previous_page_number => $previous_page_number };

}


1;
