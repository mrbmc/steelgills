{
    appDir: '../htdocs',
    baseUrl: 'js/lib',
    // mainConfigFile: 'app.js',
    paths: {
        app: '../steelgills'
    },
    dir: '../dist',
    modules: [
        //First set up the common build layer.
        {
            //module names are relative to baseUrl
            name: '../steelgills',
            //List common dependencies here. Only need to list
            //top level dependencies, "include" will find
            //nested dependencies.
            include: [
            ]
        },

        //Now set up a build layer for each page, but exclude
        //the common one. "exclude" will exclude nested
        //the nested, built dependencies from "common". Any
        //"exclude" that includes built modules should be
        //listed before the build layer that wants to exclude it.
        //"include" the appropriate "app/main*" module since by default
        //it will not get added to the build since it is loaded by a nested
        //require in the page*.js files.
        {
            //module names are relative to baseUrl/paths config
            name: '../app/divesites',
            exclude: ['../steelgills']
        },
        {
            //module names are relative to baseUrl
            name: '../app/profile',
            exclude: ['../steelgills']
        }

    ]
}
