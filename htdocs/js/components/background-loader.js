define(["jquery"], function() {
    var FLICKR_KEY = "41392a7d72d8ac7bd82ae6b2006dc61a";
    var FLICKR_SECRET = "57bd6c9b8bd55ad6";
    var flickrCall= "http://api.flickr.com/services/rest/?";
        flickrCall+= "&api_key="+FLICKR_KEY;
        flickrCall+= "&method=flickr.photos.search";
        flickrCall+= "&safe_search=1&format=json&nojsoncallback=1";
        flickrCall+= "&content_type=1";
        flickrCall+= "&per_page=1";
        flickrCall+= "&page="+Math.round(Math.random()*500);
        flickrCall+= "&sort=interestingness-desc";
        flickrCall+= "&license=4,5,6,7,8";
        flickrCall+= "&extras=owner_name";
        flickrCall+= "&tags=scuba,reef";
        // flickrCall+= "&auth_token=72157639992305893-5590d37efd959709&api_sig=92b7eba92ed1b05aefba1f6f559068f8";
    $.getJSON(flickrCall, function(data){
        var idx = 0;//Math.round(Math.random() * data.photos.photo.length),
            item = data.photos.photo[idx],
            url = "http://farm"+ item['farm'] + ".staticflickr.com/"+item['server']+"/"+item['id']+"_"+item['secret']+".jpg";
        $('.wallpaper').css('background-image','url('+url+')');
        $('.caption','.wallpaper').text("\u00a9 "+item.ownername);
    });
    return {};
});