package Models::Entry;

use base Rose::DB::Object;
use Models::DB;
use DateTime;
use HTML::Entities qw(encode_entities);

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

sub escaped_html
{
    my $self = shift;
    return encode_entities($self->html);
}

sub seo_title {
    my $self = shift;
    my $seo_title = $self->title;
    $seo_title =~ s/\s/\-/g;
    return lc $seo_title;
}


1;
