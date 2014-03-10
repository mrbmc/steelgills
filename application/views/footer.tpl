
	</div><!-- /body -->
</div><!-- /wrapper -->

<div id="footer-wrapper">
	<div id="footer" class="container">
		<ul class="navigation" id="footernav">
			<li id="nav_about"{if $DISPATCHER.controller eq "about"} class="current"{/if}><a href="/about">About</a></li>
			<li id="nav_contact"{if $DISPATCHER.controller eq "contact"} class="current"{/if}><a href="/contact">Contact</a></li>
			<li id="nav_help"{if $DISPATCHER.controller eq "help"} class="current"{/if}><a href="/help">Help</a></li>
		{if $USER.userid}
			<li id="nav_profile"{if $DISPATCHER.controller eq "profile"} class="current"{/if}><a href="/profile">My Profile</a></li>
			<li id="nav_logout"><a href="/login/logout">Log out</a></li>
		{else}
			<li id="nav_login"><a href="/login">Log in</a></li>
			<li id="nav_signup"{if $DISPATCHER.controller eq "signup"} class="current"{/if}><a href="/signup">Sign Up</a></li>
		{/if}
		</ul>

		<span class="right">&copy;{$smarty.now|date_format:"%Y"} Steel Gills</span>
	
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

	</div><!-- /footer -->
</div><!-- /footer-wrapper -->


<div class="wallpaper"><span class="caption"></span></div>



<script data-main="js/{if $module_js!=""}{$module_js}{else}app{/if}" src="js/lib/require/require.js"></script>
<script type="text/javascript">
/*requirejs.config({
	"baseUrl": "/js",
	"paths": {
		"jquery": "//ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min",
		"underscore": "lib/underscore/underscore-min",
		"app": "app",
    }
});*/

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