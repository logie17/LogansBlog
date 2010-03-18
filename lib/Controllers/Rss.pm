package Controllers::Rss;

use Models::Entries;
use DateTime;
use DateTime::Format::Mail;

use base Controllers::AbstractController;

use constant ENTRY_PER_PAGE => 5;

sub all
{
    my $entries = Models::Entries->get_entries( sort_by => 'post_date DESC', limit => ENTRY_PER_PAGE );

    return { entries => $entries };

}
1;
