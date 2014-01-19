<div id="signin_form">
	{if $USER.userstatus eq "pending"}
	<div>
		<p>You must confirm your account before you can log in. Check your email for your confirmation code.
	</div>
	{/if}

	<form method="post" action="{$DOCROOT}/login">

	<input type="hidden" name="referer" value="{if isset($smarty.server.HTTP_REFERER)}{$smarty.server.HTTP_REFERER}{else}{$smarty.server.REQUEST_URI}{/if}" />
	{if $USER.confirmation}<input type="hidden" name="confirm_code" value="{$USER.confirmation}" />{/if}
	
	<fieldset style="float:left;">
		<legend>SteelGills Account</legend>
		<div>
			<label for="username">Username or email</label>
			<input type="text" id="username" name="username" class="text" tabindex="1" />
		</div>
		<div>
			<label for="password">Password</label>
			<input type="password" id="password" name="password" class="text" tabindex="1" />
		</div>
		<small><a href="/profile/pw_reminder">forgot your password?</a></small><br />
		<input type="submit" class="submit button" name="btnSubmit" value="Sign In" tabindex="1" />
	</fieldset>

	<div class="left" style="padding: 20px;">-or-</div>

	<fieldset>
	<legend>Connect Social Accounts</legend>
	<small style="display:block;width:230px;">Connecting your twitter or facebook account allows you to sign in with those services and publish updates to them</small>
	<p><a href="/login/twitter"><img src="/images/connect_twitter.png" /></a></p>
	<p><a href="/login/facebook"><img src="/images/connect_facebook.gif" /></a></p>
	</fieldset>

	<div class="clear"></div>

	<fieldset>
	<legend>Not a Member?</legend>
	<div>
		<a href="{$DOCROOT}/signup"><input type="button" class="button" name="btnSignup" value="Sign Up" /></a>
	</div>
	</fieldset>


	</form>

</div>
<br clear="all" />