{include file='header.tpl' title='Steel Gills'}


{if $USER.userid <= 0}
<div class="content home">
	<h1>Steel Gills makes logging dives and finding divesites fun &amp; easy.</h1>
	<div id="signup_buttons">
		<p>Sign up with one click!</p>
		<p>
			<a href="/login/twitter" class="twitter">Sign In with Twitter</a> &nbsp; 
			<a href="/login/facebook" class="facebook">Connect with Facebook</a> &nbsp;
		</p>
			<p>Or create a free account:<br />
			<a href="{$DOCROOT}/signup" class="button hot big">Sign Up</a>
			</p>
	</div>
{else}
	<h2>Welcome, {$USER.username}</h2> 
	<div class="content">
		<h3>Recent Dives</h3>
		{include file="logbook/dive.list.mini.tpl" dives=$DATA.dives}
		<a href="/logbook/" class="button">View your logbook</a>
{/if}

</div>
{*
{if $USER.userid>0}
<div id="profile_sidebar" class="sidebar">
	<h3>Welcome {$USER.first_name}</h3>
	<dl>
		<dt>Dives logged</dt>
		<dd>{$USER.diveslogged}</dd>
	</dl>
</div>
{/if}
*}
<div class="clear"></div>

{include file='footer.tpl'}