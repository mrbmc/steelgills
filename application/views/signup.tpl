{include file='header.tpl' title='Sign Up'}
<div class="row">
	<div class="span12">
		
		<form id="userForm" method="post" action="/profile/create/" class="form form-horizontal"> 

		<fieldset>
			<h3>Use your social account</h3>
			<p>Connecting your twitter or facebook account allows you to sign in with those services and publish updates to them.</p>
			<p><a href="/login/twitter"><img src="/images/connect_twitter.png" /></a> &nbsp; <a href="/login/facebook"><img src="/images/connect_facebook.gif" /></a></p>
		</fieldset>

		<h4>-or-</h4>

		<fieldset>
			<h3>Create a SteelGills.com Account</h3>
			{*<div class="control-group">
				<div class="control-label">
					<label>Username</label>
				</div>
				<div class="controls">
					<input type="text" name="username" class="text" />
				</div>
			</div>*}
			<div class="control-group">
				<div class="control-label">
					<label>Email</label>
				</div>
				<div class="controls">
					<span><input type="text" name="email" class="text" value="{$USER.email}" /></span>
					<span class="status"></span>
				</div>
			</div>
			<div class="control-group">
				<div class="control-label">
					<label>Password</label>
				</div>
				<div class="controls">
					<span><input type="password" id="password" name="password" class="text" /></span>
					<span class="status" id="pw_status"></span>
				</div>
			</div>
			{*<div class="control-group">
				<div class="control-label">
					<label>Confirm Password</label>
				</div>
				<div class="controls">
					<span><input type="password" id="password_confirm" name="password_confirm" class="text" /></span>
					<span class="status"></span>
				</div>
			</div>*}
			<div class="control-group">
				<div class="controls">
					<span id="captchaImage">{include file="captcha.tpl" captcha=$DATA.captcha}</span>
					<span class="status" style="margin-left:200px;"></span> 
				</div>
			</div>
			<div class="control-group">
				<div class="control-label">
					
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


{include file='footer.tpl'}


<script type="text/javascript" src="/js/lib/jquery-validation/dist/jquery.validate.js"></script> 

{literal}<script type="text/javascript">/*<![CDATA[*/

// $(document).ready(function() {
if(typeof SG == 'undefined') var SG = {};
SG.init_page = function () {
	// $("#password").keyup(function(){
	// 	$("#pw_status").html(passwordStrength($("#password").val(),""));
	// });

	// validate signup form on keyup and submit
	var validator = $("#userForm").validate({
		rules: {
			// username: {
			// 	required: true,
			// 	minlength: 5,
			// 	remote: "/profile/username_unique/"
			// },
			password: {
				required: true,
				minlength: 5
			},
			// password_confirm: {
			// 	required: true,
			// 	minlength: 5,
			// 	equalTo: "#password"
			// },
			email: {
				required: true,
				email: true,
				remote: "/profile/email_unique/"
			},
			captcha: {
				required: true,
				remote: "/captcha/validate"
			}
		},
		messages: {
			// username: {
			// 	required: "Required",
			// 	minlength: jQuery.format("Enter at least {0} characters"),
			// 	remote: jQuery.format("That username is already in use")
			// },
			email: {
				required: "Please enter a valid email address",
				minlength: "Please enter a valid email address",
				remote: $.validator.format("That email is already in use")
			},
			password: {
				required: "Provide a password",
				rangelength: $.validator.format("Enter at least {0} characters")
			},
			// password_confirm: {
			// 	required: "Repeat your password",
			// 	minlength: jQuery.format("Enter at least {0} characters"),
			// 	equalTo: "Enter the same password as above"
			// },
			captcha: "Please review your selection"
		},
		// the errorPlacement has to take the table layout into account
		errorPlacement: function(error, element) {
			if ( element.is(":radio") )
				error.appendTo( element.parent().next().next() );
			else if ( element.is(":checkbox") )
				error.appendTo ( element.parent().next() );
			else
				error.appendTo( element.parent() );
		},
		// set this class to error-labels to indicate valid fields
		success: function(label) {
			// set &nbsp; as text for IE
			label.html("&nbsp;").addClass("checked");
		}
	});
}
/*]]>*/</script>{/literal}
