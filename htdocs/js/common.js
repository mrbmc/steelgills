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
function init_tabs() {
	$("a",'.tabs').click(function (e) {
		e.preventDefault();
		var me = $(this),
			mom = me.closest('.tabs'),
			tab = me.attr("href"),
			cookie_key = me.attr('rel'),
			cookie_val = tab.substr(1);
		$(".active",mom).removeClass("active");
		$(".tab-pane").slideUp(250);
		$(this).closest('li').addClass("active");
		$(tab).slideDown(250);
		console.log('set cookie '+cookie_key+": ",cookie_val);
		if(cookie_key=="" || cookie_key==undefined) cookie_key = "tab";
		setCookie(cookie_key,cookie_val,99);
	});
}

if(typeof SG == 'undefined') var SG = {};

SG.Modal = {
	url: "",
	selector: function () {
		return $('#'+SG.Modal.targetDiv);
	},
	openModal: function (url) {
		console.log('open modal:',url);
		var _modal = $('#sg-modal');
		if(_modal.length<=0) {
			_modal = $('<div id="sg-modal" class="modal fade"></div>');
			_modal.append('<a href="#" class="close">&times;</a>');
			_modal.append('<div class="modal-body"></div>');
			$('body').append(_modal);
		}
		$('.modal-body',_modal).load(url,function () {
			$(this).closest(".modal").toggleClass('in');
		    $(window).keydown(function(event){
		    	if(event.keyCode==27) { SG.Modal.closeModal(); }
		    });
		});
		$('.close','.modal').bind('click',function(e){
			$(this).closest('.modal').toggleClass("in",false);
		})
	},
	closeModal: function () {
		$('.modal').toggleClass("in",false);
	}
}

$(document).ready(function () {
	init_tabs();
	if(typeof SG.init_page != undefined) {
		SG.init_page();
	}
});
