define(["jquery"], function($) {
    return {
        key: "41392a7d72d8ac7bd82ae6b2006dc61a",
        secret: "57bd6c9b8bd55ad6",
        callback: function() {

        },
        getURL: function (tags,page,perpage) {
            var uri = "http://api.flickr.com/services/rest/?";
                uri+= "&api_key=" + this.key;
                uri+= "&method=flickr.photos.search";
                uri+= "&format=jsonp";
                uri+= "&safe_search=1";
                uri+= "&nojsoncallback=1";
                uri+= "&jsoncallback=SG.flickr.onload";
                uri+= "&content_type=1";
                uri+= "&page="+page;
                uri+= "&per_page="+perpage;
                uri+= "&sort=interestingness-desc";
                uri+= "&license=4,5,6,7,8";
                uri+= "&extras=owner_name";
                uri+= "&tags=" + tags.join();
            return uri;
        },
        getImageSource: function (item) {
            console.log('flickr.getImageSource',item);
            //https://www.flickr.com/services/api/misc.urls.html
            src = "http://farm" + item['farm'];
            src += ".staticflickr.com/";
            src += item['server'] + "/";
            src += item['id'] +"_";
            src += item['secret'];
            src += "_b";
            src += ".jpg";
            return src;
        },
        loadImages: function(tags,callback,page,perpage) {
            console.log('flickr.loadImages',arguments);
            var page = (page) ? page : 0,
                perpage = (perpage) ? perpage : 1;
                url = this.getURL(tags,page,perpage);
                this.callback = callback;
            $.ajax({
                url: url,

                // The name of the callback parameter, as specified by the YQL service
                // jsonp: "callback",

                // Tell jQuery we're expecting JSONP
                dataType: "jsonp",

                data: {
                    "tags": tags.join(),
                    "format": "json"
                }

            })
        },
        onload: function (data) {
            console.log('flickr.onLoad',arguments);
            // body...
            this.callback(data);
        }
    };
});