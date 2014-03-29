define(['../steelgills'], function($) {
    require(['jquery','components/flickr'],function($,flickr){
    	flickr.loadImages('scuba',function(data){
	        $('.wallpaper').css('background-image','url(' + data[0]['src'] + ')');
	        $('.caption','.wallpaper').text("\u00a9 " + data[0]['ownername'] + " on flickr");
	    },
	    Math.round(Math.random()*500),1);
    });
});