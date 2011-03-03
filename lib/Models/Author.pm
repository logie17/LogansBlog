package Models::Author;

use base Rose::DB::Object;
use Models::DB;

use strict;
use warnings;


__PACKAGE__->meta->setup
(
    table   => 'authors',
    columns => [ 
        id          =>  
        { 
            type            => 'serial', 
            primary_key     => 1, 
            not_null        => 1, 
        },
        username    =>  
        { 
            type            =>  'varchar', 
            length          => 255, 
            not_null        => 1,   
            default         => 'guest',
        },
        password    =>  { type  => 'varchar',    length  => 255 },
        first_name  =>  { type  => 'varchar',    length => 255 },
        last_name   =>  { type  => 'varchar',    length  => 255 },
        type        =>  { type  => 'int'} 
    ],
    pk_columns => 'id',
    foreign_keys => 
    [
        type => 
        {
            class       => 'Models::Type',
            key_columns => {'type' => 'id'}
        }

    ]

);

sub foo
{
    return 'hi';    
}

sub init_db { Models::DB->new }


1;
