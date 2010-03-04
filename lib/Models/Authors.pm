package Models::Authors;

use base Rose::DB::Object::Manager;

use strict;
use warnings;


sub object_class {'Models::Author'};

__PACKAGE__->make_manager_methods('authors');



1;
