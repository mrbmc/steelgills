define(["jquery", "underscore"], function($) {

	// if(typeof SG == 'undefined') var SG = {};
	// var pageInitialized = false;

	Array.prototype.size = function () {
		var l = 0;
		for (var k in this) {
			l++;
		}
		return l;
	}
	Array.prototype.contains = function (s) {
		for(var i in this) {
			if(this[i]==s)
				return i;
		}
		return false;
	} 
	function setCookie(c_name,value,expiredays) {
		var exdate=new Date();
		exdate.setDate(exdate.getDate()+expiredays);
		console.log("setCookie:" + c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";path=/;expires="+exdate.toUTCString()));
		document.cookie = c_name+ "=" +escape(value)+((expiredays==null) ? "" : ";expires="+exdate.toUTCString());
	}
	function getCookie(c_name) {
		if (document.cookie.length>0) {
			c_start=document.cookie.indexOf(c_name + "=");
			if (c_start!=-1) {
				c_start=c_start + c_name.length+1;
				c_end=document.cookie.indexOf(";",c_start);
				if (c_end==-1) c_end=document.cookie.length;
				_return = unescape(document.cookie.substring(c_start,c_end));
				console.log("getCookie:"+c_name+'='+_return);
				return _return
			}
		}
		return "";
	}

});

