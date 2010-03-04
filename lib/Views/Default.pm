package Views::Default;
use base Views::AbstractView;

sub index
{
    my ($self) = @_;

    my $data_hr = $self->{data_stack};

    my $html = join "", map { $_->html } @{$data_hr-{entries}};   

    return $html;
}

1;
