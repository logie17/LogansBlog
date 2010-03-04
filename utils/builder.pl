#! /usr/local/bin/perl

use Cwd qw(abs_path);

#-------------------------------------------
# CONSTANTS
#-------------------------------------------

use constant LIB_PATH           => '../lib';
use constant CONTROLLER_PATH    => LIB_PATH . '/Controllers';
use constant VIEW_PATH          => LIB_PATH . '/Views';
use constant CONTROLLER_TEMP    => 'controller.temp';
use constant VIEW_TEMP          => 'view.temp';




generate();

#-------------------------------------------
# ROUTINES
#-------------------------------------------

sub generate
# Purpose:  Kicks off the generate template making process
# Input:    None; 
# Output:   None;
{
    my ( $type, $class_name, @flags ) = @ARGV;

    help() if !$type && !$class_name;

    if ( defined &{$type} && $type  )
    {
        &{$type}($class_name, $type);
    }
    else
    {
        print "ERROR: Invalid Type Provided\n";
    }
}

sub generate_path
# Purpose:  Generates the path to where this script lives
# Input:    None;
# Output:   String (path)
{
    my $path = abs_path($0);
    $path =~ s/\/[^\/]*\.pl$//;
    return $path;
}

sub controller
# Purpose:  Builds out a template for a controller
# Input:    String - class_name
# Output:   None;
{
    my ( $class_name, $type ) = @_;    

    my $new_class_file = CONTROLLER_PATH . '/' . $class_name . '.pm';

    if (!-e $new_class_file )
    {
        create_template($new_class_file, $class_name, $type);
    }
}

sub view
# Purpose:  Builds out a template for a view
# Input:    String - class_name
# Output:   None
{
    my ( $class_name, $type ) = @_;    

    my $new_class_file = VIEW_PATH . '/' . $class_name . '.pm';

    if (!-e $new_class_file )
    {
        create_template($new_class_file, $class_name, $type);
    }
}



sub create_template
# Purpose:  Builds out a template
# Input:    1. String - file name
#           2. String - class name 
#           3. String - type (controller/view)
# Output:   None
{
    my ( $file_name, $class_name, $type ) = @_;

    my $path = generate_path();
    my $temp_file = $path . '/' . lc($type) . '.temp';
    my $temp_contents = do 
    { 
        if ( open ( my $temp, "<", $temp_file ) )
        {
            local $/;
            <$temp>;
        } 
        else
        {
            undef; 
        }
    };

    if ( $temp_contents )
    {
        $temp_contents =~ s/__NAME__/$class_name/g;
        open ( my $fh, ">", "$path/$file_name" ) || die "Unable to open file for writing - $path/$file_name: $!";
        print $fh $temp_contents;
        close $fh;
    } 


    #return;
}

sub help
# Purpose:  Builds out help/man descriptions
# Input:    None
# Output:   Text 
{
    print<<EOF;

Usage: utils/builder.pl <type> <classname> 

Description: This is a utility script that will build needed
             classes.

EOF
}



