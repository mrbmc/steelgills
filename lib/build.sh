#!/bin/bash

css=0
javascript=1
services=0
version=3.1.4

while getopts 'scj?' OPTION
	do
	  case $OPTION in
	  c)	css="1";;
	  s)	services="1";;
	  j)	javascript="1";;
	  ?)	printf "Usage: %s: sh minifier.sh [-c (css)] [-j (js)] [-s (services)]\n" $(basename $0) >&2
			exit 2
			;;
	  esac
	done
shift $(($OPTIND - 1))


echo "Compilng CSS";
if [ $css = "1" ];
then
	echo "minifying web/screen.css"
	java -jar ./bin/yuicompressor-2.4.2.jar --type css ./htdocs/css/screen.css > ./htdocs/css/screen.min.css
	echo "minifying web/mobile.css"
	java -jar ./bin/yuicompressor-2.4.2.jar --type css ./htdocs/css/mobile.css > ./htdocs/css/mobile.min.css
fi

echo "Compilng Javascript";
if [ $javascript = "1" ];
then
	# echo "minifying jquery.js"
	# java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/jquery.js > ./htdocs/js/common.min.js
	# echo "minifying common.js"
	# java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/common.js >> ./htdocs/js/common.min.js
	# echo "minifying maps.js"
	# java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/SGMap.js > ./htdocs/js/SGMap.min.js
	# echo "minifying jquery.validation.js"
	# java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/jquery.validation.js > ./htdocs/js/jquery.validation.min.js
	# echo "minifying password strength meter.js"
	# java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/passwordStrengthMeter.js >> ./htdocs/js/jquery.validation.min.js

	echo "minifying password strength meter.js"
	java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/passwordStrengthMeter.js >> ./htdocs/js/jquery.validation.min.js
fi

echo "Compilng Services";
if [ $services = "1" ];
then
	echo "clearing services.js"
	`echo "" > ./htdocs/js/services.min.js`

	echo "updating googleanalytics js"
	curl -s "http://www.google-analytics.com/ga.js" > ./htdocs/js/services/ga.js
	java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/services/ga.js >> ./htdocs/js/services.min.js

	echo "updating facebook connect js"
	curl -s "http://static.ak.connect.facebook.com/js/api_lib/v0.4/FeatureLoader.js.php/en_US" > web/js/services/facebook.js
	java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/services/facebook.js >> ./htdocs/js/services.min.js
	java -jar ./bin/yuicompressor-2.4.2.jar --type js --nomunge ./htdocs/js/facebook.js >> ./htdocs/js/services.min.js
fi
