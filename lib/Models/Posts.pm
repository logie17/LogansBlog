package Models::Entries;

use base Rose::DB::Object;
use Models::DB;

use strict;
use warnings;


__PACKAGE__->meta_setup (
    table   => 'entries',
    colunns => [ qw(id title) ],
    pk_columns => 'id'
);

sub init_db { Models::DB->new }



