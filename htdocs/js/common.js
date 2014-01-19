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
	$("a.tab").click(function () {
		$(".tabs .selected").removeClass("selected");
		$(this).addClass("selected");
		$(".tabContent").slideUp();
		var content_show = $(this).attr("title");
		$("#"+content_show).slideDown(250,function(){
			if(typeof SGMap != "undefined" && !SGMap.map) {
				map_init();
			}else if(SGMap.map){
				SGMap.redraw();
			}
		});
		var cookie_name = $(this).attr("rel");
		if(cookie_name=="" || cookie_name==undefined) cookie_name = "tab";
		setCookie(cookie_name,content_show,99);
		console.log("tab ("+cookie_name+") = "+content_show);
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
			$('body').append('<div id="modal"></div>');
			$('body').append('<div id="modal_bg"></div>');
		}
		$('#modal').load(url,function () {
			$('#modal_bg').fadeIn(300,function () {
				$('#modal').show();
				$('#modal').append('<div id="modal_close"><a href="#" onclick="SGModal.closeModal();return false;">x</a></div>');
			});
	    $(window).keydown(function(event){
	    	if(event.keyCode==27) { SGModal.closeModal(); }
	    });
		});
	},
	closeModal: function () {
		$('#modal').hide();
		$('#modal_bg').fadeOut(500);
	}
}

$(document).ready(function () {
	init_tabs();
});
