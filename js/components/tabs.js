define(["jquery","cookie"], function($) {
	return {
		init:function () {
			$("a",'.tabs').click(function (e) {
				e.preventDefault();
				var me = $(this),
					mom = me.closest('.tabs'),
					tab = me.attr("href"),
					cookie_key = me.attr('rel'),
					cookie_val = tab.substr(1);

				$(".active",".tabs").removeClass("active");
				me.closest('li').addClass("active");

				$(".active",".tab-content").removeClass("active");
				$(tab).addClass("active");

				if(cookie_key=="" || cookie_key==undefined) cookie_key = "tab";
				$.cookie(cookie_key,cookie_val,99);
			});
		}
	}
});