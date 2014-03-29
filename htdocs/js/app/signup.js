define(['../steelgills'], function(sg) {
    // require(['jquery'], function($) {
	    require(['validate'], function(foo) {
			var validator = $("#userForm").validate({
				ignore: [],
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
						// required: "Please enter a valid email address",
						// minlength: "Please enter a valid email address",
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
					captcha: {
						required: "Please prove you're not a robot",
						remote: $.validator.format("Are you a robot?")
					}
				},
				// the errorPlacement has to take the table layout into account
				errorPlacement: function(error, element) {
					// if ( element.is(":radio") )
					// 	error.appendTo( element.parent().next().next() );
					// else if ( element.is(":checkbox") )
					// 	error.appendTo ( element.parent().next() );
					// else
					// 	error.appendTo( element.parent() );
					var t = element.next('.help-inline');
						error.appendTo( t );
				},
				// set this class to error-labels to indicate valid fields
				success: function(label) {
					// set &nbsp; as text for IE
					label.html("&nbsp;").addClass("checked");
				}
			});
	    });//require
    // });//require
});//define