define(['../steelgills'], function($,_) {
    require(['components/DivesiteMap'],function(map){
    	SG.map = map;
    	SG.map.init();
    });
    require(['jquery'],function($){
		$("#city").change(function(){
			address = $(this).val();// + ", " + $("#country").val();

			marker = SG.map.addMarker({point:address,description:address,draggable:true});
			console.log('marker',marker);
			SG.map.map.setZoom(11);
			SG.map.map.setCenter(marker.position);
			if(marker!='geocoding') {
				// SG.map.updateLatLon(marker.position);
				// SG.map.refreshBounds('all');
			}
			/*
			*/
		});
    });
});