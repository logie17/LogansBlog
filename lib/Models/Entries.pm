package Models::Entries;

use base Rose::DB::Object::Manager;

use strict;
use warnings;


sub object_class {'Models::Entry'};

__PACKAGE__->make_manager_methods('entries');



1;
