package Test::Plugins::Email::Parser;

use base Test::AbstractTest;
use strict;
use warnings;
use Test::More;
use Test::MockModule;

sub  test_use_01 : Test(1)
{
    my ($self) = @_;
    use_ok( 'Plugins::EmailReader::Parser');
}

sub test_parser_02 : Test(2)
{
    my ($self) = @_;

    use Plugins::EmailReader::Parser;
    use Email::Simple;
    my $email_obj = Email::Simple->create(
        header => [
            'From'  =>  'foo@bar.com',
            'To'    =>  'test@test.com',
            'Date'  =>  'Fri, 23 Jul 2010 02:27:15',
        ],
        body    => 'Lorem Ipsum',
    );

    my $email_parser_obj = Plugins::EmailReader::Parser->new(username => 'logan', password => 'm2hdUn123', hostname => 'mail.orchardtech.com');

    my $email_objs = $email_parser_obj->emails;

    for my $email_obj ( @$email_objs )
    {
        print STDERR ref $email_obj,"\n";
        print STDERR $email_obj->mark_down,"\n";
    }
    #use Data::Dumper;

    #print STDERR Dumper(\@email_objs);

    #is $email_parser_obj->plugin_type,'job';

    #is $email_parser_obj->job,"<p>Lorem Ipsum</p>\n";

}



1;
