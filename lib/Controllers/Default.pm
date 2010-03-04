package Controllers::Default;

use Models::Entries;
use base Controllers::AbstractController;

sub index
{
    my $entries = Models::Entries->get_entries;

    my @entries_data = map { { title => $_->title, html => $_->html } } @$entries;

    return { entries => \@entries_data };

}

1;
