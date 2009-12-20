#! /usr/local/bin/perl

use Test::More tests => 5;
use Test::MockClass;

use lib '../lib/';

#-------------------------------------------
# SETUP
#-------------------------------------------

my $mock_cgi_class = Test::MockClass->new('CGI');

$mock_cgi_class->defaultConstructor;
$mock_cgi_class->addMethod('header' => sub{return 'foo' });

$mock_cgi_obj = $mock_cgi_class->create;

#-------------------------------------------
# TESTS
#-------------------------------------------

BEGIN { use_ok( 'Views::AbstractView', "Can we use Views::AbstractView?" ); }
my $abstract_obj = Views::AbstractView->new( cgi_obj => $mock_cgi_obj );

isa_ok($abstract_obj, 'Views::AbstractView', "Is the object View?");
can_ok($abstract_obj, 'new');
can_ok($abstract_obj, 'output');
can_ok($abstract_obj, 'title');
can_ok($abstract_obj, 'styles');

my $results = $abstract_obj->output;
$results =~ s/[\n|\r|\s]//g;

my $control = qq~foo<?xmlversion="1.0"encoding="utf-8"?><!DOCTYPEhtmlPUBLIC"-//W3C//DTDXHTML1.0Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><htmlxmlns="http://www.w3.org/1999/xhtml"xml:lang="en"><head><title>LoganBell</title><metaname="author"content="LoganBell"/><metaname="copyright"content="Copyright2009(c)byLoganBell"/><metaname="description"content="Yawn"/><metaname="keywords"content="LoganBell"/><metaname="robots"content="all"/><linkrel="stylesheet"href="/styles/base.css"type="text/css"/></head><body><divid="page"><divid="header"><divid="title"><h1>LoganBell</h1></div><divid="subtitle">let'sconverse!</div></div><divid="yellowbar"></div><divid="wrapper"><%=import('navbar.html')%><divid="content">~;

is ($results,$control, "Do results match control?");

