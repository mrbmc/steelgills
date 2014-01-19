<?php

class Js extends Controller {
	private $filename;
	private $filemin;
	
	function __construct () {
		parent::__construct("Contact");
	}
//	java -jar ./bin/yuicompressor-2.4.2.jar --type css ./htdocs/css/screen.css > ./htdocs/css/screen.min.css

	public function index () {
		$id = Dispatcher::instance()->params['id'];
		$this->filename = WEBROOT.'/js/'.$id.'.js';
		$this->filemin = WEBROOT.'/js/'.$id.'.min.js';
		
		if($this->minify()) {
			header("Content-type: text/javascript");
			echo file_get_contents($this->filemin);
			exit;
		} else {
			die('an error occurred');
		}
	}

	private function minify($js=null) {
		/**
		 * get mod time of common
		 * get mod time of minified
		 * if minified is > common then compress
		 * load contents of minified
		 * echo
		 * exit;
		 */

		if($js!=null) {
			$this->filename = WEBROOT.'/js/'.$js.'.js';
			$this->filemin = WEBROOT.'/js/'.$js.'.min.js';
		}

		$modtime = filemtime($this->filename);
		$mintime = filemtime($this->filemin);
		$cmd = "java -jar ".WEBROOT."/../bin/yuicompressor-2.4.2.jar --type js ".$this->filename." > ".$this->filemin;
		//echo $cmd;
		if($modtime > $mintime) {
			exec($cmd);
			return false;
		}
		return true;
	}

	public function common() {
		$this->minify('common');
		$this->minify('jquery');
		$c = WEBROOT.'/js/common.min.js';
		$j = WEBROOT.'/js/query.min.js';
		exec("cat $j >> $c");
		header("Content-type: text/javascript");
		echo file_get_contents($this->filemin);
		exit;
	}
	
}

?>
