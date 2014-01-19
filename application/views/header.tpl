<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title>{if $title}{$title}{else}{$DATA.title|upper}{/if} - SteelGills.com</title>

{if $MEDIA=="mobile"}
	<link rel="stylesheet" href="/css/mobile.min.css"/>
	<meta name="viewport" content="initial-scale=1.0; maximum-scale=2.0; minimum-scale=0.5" /> 
{else}
	<link rel="stylesheet" href="/css/screen{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.css"/>
{literal}<!--[if gte IE 7]>
<style type="text/css">
@font-face { font-family: "_header"; src: url("/css/fonts/gothamRoundedBold.eot"); }
</style>
<![endif]-->{/literal} 
	{if $smarty.server.HTTP_HOST!="steelgills.com"}<script src="/js/jquery.min.js" type="text/javascript"></script>{/if}
	<script src="/js/common{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.js" type="text/javascript"></script>
{/if}
</head>
<body>
{*
<div id="fb-root"></div>
<script src="http://connect.facebook.net/en_US/all.js"></script>
<script>{literal}
  FB.init({appId: '146102812067817', status: true, cookie: true, xfbml: true});
  FB.Event.subscribe('auth.sessionChange', function(response) {
    if (response.session) {
      // A user has logged in, and a new cookie has been saved
    } else {
      // The user has logged out, and the cookie has been cleared
    }
  });
{/literal}</script>
*}
<div id="wrapper">

	<div id="header">
		<h1 id="logo" class="logo{if ($smarty.server.REQUEST_URI == "/" && $DATA.user.userid <= 0)} big{/if}"><a href="/">Steel Gills</a></h1>

		<ul class="navigation segmented" id="globalnav">
		{if $USER.userid>0}
			<li id="nav_logbook" class="{if $DISPATCHER.controller eq "Logbook"} active{/if}"><a href="/logbook" class="tab">Logbook</a></li>
		{/if}
		<li id="nav_divesites" class="{if $DISPATCHER.controller eq "Divesites"}active{/if}"><a href="/divesites" class="tab">Dive-sites</a></li>
		{if $USER.userid>0}
			<li id="nav_profile" class="{if $DISPATCHER.controller eq "Profile"} active{/if}"><a href="/profile">My Profile</a></li>
		{else}
			<li id="nav_signup"{if $DISPATCHER.controller eq "Signup"} class="active"{/if}><a href="/signup">Sign Up</a></li>
			<li id="nav_login" class="{if $DISPATCHER.controller eq "Login"} active{/if}"><a href="#" onclick="SGModal.openModal('/login/modal');return false;">Log in</a></li>
		{/if}
		</ul>
	</div>
	
	<div id="body">
	
		{if $smarty.session.feedback != ""}
		<div class="alert" style="clear:both;">
		{$smarty.session.feedback}
		</div>
		{/if}
	
