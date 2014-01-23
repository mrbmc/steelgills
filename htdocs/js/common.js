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
			tab = me.attr("href");
		$(".selected",mom).removeClass("selected");
		$(".tab-pane").slideUp(250);
		$(this).closest('li').addClass("selected");
		$(tab).slideDown(250,function(){
			// if(typeof SGMap != "undefined" && !SGMap.map) {
			// 	map_init();
			// }else if(SGMap.map){
			// 	SGMap.redraw();
			// }
		});
		var cookie_name = $(this).attr("rel");
		if(cookie_name=="" || cookie_name==undefined) cookie_name = "tab";
		setCookie(cookie_name,tab,99);
	});
}

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
SGModal = {
	url: "",
	selector: function () {
		return $('#'+SGModal.targetDiv);
	},
	openModal: function (url) {
		if($('#modal').length <= 0) {
			$('body').append('<div id="modal" class="fade"></div>');
			$('body').append('<div id="modal_bg"></div>');
		}
		$('#modal').load(url,function () {
			$('#modal_bg').fadeIn(250,function () {
				$('#modal').show().toggleClass("in");
				$('#modal').append('<div id="modal_close"><a href="#" onclick="SGModal.closeModal();return false;">&times;</a></div>');
			});
	    $(window).keydown(function(event){
	    	if(event.keyCode==27) { SGModal.closeModal(); }
	    });
		});
	},
	closeModal: function () {
		$('#modal').toggleClass("in");
		$('#modal_bg').fadeOut(500);
	}
}

$(document).ready(function () {
	init_tabs();
});
