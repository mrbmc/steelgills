<div id="signin_form" class="fade {$class}">
	{if $USER.userstatus eq "pending"}
	<div>
		<p>You must confirm your account before you can log in. Check your email for your confirmation code.
	</div>
	{/if}

	<form method="post" action="{$DOCROOT}/login">

	<input type="hidden" name="referer" value="{if isset($smarty.server.HTTP_REFERER)}{$smarty.server.HTTP_REFERER}{else}{$smarty.server.REQUEST_URI}{/if}" />
	{if $USER.confirmation}<input type="hidden" name="confirm_code" value="{$USER.confirmation}" />{/if}
	
	<div class="row">
		<div class="span12">
			<fieldset>
				<h3>Use Your Social Account</h3>
				<p>
					<a href="/login/twitter" class="btn twitter"><!-- <img src="/images/connect_twitter.png" /> -->Use Twitter</a>
					<a href="/login/facebook" class="btn facebook"><!-- <img src="/images/connect_facebook.gif" /> -->Use Facebook</a>
				</p>
				<hr />
				<h3>Or Use Your Email</h3>
				<div class="control-group">
					<div class="control-label">
						<label for="username">Email Or Username</label>
						
					</div>
					<div class="controls">
						<input type="text" id="username" name="username" class="input-block-level" tabindex="1" />
					</div>
				</div>
				<div class="control-group">
					<div class="control-label">
						<label for="password">Password</label>
						
					</div>
					<div class="controls">
						<input type="password" id="password" name="password" class="input-block-level" tabindex="1" />
					</div>
				</div>
				<p>
					<button class="btn btn-large btn-primary input-block-level" name="btnSubmit" value="Sign In" tabindex="1">Sign In</button>
				</p>
				<hr />
				<p><a href="/profile/pw_reminder">forgot your password?</a></p>
				<p>
					Not a Member? <a href="{$DOCROOT}/signup">Sign up here.</a>
				</p>
			</fieldset>
		</div>
		<div class="span6">
		</div>

	</div>



	</form>

</div>
