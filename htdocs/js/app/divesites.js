define(['../app'], function($,_) {
	// console.log('map key',SG.map_key);
	// console.log('requirejs',requirejs.config);
    require(['components/DivesiteMap'],function(){
    	// var $ = require('jquery'),
    	// 	_ = require('underscore'),
    	// 	m = arguments[0];
		SG.map = arguments[0];
		SG.map.init({
			markers: SG.map_markers,
			scope: SG.map_scope
		});
		// console.log('map',SG.map);
    	// console.log('sites',SG.markers);

		// SG.map.scope = {/literal}"{$DISPATCHER.action}"{literal};
		// SG.map.key = "{/literal}{$CONFIG.GOOGLE_API_KEY}{literal}";
		// if(getCookie('tab-map')!="tab-list") {
		// 	SG.map.init();
		// }

    });
});