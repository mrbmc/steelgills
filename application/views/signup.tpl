{include file='header.tpl' title='Sign Up'}
<div class="row">
	<div class="span12">
		
		<form id="userForm" method="post" action="/profile/create/" class="form form-horizontal"> 

		<fieldset>
			<h3>Use your social account</h3>
			<p>Connecting your twitter or facebook account allows you to sign in with those services and publish updates to them.</p>
			<p><a href="/login/twitter"><img src="/images/connect_twitter.png" /></a> &nbsp; <a href="/login/facebook"><img src="/images/connect_facebook.gif" /></a></p>

			<h4 class="or">Or</h4>

			<h3>Use your email</h3>
			{*<div class="control-group">
				<div class="control-label">
					<label>Username</label>
				</div>
				<div class="controls">
					<input type="text" name="username" class="input-large" />
				</div>
			</div>*}
			<div class="control-group">
				<div class="control-label">
					<label>Email</label>
				</div>
				<div class="controls">
					<input type="email" name="email" class="input-large" value="{$USER.email}" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<div class="control-label">
					<label>Password</label>
				</div>
				<div class="controls">
					<input type="password" id="password" name="password" class="input-large" />
					<span class="help-inline"></span>
				</div>
			</div>
			{*<div class="control-group">
				<div class="control-label">
					<label>Confirm Password</label>
				</div>
				<div class="controls">
					<span><input type="password" id="password_confirm" name="password_confirm" class="text" /></span>
					<span class="help-inline"></span>
				</div>
			</div>*}
			{include file="captcha.tpl" captcha=$DATA.captcha}
			<div class="control-group">
				<div class="control-label">
					&nbsp;
				</div>
				<div class="controls">
					
					<label for="input-newsletter">
						<input type="checkbox" id="input-newsletter" name="newsletter" value="true" checked="checked" />
						Can we email you updates?
					</label> 
					<span class="status"></span> 
				</div>
			</div>
			<div class="control-group">
				<div class="control-label">
					<label></label>
				</div>
				<div class="controls">
					<span><input type="submit" class="btn btn-primary" id="user_create_submit" name="Submit" tabindex="7" value="Create my account" /></span>
				</div>
			</div>
		</fieldset>

		</form>
	</div>
</div>


{include file='footer.tpl' module_js='app/signup'}