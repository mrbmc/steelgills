requirejs.config({
	baseUrl: "/js/lib",
	paths: {
		app: "../app"
		,components: "../components"
		,jquery: "jquery-2.0.3.min"
		,underscore: "underscore/underscore-min"
		,async: "requirejs-plugins/src/async"
		,validate: "jquery-validation/dist/jquery.validate"
		,cookie: "jquery-cookie/jquery.cookie"
		,autocomplete: "jquery-autocomplete/src/jquery.autocomplete"
		,typeahead: "twitter-typeahead/dist/typeahead.jquery"
        // ,EventEmitter: 'bower_components/event-emitter/dist/EventEmitter'
        // ,GA: 'bower_components/requirejs-google-analytics/dist/GoogleAnalytics'
    },
    config: {
		'GA': {
			'id' : 'UA-4173628-3'
		}
    },
    shim: {
        'jquery': 				{ exports: "$" },
        'jquery.validate': 		{ deps: ['jquery'] },
        'jquery.autocomplete': 	{ deps: ['jquery'] },
        'cookie': 				{ deps: ['jquery'] },
        'underscore': 			{ exports: "_" },
        'gmaps': 				{ deps: ['jquery'] }
    }
});
