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
