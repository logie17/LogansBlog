package Models::Tag;
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
  table => 'tags',
 
  columns =>
  [
    id   => { type => 'int', primary_key => 1 },
    tag  => { type => 'varchar', length => 255 },
  ],
 
  relationships =>
  [
    # Define "many to many" relationship to get widgets
    entries =>
    {
      type      => 'many to many',
      map_class => 'Models::EntriesTagsMap',
 
      # These are only necessary if the relationship is ambiguous
      #map_from  => 'widget',
      #map_to    => 'color',
    },
  ],
);

sub seo_tag {
    lc $_[0]->tag;
}


1;
