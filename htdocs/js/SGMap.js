SGMap = {
	ajaxLoading: false,
	baseIcon : {},
	bounds: {},
	center : {latitude:30,longitude:-90},
	default_lat : 25,
	default_lon : -90,
	defaultPoints: 100,
	geocoder : {},
	icon: {},
	iconImage: "/images/map_icon.png",
	infoWindow : "0",
	map : false,
	mapType : "state",
	markerLibrary : new Array(),
	markers : {},
	targetDiv : 'map_canvas',
	scope: "all",
	zoom : 2,

	addMarker: function (m) {
		if((m instanceof Object) && this.markerLibrary[m.id]!=undefined) {
			marker = this.markerLibrary[m.id];
			m = this.validatePoint(m);
			marker.setPosition(m.point);
		} else {
			m = this.validatePoint(m);
			var markerOptions = { 
				icon:this.iconImage, 
				draggable:(("draggable" in m)?m.draggable:false),
				position: m.point,
				map: this.map,
				title: m.description,
			}
			var marker = new google.maps.Marker(markerOptions);

			google.maps.event.addListener(marker, 'click', function (event) {
				for (var i in SGMap.markerLibrary) {
					if(SGMap.markerLibrary[i] instanceof google.maps.Marker)
						SGMap.markerLibrary[i].infowindow.close();
				}
				this.infowindow.open(SGMap.map);
	 		});
			if("draggable" in m) {
				google.maps.event.addListener(marker, "dragend", function() {
					this.updateLatLon(this.getPosition());
					this.infowindow.setPosition(this.getPosition());
				});
			}
			this.markerLibrary[m.id] = marker;
		}

		marker.infowindow = new google.maps.InfoWindow();
		marker.infowindow.setContent(m.description);
		marker.infowindow.setPosition(m.point);

		return marker;
	},

	centerMap: function (_point) {
		var point = (_point!=undefined) ? new google.maps.LatLng(_point.latitude,_point.longitude) : this.bounds.getCenter();
		var zoom = (_point!=undefined) ? _point.zoom : Math.min(this.map.getBoundsZoomLevel(this.bounds),13);
		console.log(point);
		this.map.setCenter(point, zoom); 
	},

	clearMap: function () {
		for (var i in this.markerLibrary) {
			if(typeof this.markerLibrary[i] == 'function')
				continue;
			this.markerLibrary[i].setMap(null);
			delete this.markerLibrary[i];
		}
		this.markerLibrary.length = 0;
	},
	
	detectLocation: function () {
		if(navigator.geolocation) {
			browserSupportFlag = true;
			navigator.geolocation.getCurrentPosition(function(position) {
				//initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
				//map.setCenter(initialLocation);
				return this.centerMap({latitude:position.coords.latitude,longitude:position.coords.longitude,zoom:17});
			}, function() {
			  console.log('no geolocation available');
			  return false;
			});
		}
	},

	getGeocode : function(m) {
		//console.log('geocode');
		this.geocoder.geocode(
			{ 'address': m.point},
			function(results,status) {
				if (status == google.maps.GeocoderStatus.OK) {
					m.point = results[0].geometry.location;
					//console.log('geocode.complete');
					marker = SGMap.addMarker(m);
					if(geocodeCallback != undefined) {
						geocodeCallback(marker);
					}
				} else {
					console.log("Geocode was not successful for the following reason: " + status);
				}
			}
		);
		return "geocoding";
	},

	init: function (params) {
		if(params && ('target' in params))
			this.targetDiv = params.target;
		if(params && ('point' in params) && ((params.point.latitude + params.point.latitude)!=0))
			this.center = params.point;
		if(params && ('scope' in params))
			this.scope = params.scope;
    var latlng = new google.maps.LatLng(this.center.latitude,this.center.longitude);
    var mapOptions = {
      zoom: this.zoom,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.SATELLITE,
			mapTypeControl: true,
      mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
      navigationControl: true,
      navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL},
    };
    this.map = new google.maps.Map(document.getElementById("map_canvas"),mapOptions);
		this.geocoder = new google.maps.Geocoder();
		this.bounds = new google.maps.LatLngBounds();
		if(this.markers.length != undefined) {
			this.refreshMarkers();
			this.map.fitBounds(this.bounds);
			this.center = this.bounds.getCenter();
		}

	},

	loadScript: function (_callbackName) {
		if(_callbackName==undefined) _callbackName = "map_init";
		var script = document.createElement("script");
		script.type = "text/javascript";
		script.src = "http://maps.google.com/maps/api/js?sensor=false&callback="+_callbackName;
		document.body.appendChild(script);
	},

	redraw: function () {
		if(!this.map)
			return map_init();
		this.refreshMarkers();
		this.map.fitBounds(this.bounds);
	},

	/**
	 * Loads markers based on the bounds of the map
	 * */
	refreshBounds: function (args) {
		if(this.ajaxLoading) return;
		var bounds = this.map.getBounds();
		var sw = bounds.getSouthWest();
		var ne = bounds.getNorthEast();
		url = '/divesites/'+this.scope+'.json?q='+sw.lng() + "," + sw.lat() + "," +ne.lng() + "," + ne.lat();
		this.ajaxLoading=true;
		$.ajax({
			  url: url,
			  dataType: 'json',
			  data: {},
			  success: function(data) {
					// SGMap.markers = _.uniq($.merge(SGMap.markers,data));
					// console.log(SGMap.markers.length);
					SGMap.markers = data;
					SGMap.refreshMarkers();
					SGMap.ajaxLoading=false;
				}
			});
	},

	refreshMarkers: function () {
		console.log()
		if(this.markers.length>0) {
			for(idx in this.markers) {
				var m = this.markers[idx];
				if(m.title=="") m.title = m.city+', '+m.country;
				m.info = '<a href="/divesites/show/'+m.divesiteid+'">'+m.title+'</a>';
				m.info += '<br />';
				if(m.city!=null) m.info += m.city+', '
				m.info += m.country;
				m.info += '<br /><small>'+m.latitude+' x '+m.longitude+'</small>';				
				if(m.latitude!=undefined && m.longitude!=undefined) {
					params = {
						point:{latitude:m.latitude, longitude:m.longitude}, 
						description:m.info, 
						id:m.divesiteid 
					}
					this.addMarker(params);
				}else if(m.street!=undefined) {
					this.getGeocode({point:m.street,description:m.street,id:m.divesiteid});
				}
			}
  			var m = this.markers[0];
	    } else {
	    	console.log('no markers');
	    }
	},

	updateLatLon: function (point) {
		var arr = point.toString().split(",");
		$("#latitude").val(arr[0].substr(1));
		$("#longitude").val(arr[1].substr(0,arr[1].length-1));
	},
	
	validatePoint: function (m) {
			if(m instanceof String) {
				return this.getGeocode(m);
			}else if((m instanceof Object) && typeof m.point == 'string') {
				return this.getGeocode(m);
			} else if(!(m.point instanceof google.maps.LatLng)) {
				m.point = new google.maps.LatLng(m.point.latitude, m.point.longitude);
			}
			this.bounds.extend(m.point);
			return m;
	},

}


