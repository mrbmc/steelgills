requirejs.config({
	"baseUrl": "/js/lib",
	"paths": {
		app: "../app",
		components: "../components",
		jquery: ["jquery"],
		underscore: "underscore/underscore-min",
		async: "requirejs-plugins/src/async",
		validate: "jquery-validation/dist/jquery.validate",
		cookie: "jquery-cookie/jquery.cookie"
    },
    shim: {
        'jquery': 				{ exports: "$" },
        'jquery.validate': 		{ deps: ['jquery'] },
        'jquery.autocomplete': 	{ deps: ['jquery'] },
        'cookie': 				{ deps: ['jquery'] },
        'underscore': 			{ exports: "_" },
        'gmaps': 				{ deps: ['jquery'] }
    }
});

// requirejs(["jquery", "underscore", "components/modal","components/tabs"], function ($, canvas, sub) {
// });
	// Array.prototype.size = function () {
	// 	var l = 0;
	// 	for (var k in this) {
	// 		l++;
	// 	}
	// 	return l;
	// }
	// Array.prototype.contains = function (s) {
	// 	for(var i in this) {
	// 		if(this[i]==s)
	// 			return i;
	// 	}
	// 	return false;
	// } 

 //    $.setCookie = function (c_name,value,expiredays) {
	// 	var exdate=new Date();
	// 	exdate.setDate(exdate.getDate()+expiredays);
	// 	// console.log("setCookie:" + c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";path=/;expires="+exdate.toUTCString()));
	// 	document.cookie = c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";expires="+exdate.toUTCString());
	// }
	// $.getCookie = function (c_name) {
	// 	if (document.cookie.length>0) {
	// 		c_start=document.cookie.indexOf(c_name + "=");
	// 		if (c_start!=-1) {
	// 			c_start=c_start + c_name.length+1;
	// 			c_end=document.cookie.indexOf(";",c_start);
	// 			if (c_end==-1) c_end=document.cookie.length;
	// 			_return = unescape(document.cookie.substring(c_start,c_end));
	// 			// console.log("getCookie:"+c_name+'='+_return);
	// 			return _return
	// 		}
	// 	}
	// 	return "";
	// }

// });