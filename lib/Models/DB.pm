package Models::DB;

use base Rose::DB;

__PACKAGE__->use_private_registry;

__PACKAGE__->register_db(
    driver      => 'SQLite',
    database    => '../db/dev_blog.db',
    domain      => 'dev',
);

__PACKAGE__->register_db(
    driver      => 'SQLite',
    database    => '../db/prod_blog.db',
    domain      => 'prod',
);

__PACKAGE__->default_domain('dev');



1;
