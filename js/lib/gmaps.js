define('gmaps', ['async!http://maps.google.com/maps/api/js?v=3&sensor=false&key='+SG.map_key],function(){
	    // return the gmaps namespace for brevity
	    return window.google.maps;
});