package Controllers::Post;

use Models::Entries;
use base Controllers::AbstractController;

sub view
{
    my ($self) = @_;

    my $cgi_obj = $self->{cgi_obj};
    my $id;

    if ( $cgi_obj->param('parameters') && $cgi_obj->param('parameters')->[0] =~ /^\d+$/ )
    {
        $id = $cgi_obj->param('parameters')->[0];
    }

    if ( my $entries = Models::Entries->get_entries( where => [ id => $id ] ) )
    {
        return { entries => $entries };
    }
}

1;
