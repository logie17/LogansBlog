package Models::Entry;

use base Rose::DB::Object;
use Models::DB;
use DateTime;

use strict;
use warnings;


__PACKAGE__->meta->setup
(
    table   => 'entries',
    columns => [ 'id', 'title', 'html', post_date => {type => 'timestamp'} ],
    pk_columns => 'id'

);

sub init_db 
{ 
    Models::DB->new;
}

sub friendly_post_date 
{
    my $self      = shift;
    my $friendly  = $self->post_date(format => '%m/%d/%Y');
    $friendly     =~ s/\s1$//g;
    return $friendly;
}


1;
