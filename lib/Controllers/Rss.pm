package Controllers::Rss;

use Models::Entries;
use DateTime;
use DateTime::Format::Mail;
use XML::Atom::Feed;
use XML::Atom::Entry;

use base Controllers::AbstractController;

use constant ENTRY_PER_PAGE => 5;

sub all
{
    my $entries = Models::Entries->get_entries( sort_by => 'post_date DESC' );
    return { entries => $entries, };

}
1;
