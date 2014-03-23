define(["../steelgills"], function($) {
    require(['jquery','components/flickr'],function($,flickr){
    	flickr.loadImages('scuba,reef',function(data){
	        $('.wallpaper').css('background-image','url(' + data[0]['src'] + ')');
	        $('.caption','.wallpaper').text("\u00a9 " + data[0]['ownername']);
	    },
	    Math.round(Math.random()*500),1);
    });
});