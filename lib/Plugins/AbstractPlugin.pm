package Plugins::AbstractPlugin;
{
    use Moose;


    # Class level data for plugin type (see plugin_type)
    our $plugin_type;
    
    around BUILDARGS => sub {
        my $orig = shift;
        my $class = shift;
    
    
        if ( @_ == 1 && ! ref $_[0] ) {
            return $class->$orig(msg => $_[0]);
        }
        else {
            return $class->$orig(@_);
        }
    };
    
    sub plugin_type
    {
        my ($proto, $type) = @_;

        my $class = ref $proto;

        if ( $type ) 
        {
            $class::plugin_type = $type;
        }

        return $class::plugin_type;
        
    }
    __PACKAGE__->meta->make_immutable;

}

1;
