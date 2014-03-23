define(["jquery"], function($) {
    return {
        key: "41392a7d72d8ac7bd82ae6b2006dc61a",
        secret: "57bd6c9b8bd55ad6",
        getURL: function (tags,page,perpage) {
            var uri = "http://api.flickr.com/services/rest/?";
                uri+= "&api_key=" + this.key;
                uri+= "&method=flickr.photos.search";
                uri+= "&safe_search=1&format=json&nojsoncallback=1";
                uri+= "&content_type=1";
                uri+= "&page="+page;
                uri+= "&per_page="+perpage;
                uri+= "&sort=interestingness-desc";
                uri+= "&license=4,5,6,7,8";
                uri+= "&extras=owner_name";
                uri+= "&tags="+tags;
            return uri;
        },
        loadImages: function(tags,callback,page,perpage) {
            var page = (page) ? page : 0,
                perpage = (perpage) ? perpage : 1;
            $.getJSON(this.getURL(tags,page,perpage), function(data){
                var item,src;
                for(var i=0,max=data.photos.photo.length;i<max;i++) {
                    item = data.photos.photo[i];
                    src =   "http://farm"+ item['farm'] +
                            ".staticflickr.com/" +
                            item['server'] + "/" +
                            item['id']+"_"+item['secret']+".jpg";
                    item['src'] = src;
                }
                callback(data.photos.photo);
            });
        }
    };
});