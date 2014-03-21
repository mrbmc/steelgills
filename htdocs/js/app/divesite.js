define(['../app'], function($,_) {
    require(['components/DivesiteMap'],function(){
		SG.map = arguments[0];
		var Divesite = {
			drawMap: function() {
				SG.map.center = DivesiteData.marker.point;
				SG.map.init();
				SG.map.addMarker(DivesiteData.marker);
				SG.map.map.setZoom(11);
			},
			loadImages: function() {
				var FLICKR_KEY = "{/literal}{$CONFIG.FLICKR_KEY}{literal}",
					FLICKR_SECRET = "{/literal}{$CONFIG.FLICKR_SECRET}{literal}",
					flickrCall = "http://api.flickr.com/services/rest/?";
				    flickrCall += "&api_key="+FLICKR_KEY;
				    flickrCall += "&method=flickr.photos.search";
				    flickrCall += "&safe_search=1&format=json&nojsoncallback=1";
				    flickrCall += "&content_type=1";
				    // flickrCall += "&per_page=10";
				    flickrCall += "&page=1";
				    flickrCall += "&sort=interestingness-desc";
				    //flickrCall += "&license=4,5,6,7,8";
				    flickrCall += "&extras=owner_name";
				    flickrCall += "&tags={/literal}{$DATA.divesite.title}{literal}";
				    // flickrCall += "&auth_token=72157639992305893-5590d37efd959709&api_sig=92b7eba92ed1b05aefba1f6f559068f8";
			    $.getJSON(flickrCall, function(data){
					for(i=0,max=Math.min(12,data.photos.photo.length);i<max;i++) {
				        var item = data.photos.photo[i],
				        	url = "http://farm"+ item['farm'] + ".staticflickr.com/"+item['server']+"/"+item['id']+"_"+item['secret']+".jpg";
					    $('.divesite-images').append($('<div class="span2"></div>').append($('<img class="thumbnail" />').attr('src',url)));
					}
			    });
			}
		}
		Divesite.drawMap();
		return Divesite;
    });
});