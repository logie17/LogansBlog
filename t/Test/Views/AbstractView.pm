package Test::Views::AbstractView;

use base Test::AbstractTest;
use strict;
use warnings;
use Test::More;

sub  test_use_01 : Test(1)
{
    my ($self) = @_;
    use_ok( 'Views::AbstractView');
}

sub test_run : Test(7)
{
    my ($self) = @_;


    my ($mock_cgi_obj, $mock_session_obj) = $self->setup_mocks;

    use_ok( 'Views::AbstractView');

    my $abstract_obj = Views::AbstractView->new( cgi_obj => $mock_cgi_obj, session_obj => $mock_session_obj );
    
    isa_ok($abstract_obj, 'Views::AbstractView', "Is the object View?");
    can_ok($abstract_obj, 'new');
    can_ok($abstract_obj, 'output');
    can_ok($abstract_obj, 'title');
    can_ok($abstract_obj, 'styles');
    
    my $results = $self->normalize($abstract_obj->output);

    my $control = $self->normalize($self->test_one_control);

    is ($results,$control, "Do results match control?");
}

sub setup_mocks
{
    my ($self) = @_;

    my $mock_cgi_class      = $self->setup_mock_cgi;
    my $mock_session_class  = $self->setup_mock_session;

    my $mock_cgi_obj = CGI->new;
    my $mock_session_obj = CGI::Session->new;

    return ($mock_cgi_obj, $mock_session_obj);
}

sub test_one_control
{
    return<<EOF;
<?xmlversion="1.0"encoding="iso-8859-1"?><!DOCTYPEhtmlPUBLIC"-//W3C//DTDXHTML1.0Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><htmlxmlns="http://www.w3.org/1999/xhtml"xml:lang="en"><head><title>LoganBell</title><metaname="author"content="LoganBell"/><metaname="copyright"content="Copyright2009(c)byLoganBell"/><metaname="description"content="Yawn"/><metaname="keywords"content="LoganBell"/><metaname="robots"content="all"/><linkrel="stylesheet"href="/styles/base.css"type="text/css"/></head><body><divid="page"><divid="header"><divid="title"><h1>LoganBell</h1></div><divid="subtitle">let'sconverse!</div></div><divid="yellowbar"></div><divid="wrapper"><divid="navbar"><divclass="headerbox_orange">entrees</div><divclass="box_brown"><ulclass="dkarrow"><li><ahref="/">blog</a></li><li><ahref="/pages/misc/resume">resume</a></li><li><ahref="/pages/misc/about">about</a></li><li><ahref="/pages/misc/about">about</a></li><li><ahref="/pages/admin/login">Login</a></li><li></li></ul></div><!--<divclass="headerbox_orange">categories</div><divclass="box_brown"><ulclass="dkarrow"><li><ahref="#">perl</a></li><listyle="margin:0;"><ahref="#">general</a></li></ul></div><divclass="headerbox_orange">archives</div><divclass="box_brown"><ulclass="dkarrow"><li><ahref="#">December</a></li><listyle="margin:0;"><ahref="#">January</a></li></ul></div>--><!--<divclass="headerbox_orange">sitelogin</div><divclass="box_brown"><table><tr><tdstyle="padding:10px;"><divstyle="margin:005px0;">Username:<br/><inputtype="text"size="15"/></div><divstyle="margin:005px0;">Password:<br/><inputtype="password"size="15"/></div><divid="login"></div></td></tr></table></div>--><divclass="headerbox_orange">delicious</div><divid="delicious"class="box_brown"></div><divclass="box_clear">RSS<ahref="./rss.xml"><imgsrc="http://www.loganbell.org/images/rss.png"width="14"height="14"alt="rss"/></a><br/><ahref="http://validator.w3.org/check?uri=referer"><imgsrc="http://www.w3.org/Icons/valid-xhtml10"alt="ValidXHTML1.0Strict"height="31"width="88"/></a></div><br/><br/><divid="session">WelcomeGuest<br/><ahref="http://www.loganbell.org/pages/admin/index/">Login</a></div><divid="tv"><imgsrc="http://www.loganbell.org/images/tv.png"width="150"height="209"alt="logan"/></div></div><divid="content">Wooop!<divid="footer">&copy;2009LoganBell.Allrightsreserved.</div></div><divid="squares"></div></div></div></body></html>
EOF

}
1;
