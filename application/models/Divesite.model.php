<?php

class Divesite extends Model {

	public $divesiteid = 0;
	public $created_at;
	public $title;
	public $city;
	public $country;
	public $max_depth;
	public $latitude;
	public $longitude;
	public $description;
	public $fk_userid;
	public $coord;
	public $distance;

	public $entry_type;//{shore, boat, dock}
	public $features = [];
	public $rating;
	public $dangers;
	// Travel time
	// Special Features: {wall, wreck, drift, swim-through}
	// Bottom Type

	public static function getDistanceSQL($lat,$lon) {
				$d2m = "0.017453292519943";
				return "(SQRT((pow((latitude-(".$lat.")), 2))+(pow((longitude-(".$lon.")),2)))/$d2m)";
	}

	public function __construct($args=null) {
		parent::__construct($args);
	}
	public static function load () {
		self::$table = "divesite";
		$args = func_get_args();
		return parent::load($args[0]);
	}
	public static function getCount () {
		self::$table = "divesite";
		$args = func_get_args();
		return parent::getCount($args[0]);
	}
	function save ($_matchcolumn='divesiteid',$_data=null) {
		$data['coord'] = "PointFromWKB(POINT(".$data['latitude'].",".$data['longitude']." ))";
		parent::$table = "divesite";
		return parent::save($_matchcolumn,obj_to_arr($this));
	}
	public function set ($data) {
		if(!$this->created_at) $this->created_at = date('Y-m-d H:i:s');
		$data['max_depth'] = intval($data['max_depth']);
		$data['latitude'] = floatval($data['latitude']);
		$data['longitude'] = floatval($data['longitude']);
		$json = json_encode($this);
		parent::set($data);
	}
}


?>
