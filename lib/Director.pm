package Director;

use strict;
use warnings;
use CGI;

#-------------------------------------------
# CONSTANTS
#-------------------------------------------

use constant LIB_PATH           => '/usr/home/logie17/public_html/loganbell.org/new_site/lib/';
use constant DEFAULT_VIEW       => scalar 'Default';
use constant DEFAULT_CONTROLLER => scalar 'Default';
use constant CONTROLLER_BASE    => scalar 'Controllers';
use constant VIEW_BASE          => scalar 'Views';

#-------------------------------------------
# PUBLIC METHODS
#-------------------------------------------

sub new
# Purpose:  Constructor for Director
# Input:    1. Class name
# Output:   1. Blessed ref
{
    my ($class) = @_;

    $class = ref $class || $class;

    my $self = {};

    bless ($self, $class);

    return $self->_init;
    
}


sub run
# Purpose:  Run method that initializes controllers/views. Builder pattern
# Input:    1. Ref to self
# Output:   2. String of html
{
    my ($self) = @_;
    
    my $cgi     = $self->{cgi_obj};
    my $action  = $cgi->param('action') || DEFAULT_CONTROLLER;
    my $view    = $cgi->param('view') || DEFAULT_VIEW;

    if ($action && $view)
    {
        my $controller_file     = LIB_PATH . CONTROLLER_BASE . '/' . $action . '.pm';
        my $view_file           = LIB_PATH . VIEW_BASE . '/' . $view . '.pm';

        eval "use lib LIB_PATH";

        if ( -e $controller_file && -e $view_file )
        {
            require "$controller_file";

            my $controller_class    = CONTROLLER_BASE . '::' . $action;
            my $controller_obj      = $controller_class->new;
            my $controller_method   = lc $view;

            my $data                = $controller_obj->$controller_method;
            
            my $view_class          = VIEW_BASE . '::' . $view;
            my $view_obj            = $view_class->new( 'data_stack' => $data ); 

            return $cgi->header . $view_obj->output;
        }
    }

}

#-------------------------------------------
# PRIVATE METHODS
#-------------------------------------------

sub _init
# Purpose:  Intializes the Director
# Input:    1. Ref to self
# Output:   1. Ref to self
{
    my ($self) = @_;

    $self->{cgi_obj} = CGI->new;

    return $self;
}

1;

__END__

=head1 NAME

Director

=head1 SYNOPSIS

use Director;

my $director_obj = Director->new;
$director_obj->run;


=head1 DESCRIPTION

L<Director> is a builder class that initializes the needed runtime controllers/views for BLogger

=head1 AUTHOR

Logan J. Bell (loganbell@loganbell.org)

=head1 LICENSE

Copyright (c) 2009 by Logan J Bell.  All rights reserved.  This program is
free software; you can redistribute it and/or modify it under the same terms
as Perl itself.
