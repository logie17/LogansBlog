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

#__PACKAGE__->meta->add_nonpersistent_columns('dt_obj');



sub init_db { Models::DB->new }


1;
