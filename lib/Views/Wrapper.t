[% IF no_wrapper OR template.no_wrapper %]
    [%- content %]
[% ELSE %]
<!DOCTYPE html>
<head>
    <title>Logan Bell - Software Developer</title>
    <meta name="author" content="Logan Bell" />
    <meta name="copyright" content="Copyright 2012 (c) by Logan Bell" />
    <meta name="description" content="Ramblings of a hacker who pretends he knows what he's doing" />
    <meta name="keywords" content="Logan Bell perl moose dbic lucy dezi" />
    <meta name="robots" content="all" />
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
    <link rel="stylesheet" href="/styles/base.css" type="text/css" />
</head>
<body>
<div id="page">
	<div id="header">
		<div id="title"><h1>Logan Bell</h1></div>
		<div id="subtitle">perlific ramblings</div>
	</div>
	<div id="yellowbar"></div>	
	<div id="wrapper">
        [% INCLUDE Navbar.t %]
		<div id="content">
            [% content %]
		<div id="footer">&copy; 2012 Logan Bell. All rights reserved.</div>
		</div>
		<div id="squares"></div>
	</div>
</div>
</body>
</html>

[% END %]


