define(['../steelgills'], function($) {
    require(['components/DivesiteMap','../components/tabs'],function(map,tabs){
		SG.map = arguments[0];
		SG.map.init({
			markers: SG.map_markers,
			scope: SG.map_scope
		});
		tabs.init();
    });
});