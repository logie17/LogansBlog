#! /usr/local/bin/perl

use lib '../lib/';
use strict;
use warnings;
use Director;

my $director_obj = Director->new;
print $director_obj->run;
