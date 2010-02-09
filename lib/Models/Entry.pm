package Models::Entry;

use base Rose::DB::Object;
use Models::DB;

use strict;
use warnings;


__PACKAGE__->meta->setup
(
    table   => 'entries',
    columns => [ qw(id title html ) ],
    pk_columns => 'id'

);

sub init_db { Models::DB->new }


1;
