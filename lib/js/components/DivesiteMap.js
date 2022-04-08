define(['jquery','underscore','gmaps'], function($,_,gmap) {
	// console.log('google maps is ready',gmap)
	return {
		ajaxLoading: false,
		gmapsKey: "AIzaSyC4X3vWcyvm3edkIiTBI0zwwn1Hwxk0fDE",
		apibase: "https://kkt5rh62j7.execute-api.us-east-1.amazonaws.com/dev",
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
		key: "",
		map : false,
		gmap : gmap,
		mapType : "state",
		markerLibrary : new Array(),
		markers : {},
		targetDiv : 'map_canvas',
		scope: "all",
		zoom : 2,

		addMarker: function (m) {
			console.log('DivesiteMap.addMarker',m);

			if((m instanceof Object) && this.markerLibrary[m.id]!=undefined) {
				marker = this.markerLibrary[m.id];
				m = this.validatePoint(m);
				marker.setPosition(m.point);
			} else {
				m = this.validatePoint(m);
				var markerOptions = { 
					icon: this.iconImage, 
					draggable:( (typeof m.draggable != undefined) ? m.draggable : false),
					position: m.point,
					map: this.map,
					title: m.description,
				}
				var marker = new gmap.Marker(markerOptions);

				gmap.event.addListener(marker, 'click', function (event) {
					for (var i in SG.map.markerLibrary) {
						if(SG.map.markerLibrary[i] instanceof gmap.Marker)
							SG.map.markerLibrary[i].infowindow.close();
					}
					this.infowindow.open(SG.map.map);
		 		});
				if(typeof m.draggable != undefined) {
					gmap.event.addListener(marker, "dragend", function() {
						this.updateLatLon(this.getPosition());
						this.infowindow.setPosition(this.getPosition());
					});
				}
				this.markerLibrary[m.id] = marker;
			}

			marker.infowindow = new gmap.InfoWindow();
			marker.infowindow.setContent(m.description);
			marker.infowindow.setPosition(m.point);

			return marker;
		},

		centerMap: function (_point) {
			var point = (_point!=undefined) ? new gmap.LatLng(_point.latitude,_point.longitude) : this.bounds.getCenter();
			var zoom = (_point!=undefined) ? _point.zoom : Math.min(this.map.getBoundsZoomLevel(this.bounds),13);
			this.center = point;
			this.map.setCenter(point, zoom); 
			//console.log(point);
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
					//initialLocation = new gmap.LatLng(position.coords.latitude,position.coords.longitude);
					//map.setCenter(initialLocation);
					return this.centerMap({latitude:position.coords.latitude,longitude:position.coords.longitude,zoom:17});
				}, function() {
				  console.log('no geolocation available');
				  return false;
				});
			}
		},

		getGeocode : function(m) {
			// console.log('geocode');
			this.geocoder.geocode(
				{ 'address': m.point},
				function(results,status) {
					if (status == gmap.GeocoderStatus.OK) {
						m.point = results[0].geometry.location;
						//console.log('geocode.complete');
						marker = SG.map.addMarker(m);
						if(typeof geocodeCallback !== "undefined") {
							geocodeCallback(marker);
						}
					} else {
						console.log("Geocode was not successful for the following reason: " + status);
					}
				}
			);
			return "geocoding";
		},

		init: function () {
			console.log("SG.map.init",arguments);

			if(typeof arguments != "undefined" && arguments.length>0) {
				if(typeof arguments[0] === "object")
					_.extend(this,arguments[0]);
				else 
					_.extend(this,arguments[0]);
			}

		    var mapOptions = {
				zoom: this.zoom,
				center: new gmap.LatLng(this.center.latitude,this.center.longitude),
				mapTypeId: gmap.MapTypeId.SATELLITE,
				mapTypeControl: true,
				mapTypeControlOptions: {style: gmap.MapTypeControlStyle.DROPDOWN_MENU},
				navigationControl: true,
				navigationControlOptions: {style: gmap.NavigationControlStyle.SMALL},
		    };

		    this.map = new this.gmap.Map(document.getElementById("map_canvas"),mapOptions);
			this.geocoder = new window.google.maps.Geocoder();
			this.bounds = new gmap.LatLngBounds();

			if(this.markers.length>0) {
				this.redrawMarkers();
				//this.map.fitBounds(this.bounds);
				// this.center = this.bounds.getCenter();
				gmap.event.addListener(SG.map.map, "dragend", function(){SG.map.refreshBounds();});
				gmap.event.addListener(SG.map.map, "zoom_changed", function(){SG.map.refreshBounds();});
			} else {
				this.refreshBounds();
			}
		},

		redraw: function () {
			// console.log('redraw');
			if(!this.map) {
				return this.init();
			}
			this.redrawMarkers();
			this.map.fitBounds(this.bounds);
		},

		/**
		 * Loads markers based on the bounds of the map
		 * */
		refreshBounds: function (args) {
			// console.log('refreshBounds');
			if(this.ajaxLoading) return;
			// var bounds = this.map.getBounds(),
			// 	ne = bounds.getNorthEast(),
			// 	sw = bounds.getSouthWest();

			this.loadMarkers(
				// ne.lat()
				// ,sw.lat()
				// ,ne.lng()
				// ,sw.lng()
			);
		},

		redrawMarkers: function () {
			console.log('DivesiteMap.redrawMarkers:'+this.markers.length,arguments);
			if(this.markers.length>0) {
				for(idx in this.markers) {
					var m = this.markers[idx];
						m.title = (m.title=="") ? (m.city+', ' + m.country) : m.title;
						m.info = '<a href="/divesites/#/'+m.slug+'">'+m.title+'</a>';
						m.info += '<br />';
						m.info += (m.city!=null) ? m.city+', ' : '';
						m.info += m.country;
						//m.info += '<br /><small>'+m.latitude+' x '+m.longitude+'</small>';				
					if(m.latitude!=undefined && m.longitude!=undefined) {
						params = {
							point: {
								latitude: Number(m.latitude), 
								longitude: Number(m.longitude)
							},
							description:m.info,
							id:m.slug 
						}
						this.addMarker(params);
					} else if(m.street!=undefined) {
						this.getGeocode({point:m.street,description:m.street,id:m.divesiteid});
					}
				}
	  			// var m = this.markers[0];
		    } else {
		    	console.log('no new markers');
		    }
		    return this.markers;
		},

		updateLatLon: function (point) {
			var arr = point.toString().split(",");
			$("#latitude").val(arr[0].substr(1));
			$("#longitude").val(arr[1].substr(0,arr[1].length-1));
		},

		loadMarkers: function (nw,ne,se,sw) {
			console.log('DivesiteMap.loadMarkers',arguments);
			// url = apibase + '/divesites/' + this.scope + '.json?q='+sw.lng() + "," + sw.lat() + "," +ne.lng() + "," + ne.lat();
			url = this.apibase;
			url += "/divesites/?";
			url += "&limit=20";
			url += "&offset=0";
			// url += sw.lng() + "," + sw.lat() + "," +ne.lng() + "," + ne.lat();

			this.ajaxLoading=true;
			$.ajax({
				  url: url,
				  dataType: 'json',
				  data: {},
				  success: function(data) {
						// SG.map.markers = _.uniq($.merge(SG.map.markers,data));
						// console.log(SG.map.markers.length);
						SG.map.markers = data;
						SG.map.redrawMarkers();
						SG.map.ajaxLoading=false;
					}
				});

		},
		
		validatePoint: function (m) {
			console.log('DivesiteMap.validatePoint',m);
			if(m instanceof String) {
				return this.getGeocode(m);
			} else if((m instanceof Object) && typeof m.point == 'string') {
				return this.getGeocode(m);
			} else if(!(m.point instanceof gmap.LatLng)) {
				m.point = new gmap.LatLng(m.point.latitude, m.point.longitude);
			}
			this.bounds.extend(m.point);
			return m;
		},

	}
});