define(['../steelgills'], function($) {
    require(['jquery','components/DivesiteMap','../components/tabs'],function($,map,tabs){
    	console.log('Divesites',arguments);

		SG.map = arguments[1];
		SG.map.init({
			// markers: SG.map_markers,
			scope: SG.map_scope
		});

    });
});