{include file='header.tpl' title='Sign Up'}

<script type="text/javascript" src="/js/lib/jquery-validation/jquery.validate.js"></script> 

{literal}<script type="text/javascript">/*<![CDATA[*/

$(document).ready(function() {
	$("#password").keyup(function(){
		$("#pw_status").html(passwordStrength($("#password").val(),""));
	});
	// validate signup form on keyup and submit
	var validator = $("#userForm").validate({
		rules: {
			username: {
				required: true,
				minlength: 5,
				remote: "/profile/username_unique/"
			},
			password: {
				required: true,
				minlength: 5
			},
			password_confirm: {
				required: true,
				minlength: 5,
				equalTo: "#password"
			},
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
			username: {
				required: "Required",
				minlength: jQuery.format("Enter at least {0} characters"),
				remote: jQuery.format("That username is already in use")
			},
			email: {
				required: "Please enter a valid email address",
				minlength: "Please enter a valid email address",
				remote: jQuery.format("That email is already in use")
			},
			password: {
				required: "Provide a password",
				rangelength: jQuery.format("Enter at least {0} characters")
			},
			password_confirm: {
				required: "Repeat your password",
				minlength: jQuery.format("Enter at least {0} characters"),
				equalTo: "Enter the same password as above"
			},
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
});
/*]]>*/</script>{/literal}
 

<fieldset>
<legend>Use your social account</legend>
<small>Connecting your twitter or facebook account <br />
allows you to sign in with those services and publish <br />
updates to them.</small>
<p><a href="/login/twitter"><img src="/images/connect_twitter.png" /></a> &nbsp; <a href="/login/facebook"><img src="/images/connect_facebook.gif" /></a></p>
</fieldset>


<h3>-or-</h3>

<form id="userForm" method="post" action="/profile/create/"> 

<fieldset>
<legend>Create a SteelGills.com Account</legend>
<div>
	<label>Username</label>
	<input type="text" name="username" class="text" />
</div>
<div>
	<label>Email</label>
	<span><input type="text" name="email" class="text" value="{$USER.email}" /></span>
	<span class="status"></span>
</div>

<div>
	<label>Password</label>
	<span><input type="password" id="password" name="password" class="text" /></span>
	<span class="status" id="pw_status"></span>
</div>
<div>
	<label>Confirm Password</label>
	<span><input type="password" id="password_confirm" name="password_confirm" class="text" /></span>
	<span class="status"></span>
</div>
<div>
	<span id="captchaImage">{include file="captcha.tpl" captcha=$DATA.captcha}</span>
	<span class="status" style="margin-left:200px;"></span> 
</div>
<div>
	<label>Can we email you updates?</label> 
	<span><input type="checkbox" id="newsletter" name="newsletter" value="true" checked="checked" /></span> 
	<span class="status"></span> 
</div>
<div>
	<label></label>
	<span><input type="submit" class="button" id="user_create_submit" name="Submit" tabindex="7" value="Create my account" /></span>
</div>
</fieldset>

</form>




{include file='footer.tpl'}