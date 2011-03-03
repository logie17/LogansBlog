package Models::Type;

use base Rose::DB::Object;
use Models::DB;

use strict;
use warnings;


__PACKAGE__->meta->setup
(
    table   => 'types',
    columns => [ qw(id type) ],
    pk_columns => 'id'

);

sub init_db { Models::DB->new }
