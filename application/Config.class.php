<?php
class Config
{

	/**
	 *	SITE CONFIGURATION
	 */
	public $SITE_NAME = "Steel Gills";
	private static $ENV_PRODUCTION = "www.steelgills.com";
	private static $ENV_STAGE = "stage.steelgills.com";
	private static $ENV_DEV = "localhost:8888";
	public $EMAIL_NAME = "Steel Gills";
	public $EMAIL_ADDRESS = "no-reply@steelgills.com";

	/**
	 * DATABASE CREDENTIALS
	 */
	//PRODUCTION
	private $dsn_production = array(
		'type' => "mysql",
		'host' => "localhost",
		'db' => "steelgills_db",
		'user' => "steelgills",
		'pass' => "deepdive"
	);
	//STAGING
	private $dsn_stage = array(
		'type' => "mysql",
		'host' => "localhost",
		'db' => "steelgills_stage",
		'user' => "steelgills",
		'pass' => ""
	);
	//DEVELOPMENT
	private $dsn_dev = array(
		'type' => "mysql",
		'host' => "localhost",
		'db' => "steelgills",
		'user' => "steelgills",
		'pass' => "d33pdiv3"
	);

	/**
	 *	STYLECONFIGURATION
	 */
	const DATEFORMAT = "M.d.Y";
	const TIMEZONE = "America/New_York";
	const PERPAGE = 20;


	const GOOGLE_MAPS_KEY = "ABQIAAAAneA_PMgS1PxdizDrcOaoERRpAWDUQRkjx_Tnyvrdqwt4JvaA8xRrCSqEhKmRnktZKGaTTHEUCGLkXg";

	/**
	 * FACEBOOK
	 */
//	const FB_APPID = '146102812067817';
//	const FB_APIKEY = '6ca978100f61c4eb7cb78855700b3b9a';
//	const FB_APISECRET = '6ebe2ffc971016836aa469da2a0731f0';

	const FB_APPID = '151982698145238';
	const FB_APIKEY = '8cb11e00ecfad5d68f76386f70c3e05c';
	const FB_APISECRET = 'ac6fc9165695652ac62ff582a6d9f2de';

	/**
	 * TWITTER
	 */
	const TWITTER_APIKEY = 'ufv0MgII52XdCicSYZEs8A';
	const TWITTER_APISECRET = 'yQ0VdqiNxsIZiLqeqyfL2YcmthAifQ38QiPubERsU';

	/**
	 * Amazon Web Services
	 */
	const AWS_ID = ""; 
	const AWS_SECRET = "";


/**
 * ----------------------------------------------------------------------
 * NO NEED TO EDIT BELOW HERE
 * ----------------------------------------------------------------------
 */
	private function __construct() {
		date_default_timezone_set(Config::TIMEZONE);
	}

	private static $_instance;
	public static function instance () {
		if (!isset(self::$_instance)) {
			$_classname = __CLASS__;
			self::$_instance = new $_classname;
		}
		return self::$_instance;
	}

	public function getDSN($env=null) {
		$env = "dsn_".strtolower(self::getEnvironment());
		$dsn =& $this->$env;
		return $dsn;
	}

	private function getEnvironment () {
		switch($_SERVER["HTTP_HOST"]) 
		{
		case self::$ENV_DEV:
			return "DEV";
		break;
		case self::$ENV_STAGE:
			return "STAGE";
		break;
		default:
			return "PRODUCTION";
		break;
		}
	}

}
?>
