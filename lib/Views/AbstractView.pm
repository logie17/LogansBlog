package Views::AbstractView;


#-------------------------------------------
# PUBLIC METHODS
#-------------------------------------------

sub html_header
# Purpose:  Html for header
# Input:    1. Class name
# Output:   1. Blessed ref
{
    my ($self) = @_;
    
    my $html = $self->{cgi_obj}->header;
    $html .= qq~
<?xml version="1.0" encoding="utf-8" ?> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >
<head>
	<title>Logan Bell</title>

	<meta name="keywords" content="loganbell logan bell log blog bash perl ruby"/>
    	<meta name="description" content="Yawn... "/>
    	<meta name="author" content="Logan Bell" />
    	<meta name="robots" content="all" />
	<meta name="copyright" content="Copyright 2009 (c) by Logan Bell" />

	<link rel="stylesheet" href="/styles/base.css" type="text/css" />
</head>
<body>
<div id="page">
	<div id="header">
		<div id="title"><h1>Logan's Log</h1></div>
		<div id="subtitle">let's converse!</div>
	</div>
	<div id="yellowbar"></div>	
	<div id="wrapper">
        <%= import('navbar.html') %>
		<div id="content">~;

    return $html;
}

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

sub output
# Purpose:  Out all html markup
# Input:    1. Ref to self
# Output:   1. String of html
{
    my ($self) = @_;
    
    my $html = $self->html_header;

    
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

    $self->{cgi_obj} = $params->{cgi_obj};

    return $self;
}

1;
