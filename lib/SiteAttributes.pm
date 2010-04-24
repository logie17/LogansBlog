package SiteAttributes;
use strict;
use Attribute::Handlers;
no warnings 'redefine';

#-------------------------------------------
# CONSTANT
#-------------------------------------------

#-------------------------------------------
# PUBLIC METHODS
#-------------------------------------------

sub UNIVERSAL::properties :ATTR(CODE, BEGIN)
# Purpose: Sets persmissions - see perldoc Attribute::Hanlders
{
    my ($package, $symbol, $referent, $attr, $data, $phase) = @_;
    {
        no strict 'refs';
        if ( my $sub_address = $referent )
        {
            my $key = $data->[0];
            my $val = $data->[1];
            $Views::AbstractView::attribute_dictionary->{$sub_address} = { $key = $val };
        }
    } 

}

1;

__END__

=head1 NAME

SiteAttributes

=head1 DESCRIPTION

This is the base class for Views. A user can setup site attributes on views
that control various aspects. Currently the only supported property is for security

This is ran during the BEGIN Perl phase

Examples:

sub foo:properties(security=>'ALL');
{
    ...
}

sub bar:properties(security=>'Users,Authors');
{
    ...
}

In order to setup the security parameters, these are located in configuration/properties/security.yaml
