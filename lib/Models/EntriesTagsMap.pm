package Models::EntriesTagsMap;
use base Rose::DB::Object;
use Models::DB;
use strict;
use warnings;

sub init_db 
{ 
    Models::DB->new;
}


__PACKAGE__->meta->setup
(
  table => 'entries_tags',
 
  columns =>
  [
    id        => { type => 'int', primary_key => 1 },
    entries_id => { type => 'int' },
    tags_id  => { type => 'int' },
  ],
 
  foreign_keys =>
  [
    entries =>
    {
      class => 'Models::Entry',
      key_columns => { entries_id => 'id' },
    },
 
    tags =>
    {
      class => 'Models::Tag',
      key_columns => { tags_id => 'id' },
    },
  ],
);
