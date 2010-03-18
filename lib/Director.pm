package Director;

use strict;
use warnings;
use CGI;
use CGI::Session;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser carpout set_message); 


#-------------------------------------------
# CONSTANTS
#-------------------------------------------

use constant LIB_PATH                        => '../lib/';
use constant DB_PATH                         => '../db/blog.db';
use constant DEFAULT_VIEW                    => scalar 'Default';
use constant DEFAULT_ACTION                  => scalar 'index';
use constant CONTROLLER_BASE                 => scalar 'Controllers';
use constant VIEW_BASE                       => scalar 'Views';
use constant DEBUG                           => scalar 0;

# Error Messages
use constant ERROR_NO_VIEW_CONTROLLER        => scalar 'There was an error1';
use constant ERROR_VIEW_CONTROLLER_INVALID   => scalar 'There was an error2';

#-------------------------------------------
# PUBLIC METHODS
#-------------------------------------------

sub new
# Purpose:  Constructor for Director
# Input:    1. Class name
# Output:   1. Blessed ref
{
    my ($class, %params) = @_;

    $class = ref $class || $class;

    my $self = {};

    bless ($self, $class);

    if ( DEBUG )
    {
        require IO::Handle;
        require Data::Dumper;

        open ERROR,  '>', "../logs/error.txt"  or die $!;
        STDERR->fdopen( \*ERROR,  'w' ) or die $!;
    }

    return $self->_init(\%params);
    
}


sub run
# Purpose:  Run method that initializes controllers/views. Builder pattern
# Input:    1. Ref to self
# Output:   2. String of html
{
    my ($self) = @_;
    
    my $cgi_obj         = $self->{cgi_obj};
    my $session_obj     = $self->{session_obj};
    my $action          = lc $cgi_obj->param('action') || DEFAULT_ACTION;
    my $view            = ucfirst $cgi_obj->param('view') || DEFAULT_VIEW;
    my $return_html     = $session_obj->header;
    my $lib_path        = $self->{lib_path};

    if ($action && $view)
    {
        my $controller_file     = $lib_path . CONTROLLER_BASE . '/' . $view . '.pm';
        my $view_file           = $lib_path . VIEW_BASE . '/' . $view . '.pm';

        eval "use lib $lib_path";

        if ( -e $view_file )
        {
            my $data;
            if ( -e $controller_file ) 
            {

                require "$controller_file";

            
                my $controller_class    = CONTROLLER_BASE . '::' . $view;
                my $controller_obj      = $controller_class->new( 'cgi_obj' => $cgi_obj, 'session_obj' => $session_obj );
                my $controller_method   = lc $action;
                if ( $controller_obj->can($controller_method) )
                {
                    $data                   = $controller_obj->$controller_method;
                    $action                 = $controller_obj->action || $action;
                    if ( my $updated_view = ucfirst $controller_obj->view )
                    {
                        my $updated_view_file = $lib_path . VIEW_BASE . '/' . $updated_view . '.pm';
                        if ( -e $updated_view_file )
                        {
                            $view_file = $updated_view_file; 
                            $view      = $updated_view;
                        }    
                    }             
                }
            }

            require "$view_file";
            my $view_class          = VIEW_BASE . '::' . $view;
            my $view_obj            = $view_class->new( 'cgi_obj' => $cgi_obj, 'session_obj' => $session_obj, 'data_stack' => $data , 'action' => $action); 

            $return_html            .= $view_obj->output;
        }
        else
        {
            $return_html .= ERROR_VIEW_CONTROLLER_INVALID . "\n";
        }
    }
    else
    {
        $return_html .= ERROR_NO_VIEW_CONTROLLER;
    }

    return $return_html;

}

#-------------------------------------------
# PRIVATE METHODS
#-------------------------------------------

sub _gather_additional_parameters
# Purpose:  Splits the "parameters" param and places the key/values into
#           the query object            
# Input:    1. A reference to self
# Output:   None
{
    my ($self) = @_;

    if ( my $parameters = $self->{cgi_obj}->param("parameters")  )
    {
        my @parameters = split(/\//,$parameters);        
        $self->{cgi_obj}->param("parameters", \@parameters);
    }
    
    return;

}

sub _init
# Purpose:  Intializes the Director
# Input:    1. Ref to self
# Output:   1. Ref to self
{
    my ($self, $params) = @_;

    $self->{cgi_obj}        = CGI->new;
    $self->{session_obj}    = CGI::Session->new("driver:sqlite", $self->{cgi_obj}, {DataSource => DB_PATH});
    $self->{lib_path}       = $params->{lib_path} || LIB_PATH;

    $self->_gather_additional_parameters;

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

Copyright (c) 2009-2010 by Logan J Bell.  All rights reserved.  This program is
free software; you can redistribute it and/or modify it under the same terms
as Perl itself.
