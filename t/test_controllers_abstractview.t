#! /usr/local/bin/perl

use Test::More tests => 7;
use Test::MockClass;

use lib '../lib/';

#-------------------------------------------
# SETUP
#-------------------------------------------

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

my $control = qq~<?xmlversion="1.0"encoding="utf-8"?><!DOCTYPEhtmlPUBLIC"-//W3C//DTDXHTML1.0Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><htmlxmlns="http://www.w3.org/1999/xhtml"xml:lang="en"><head><title>LoganBell</title><metaname="author"content="LoganBell"/><metaname="copyright"content="Copyright2009(c)byLoganBell"/><metaname="description"content="Yawn"/><metaname="keywords"content="LoganBell"/><metaname="robots"content="all"/><linkrel="stylesheet"href="/styles/base.css"type="text/css"/></head><body><divid="page"><divid="header"><divid="title"><h1>LoganBell</h1></div><divid="subtitle">let'sconverse!</div></div><divid="yellowbar"></div><divid="wrapper"><divid="navbar"><divclass="headerbox_orange">entrees</div><divclass="box_brown"><ulclass="dkarrow"><li><ahref="/">blog</a></li><li><ahref="/pages/misc/resume">resume</a></li><li><ahref="/pages/misc/about">about</a></li></ul></div><!--<divclass="headerbox_orange">categories</div><divclass="box_brown"><ulclass="dkarrow"><li><ahref="#">perl</a></li><listyle="margin:0;"><ahref="#">general</a></li></ul></div><divclass="headerbox_orange">archives</div><divclass="box_brown"><ulclass="dkarrow"><li><ahref="#">December</a></li><listyle="margin:0;"><ahref="#">January</a></li></ul></div>--><!--<divclass="headerbox_orange">sitelogin</div><divclass="box_brown"><table><tr><tdstyle="padding:10px;"><divstyle="margin:005px0;">Username:<br/><inputtype="text"size="15"/></div><divstyle="margin:005px0;">Password:<br/><inputtype="password"size="15"/></div><divid="login"></div></td></tr></table></div>--><divclass="headerbox_orange">delicious</div><divid="delicious"class="box_brown"></div><divclass="box_clear">RSS<ahref="./rss.xml"><imgsrc="./images/rss.png"border="0"/></a><br/><ahref="http://validator.w3.org/check?uri=referer"><imgsrc="http://www.w3.org/Icons/valid-xhtml10"alt="ValidXHTML1.0Strict"height="31"width="88"border="0"/></a></div><br/><br/><divid="tv"><imgsrc="./images/tv.png"width="150"height="209"/></div></div><divid="content"><divid="footer">&copy;2009LoganBell.Allrightsreserved.</div></div><divid="squares"></div></div></div></body></html>~;

is ($results,$control, "Do results match control?");

