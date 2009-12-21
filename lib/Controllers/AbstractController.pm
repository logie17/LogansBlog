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
    my ($self, $params) = @_;

    return $self;
}

1;
