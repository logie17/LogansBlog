[%# Post Entries %]
[% FOREACH entry IN entries %]
        <div class="newsbox">
            <div class="body">
                <h2 class="tab_title"><a href="http://www.loganbell.org/pages/post/view/[% entry.seo_title %]/">[% entry.title %]</a></h2>
                [% entry.html %]
                <div class="post_date">Posted On: [% entry.friendly_post_date %]</div> 
                <ul class="tags">
                [% FOREACH t IN entry.all_tags %]
                    <li><a href="/pages/default/tags/[% t.tag %]">[% t.tag %]</a></li>
                [% END %]
                </ul>
                <br/>
            </div>
        </div> 
[% END %]

[%# Post footer logic %]
<div class="post_navigation">
     <div id="previous_page">
    [% IF previous_page_number %]
        <a href="/pages/default/index/[% previous_page_number %]/">&#8672; Previous Page</a>
    [% END %]
     </div>       
     <div id="next_page">
    [% IF next_page_number %]
        <a href="/pages/default/index/[% next_page_number %]">Next Page &#8674;</a>
    [% END %]
    </div>
</div>
