package Controllers::Default;

use base Controllers::AbstractController;

sub default
{
    my ($self) = @_;
    
    my $entries = Models::Entries->get_entries;

    return $entries;

}

1;
