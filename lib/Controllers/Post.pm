package Controllers::Post;

use Models::Entries;
use base Controllers::AbstractController;

sub view
{
    my ($self) = @_;

    my $cgi_obj = $self->{cgi_obj};
    my ($id, $title);

    if ( $cgi_obj->param('parameters') && $cgi_obj->param('parameters')->[0] =~ /^\d+$/ ) {
        $id = $cgi_obj->param('parameters')->[0];
    } elsif ( $cgi_obj->param('parameters') && $cgi_obj->param('parameters')->[0] =~ /^[\w-]+$/ ) {
        $title = $cgi_obj->param('parameters')->[0]; 
    }

    if ( $id ) {
        if ( my $entries = Models::Entries->get_entries( where => [ id => $id ] ) ) {
            return { entries => $entries };
        }
    }
    if ( $title ) {
        $title =~ s/\-/ /g;
        my $entries = Models::Entries->get_objects_from_sql(
            sql => qq[
                SELECT id, title, html, post_date FROM entries WHERE title = ? COLLATE NOCASE
            ],
            args => [ lc $title ]
        );

        if ( $entries ) {
            return { entries => $entries };
        }
    }
}

1;
