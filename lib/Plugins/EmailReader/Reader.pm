package Plugins::EmailReader::Reader;
use base qw(Text::Markdown);

use overload '""' => \&to_string,'fallback' => 1;

sub to_string
{
    my ($self) = @_;    
    return $self->as_string;
}

1;
