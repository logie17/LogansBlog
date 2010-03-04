package Controllers::AbstractController;

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

    return $self->_init(\%params);
    
}

#-------------------------------------------
# PRIVATE METHODS
#-------------------------------------------

sub _init
# Purpose:  Intializes the Abstract class
# Input:    1. Ref to self
# Output:   1. Ref to self
{
    my ($self, $params_hr) = @_;

    $self->{cgi_obj}        = $params_hr->{cgi_obj};
    $self->{session_obj}    = $params_hr->{session_obj};

    return $self;
}

sub action
# Purpose:  Updates action for view
# Input:    1. Ref to self
#           2. Action string            
# Output:   1. None;
{
    my ($self, $action) = @_;

    if ( $action )
    {
        $self->{action} = $action;
    }

    return $self->{action};

}

1;
