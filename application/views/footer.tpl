
</div><!-- /body -->

<div id="footer">
	<div class="container">
		<span class="pull-right">&copy;{$smarty.now|date_format:"%Y"} Steel Gills</span>
	
		<ul class="navigation" id="footernav">
			<li id="nav_about"{if $DISPATCHER.controller eq "about"} class="current"{/if}><a href="/about">About</a></li>
			<li id="nav_contact"{if $DISPATCHER.controller eq "contact"} class="current"{/if}><a href="/contact">Contact</a></li>
		{if $USER.userid}
			<li id="nav_logout"><a href="/login/logout">Log out</a></li>
		{else}
			<li id="nav_login"><a href="/login">Log in</a></li>
			<li id="nav_signup"{if $DISPATCHER.controller eq "signup"} class="current"{/if}><a href="/signup">Sign Up</a></li>
		{/if}
		</ul>

		{if $smarty.server.HTTP_HOST=="steelgills.com" && $smarty.server.REQUEST_URI!="/"}
		{*
		<script type="text/javascript"><!--
		google_ad_client = "pub-5835250264191986";
		/* steelgills_footer */
		google_ad_slot = "2538768408";
		google_ad_width = 728;
		google_ad_height = 90;
		//-->
		</script>
		<script type="text/javascript" src="http://pagead2.googlesyndication.com/pagead/show_ads.js"></script>
		*}
		{/if}

	</div><!-- /.container -->
</div><!-- /#footer -->


<div class="wallpaper"><span class="caption"></span></div>



<script data-main="/js/{if $module_js!=""}{$module_js}{else}app{/if}" src="/js/lib/require/require.js"></script>
<script type="text/javascript">
{if $smarty.server.HTTP_HOST=="steelgills.com"}
{literal}
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("UA-4173628-3");
pageTracker._trackPageview();
} catch(err) {}
{/literal}
{/if}
</script>



</body>
</html>