<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title>{if $title}{$title}{else}{$DATA.title|upper}{/if} - SteelGills.com</title>

{if $MEDIA=="mobile"}
	<link rel="stylesheet" href="/css/mobile.min.css"/>
	<meta name="viewport" content="initial-scale=1.0; maximum-scale=2.0; minimum-scale=0.5" /> 
{else}
	<link rel="stylesheet" href="/css/screen{if $smarty.server.HTTP_HOST=="steelgills.com"}.min{/if}.css"/>
{/if}
</head>
<body class="{$DISPATCHER.controller}-{$DISPATCHER.action}">

<div id="header">
	<div class="container">
		<h1 id="logo" class="logo"><a href="/">Steel Gills</a></h1>
		<ul class="navigation" id="globalnav">
		{if $USER.userid>0}
			<li id="nav_logbook" class="{if $DISPATCHER.controller eq "Logbook"} active{/if}"><a href="/logbook" class="tab">Logbook</a></li>
		{/if}
		<li id="nav_divesites" class="{if $DISPATCHER.controller eq "Divesites"}active{/if}"><a href="/divesites" class="tab">Dive-sites</a></li>
		{if $USER.userid>0}
			<li id="nav_profile" class="{if $DISPATCHER.controller eq "Profile"} active{/if}">
				<a href="/profile" class="avatar-link">
					<img src="{$USER.image}" class="avatar" alt="{$USER.username}" />
				</a>
			</li>
		{else}
			<li id="nav_signup"{if $DISPATCHER.controller eq "Signup"} class="active"{/if}><a href="/signup">Sign Up</a></li>
			<li id="nav_login" class="{if $DISPATCHER.controller eq "Login"} active{/if}"><a href="#" onclick="SG.Modal.openModal('/login/modal','login');return false;">Log in</a></li>
		{/if}
		</ul>
	</div>
</div>
<div id="wrapper" class="container">

	<div id="body">
	
		{if $smarty.session.feedback != ""}
		<div class="alert">
		{$smarty.session.feedback}
		</div>
		{/if}
	
