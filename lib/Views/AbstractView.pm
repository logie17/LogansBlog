package Views::AbstractView;


#-------------------------------------------
# CONSTANT
#-------------------------------------------

use constant DEFAULT_TITLE         => scalar 'Logan Bell';
use constant DEFAULT_STYLE_SHEET   => scalar '/styles/base.css';
use constant META_KEYWORDS         => scalar 'Logan Bell';
use constant META_DESCRIPTION      => scalar 'Yawn';
use constant META_AUTHOR           => scalar 'Logan Bell';
use constant META_ROBOTS           => scalar 'all';
use constant META_COPYRIGHT        => scalar 'Copyright 2009 (c) by Logan Bell';

#-------------------------------------------
# PUBLIC METHODS
#-------------------------------------------

sub html_header
# Purpose:  Html for header
# Input:    1. Class name
# Output:   1. Blessed ref
{
    my ($self) = @_;
    
    my $css_markup  = $self->_generate_css;
    my $meta_markup = $self->_generate_meta;
    my $title       = $self->title;
    my $html_navbar = $self->html_navbar;

    my $html = qq~
<?xml version="1.0" encoding="utf-8" ?> 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >
<head>
	<title>$title</title>
    $meta_markup
    $css_markup
</head>
<body>
<div id="page">
	<div id="header">
		<div id="title"><h1>$title</h1></div>
		<div id="subtitle">let's converse!</div>
	</div>
	<div id="yellowbar"></div>	
	<div id="wrapper">
        $html_navbar
		<div id="content">~;

    return $html;
}

sub html_navbar
# Purpose:  Html for navbar
# Input:    1. Class name
# Output:   1. String of html
{
    my ($self) = @_;

    my $session_obj = $self->{session_obj};

    my $sesssion_div = '';
    if ( my $first_name  = $session_obj->param("first_name") )
    {
        $session_div = 'Welcome ' . $first_name;    
    }
    else
    {
        $session_div = 'Welcome Guest<br/><a href="http://www.loganbell.org/pages/admin/index/">Login</a>';
    }

    
    
    my $html = qq~
		<div id="navbar">
			<div class="headerbox_orange">entrees</div>
			<div class="box_brown">
				<ul class="dkarrow">
					<li><a href="/">blog</a></li>
					<li><a href="/pages/misc/resume">resume</a></li>
					<li><a href="/pages/misc/about">about</a></li>
				</ul>
			</div>
			<!--<div class="headerbox_orange">categories</div>
			<div class="box_brown">
				<ul class="dkarrow">
					<li><a href="#">perl</a></li>
					<li style="margin:0;"><a href="#">general</a></li>
				</ul>
			</div>
			<div class="headerbox_orange">archives</div>
			<div class="box_brown">
				<ul class="dkarrow">
					<li><a href="#">December</a></li>
					<li style="margin:0;"><a href="#">January</a></li>
				</ul>
			</div>-->
			<!--<div class="headerbox_orange">site login</div>
			<div class="box_brown">
				<table>
					<tr>
						<td style="padding: 10px;">
							<div style="margin: 0 0 5px 0;">Username:<br/><input type="text" size="15"/></div>
							<div style="margin: 0 0 5px 0;">Password:<br/><input type="password" size="15"/></div>
							<div id="login"></div>
						</td>
					</tr>
				</table>
			</div>-->
			<div class="headerbox_orange">delicious</div>
            <div id="delicious" class="box_brown">
            </div>
			<div class="box_clear">
                    RSS <a href="./rss.xml"><img src="./images/rss.png" border="0"/></a>
                    <br/>
    				<a href="http://validator.w3.org/check?uri=referer"><img
        			src="http://www.w3.org/Icons/valid-xhtml10"
        			alt="Valid XHTML 1.0 Strict" height="31" width="88" border="0" /></a>
			</div>
            <br/><br/>
            <div id="session">
                $session_div
            </div>
			<div id="tv"> 
				<img src="./images/tv.png" width="150" height="209" />
			</div>
		</div>
    ~;

    return $html;
}

sub html_footer
# Purpose:  Html for footer
# Input:    1. Ref to self
# Output:   1. String of html
{
    my ($self) = @_;    

    return qq~
		<div id="footer">&copy; 2009 Logan Bell. All rights reserved.</div>
		</div>
		<div id="squares"></div>
	</div>
</div>
</body>
</html>~;
    
}

sub html_content
# Purpose:  Abstract Method for content
# Input:    1. Ref to self
# Output:   1. String of html
{
    my ($self) = @_;    

    my $action = $self->{action};

    if ( $action )
    {
        return $self->$action;
    }
    return '';
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

sub meta
# Purpose:  Accessor for meta information
# Input:    1. Ref to self
#           2. Hash of meta keywords
# Output:   1. Hashref of meta keywords
{
    my ($self, %meta) = @_;

    $self->{meta_hr} = \%meta;

}

sub output
# Purpose:  Out all html markup
# Input:    1. Ref to self
# Output:   1. String of html
{
    my ($self) = @_;
    
    my $header  = $self->html_header;
    my $content = $self->html_content;
    my $footer  = $self->html_footer;

    return $header . $content . $footer;

    
}

sub styles
# Purpose:  Accessor for styles, keeps a unique list
# Input:    1. Ref to self
#           2. New css file
# Output:   1. Hash ref of style sheet paths
#           2. Hash ref of inline css styles
{
    my ($self, $css) = @_;

    if ( $css =~ /\.css$/ )
    {
        $self->{_css_sheets_hr}->{$css} = 1;    
    }
    else
    {
        (my $minifed_css = $css) =~ s/[\r|\n|\s]//g;
        $self->{_css_inline_hr}->{$minified_css} = $css;
    }

    return ( $self->{_css_sheets_hr}, $self->{_css_inline_hr} );
}

sub title
# Purpose: Accessor for page title
# Input:   1. Ref to self
#          2. String of title
# Output:  1. Title string
{
    my ($self, $title) = @_;

    $self->{_title} = $title if $title;

    return $self->{_title};
}

#-------------------------------------------
# PRIVATE METHODS
#-------------------------------------------

sub _generate_css
# Purpose:  Generates CSS markup
# Input:    1. Ref to self
# Output:   2. CSS markup for header
{
    my ($self) = @_;

    my $css_markup = '';

    $css_markup .= join "\n", map {'<link rel="stylesheet" href="' . $_ . '" type="text/css" />'} 
                   keys %{$self->{_css_sheets_hr}};

    $css_markup .= join "\n", map {'<style>' . $self->{_css_inline_hr}->{$_} . '</style>' }
                   keys %{$self->{_css_inline_hr}};

    return $css_markup;
	
}

sub _generate_meta
# Purpose:  Generates META markup
# Input:    1. Ref to self
# Output:   2. META markup for header
{
    my ($self) = @_;
    my $meta_markup = '';
	
    $meta_markup .= join "\n", map { '<meta name="' . $_ . '" content="' . $self->{meta_hr}->{$_} . '" />' }
                    sort keys %{$self->{meta_hr}};

    return $meta_markup;

}

sub _init
# Purpose:  Intializes the Abstract class
# Input:    1. Ref to self
# Output:   1. Ref to self
{
    my ($self, $params_hr) = @_;

    $self->{_css_sheets_hr}     = {};
    $self->{_css_inline_hr}     = {};

    $self->title(DEFAULT_TITLE);
    $self->styles(DEFAULT_STYLE_SHEET);

    $self->{session_obj} = $params_hr->{session_obj};
    $self->{action}      = $params_hr->{action} || 'index';
    $self->{data_stack}  = $params_hr->{data_stack};

    $self->meta( 
                keywords    => META_KEYWORDS, 
                description => META_DESCRIPTION, 
                author      => META_AUTHOR, 
                robots      => META_ROBOTS, 
                copyright   => META_COPYRIGHT 
               );

    return $self;
}

1;
