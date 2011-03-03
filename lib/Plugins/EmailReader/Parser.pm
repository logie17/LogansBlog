package Plugins::EmailReader::Parser;
{
    use Moose;
    extends 'Plugins::AbstractPlugin';
    use Net::POP3;

    __PACKAGE__->plugin_type('job');

    #~~~ Accessors

    has username => (
        is  => 'ro',
        isa => 'Str',
        required => 1,
    );

    has password => (
        is  => 'ro',
        isa => 'Str',
        required => 1,
    );

    has hostname => (
        is  => 'ro',
        isa => 'Str',
        required => 1,
    );
    
    has pop3  => (
        is      => 'ro',
        isa     => 'Net::POP3',
        builder => "_build_pop3",
    );

    has 'emails' => ( 
        is          => 'rw', 
        isa         => 'ArrayRef[Plugins::EmailReader::Parser::Email]',
        default     => sub { [] },
    );

    #~~~ Methods

    sub _build_pop3 
    # Purpose:  Builder method for pop3
    # Input:    Ref to self
    # Output:   Net::POP3 object
    {
        my ($self ) = @_;
        return Net::POP3->new($self->hostname);
    }

    sub BUILD 
    # Purpose:  Called after object inialization
    # Input:    Ref to self
    # Output:   None
    {
        my $self = shift;
        $self->_load_emails;
    }

    sub _load_emails
    # Purpose:  Gathers up all e-mails
    # Input:    Ref to self
    # Output:   None
    {
        my ( $self ) = @_;
    
        if ( $self->pop3->login($self->username,$self->password) > 0)
        {
            my $msgnums_hr = $self->pop3->list;
            for my $msgnum(keys %{$msgnums_hr})
            {
                my $msg = $self->pop3->get($msgnum);
                my $email = Plugins::EmailReader::Parser::Email->new(join "", @$msg);

                push @{$self->emails}, $email;

            }
        }

    } 

    __PACKAGE__->meta->make_immutable;
    
    no Moose;
}

package Plugins::EmailReader::Parser::Email;
{
    use Moose;

    use Text::Markdown 'markdown';
    use overload '""' =>\&to_string, 'fallback' => 1;

    has raw_msg => (
        is       => 'rw',
        isa      => 'Str',
        required => 1,
    );
    
    has mark_down => (
        is          => 'rw',
        isa         => 'Str',
        lazy_build  => 1,
    );

    sub _build_mark_down {
        my $self = shift;
        return markdown($self->raw_msg);
    }

    
    sub to_string 
    # Purpose:  Returns raw_msg for overload - Direct call of the object
    # Input:    Ref to self
    # Output:   Raw email
    {
        my ($self) = @_;
        $self->raw_msg;
    }

    around BUILDARGS => sub {
        my $orig = shift;
        my $class = shift;
    
        if ( @_ == 1 && ! ref $_[0] ) {
            return $class->$orig(raw_msg => $_[0]);
        }
        else {
            return $class->$orig(@_);
        }
    };

    __PACKAGE__->meta->make_immutable;
    
    no Moose;

}

1;
