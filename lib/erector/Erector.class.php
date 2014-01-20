<?php


class Erector {
	public $db;
	
	function __construct() {

		/**
		 * Load the code
		 */
		define('LIB',realpath(getcwd() . "/../lib"));
		define('ERECTOR', LIB . "/erector");
		define('WEBROOT',getcwd());
		define('APP',realpath(getcwd() . "/../application"));
		include_once APP.'/Config.class.php';				//Settings and configuration
		include_once ERECTOR.'/Model.class.php';				//Parent data model class - ORM
		include_once ERECTOR.'/Cache.class.php';					//Data caching
		include_once ERECTOR.'/Controller.class.php';			//Page controller class
		include_once ERECTOR.'/Dispatcher.class.php';			//URL routing and control
		include_once ERECTOR.'/Presenter.class.php';			//View handler
		include_once ERECTOR.'/Session.class.php';				//Session management
		include_once ERECTOR.'/Paginate.class.php';				//List pagination class
		include_once ERECTOR.'/Debugger.class.php';				//Debugging tools

		define('FACEBOOK_PATH', LIB.'/facebook/src/facebook.php');
		include_once FACEBOOK_PATH;			//Facebook applications & pages
		
		/**
		 * Initialize configuration
		 */
		Config::instance();
		
		/**
		 * Establish the Database connection once
		 */ 
		$dsn = Config::instance()->getDSN();
		$class = 'ErectorDB_'.$dsn['type'];
		include_once LIB.'/db/'.$class.'.class.php';
		try {
			if(class_exists($class))
				$this->db = new $class($dsn);
			else
				throw new Exception("The db class ".$class." could not be created");
		} catch (Exception $e) {
			echo $e->getMessage()."\n";
		}
		
	}


	private static $_instance;
	public static function instance () {
		if (!isset(self::$_instance)) {
			$_classname = __CLASS__;
			self::$_instance = new $_classname;
		}
		return self::$_instance;
	}
	
}

/**
 * Auto load the data models as they're needed 
 * By convention models are named in singular
 * i.e. User
 */
function __autoload($class_name) {
	$file = APP."/models/" . $class_name . '.model.php';
	if (file_exists($file) == false)
		return false;
	include_once $file;
}


function object_to_array($o){
	$defaults = get_class_vars(get_class($o));
	if(empty($defaults)) {
		return (array)$o;
	}
	foreach($o as $k=>$v) 
	{
		if(is_object($v)) {
			$o->$k = object_to_array($v);
		}
	}
	return (array)$o;
}

function obj_to_arr($obj = null)
{
	return object_to_array($obj);
}

function arr_to_obj($array = array()) {
    if (!empty($array)) {
        $data = false;
        foreach ($array as $akey => $aval) {
            $data -> {$akey} = $aval;
        }
        return $data;
    }
    return false;
}

function sql_sanitize ($v,$type=null) {
	$val = trim($v);
	if(is_numeric($v)) {
		return filter_var($v,($type?$type:FILTER_SANITIZE_NUMBER_INT));
	} else if(is_string($v)) {
		return filter_var($v,($type?$type:FILTER_SANITIZE_STRING));
	}
}

function slugify($str) {
	$str = preg_replace('/[^a-zA-Z0-9 -]/', '', $str);
	$str = strtolower(str_replace(' ', '-', trim($str)));
	$str = preg_replace('/-+/', '-', $str);
	return $str;
}

?>
