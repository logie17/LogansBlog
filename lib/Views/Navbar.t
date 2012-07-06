		<div id="navbar">
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
                <img width="170" height="22" srce="https://metacpan.org/activity?res=month&author=LOGIE" />
                <div>
                    Feed <a href="http://www.loganbell.org/atom.xml"><img src="http://www.loganbell.org/images/rss.png" width="14" height="14" alt="rss" /></a>
                </div>
			</div>
            <br/><br/>
		</div>
