define(['../steelgills',"../components/tabs"], function($,tabs) {
	tabs.init();
    require(['components/DivesiteMap'],function(){
		SG.map = arguments[0];
		SG.map.init({
			markers: SG.map_markers,
			scope: SG.map_scope
		});
    });
});