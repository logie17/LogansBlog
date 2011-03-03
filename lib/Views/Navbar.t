		<div id="navbar">
			<div class="headerbox_orange">entrees</div>
			<div class="box_brown">
				<ul class="dkarrow">
					<li><a href="/">blog</a></li>
					<li><a href="/pages/misc/resume">resume</a></li>
					<li><a href="/pages/misc/about">about</a></li>
                    [% IF session_username %]
                    <li>[% admin_link %]</li>
                    <li>[% admin_link2 %]</li>
                    [% END %]
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
			<div class="box_clear">
                    RSS <a href="./rss.xml"><img src="http://www.loganbell.org/images/rss.png" width="14" height="14" alt="rss" /></a>
                    <br/>
    				<a href="http://validator.w3.org/check?uri=referer"><img
        			src="http://www.w3.org/Icons/valid-xhtml10"
        			alt="Valid XHTML 1.0 Strict" height="31" width="88" /></a>
			</div>
            <br/><br/>
			<div id="tv"> 
				<img src="http://www.loganbell.org/images/tv.png" width="150" height="209" alt="logan"/>
			</div>
		</div>
