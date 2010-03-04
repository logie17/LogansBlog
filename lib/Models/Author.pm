package Models::Author;

use base Rose::DB::Object;
use Models::DB;

use strict;
use warnings;


__PACKAGE__->meta->setup
(
    table   => 'authors',
    columns => [ qw(id username password first_name last_name) ],
    pk_columns => 'id'

);

sub init_db { Models::DB->new }


1;
