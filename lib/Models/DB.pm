package Models::DB;

use base Rose::DB;

__PACKAGE__->use_private_registry;

__PACKAGE__->register_db(
    driver      => 'SQLite',
    database    => '../db/blog.db'
);


1;
