<?php

class Dive extends Model {

	public $diveid = 0;
	public $fk_userid;
	public $title;
	public $location;
	public $bottom_time;
	public $deco_time;
	public $max_depth;
	public $time_start;
	public $time_end;
	public $total_time;
	public $air_start;
	public $air_end;
	public $air_used;
	public $weight;
	public $efficiency;//dynamic
	public $temperature;
	public $current;
	public $visibility;
	public $wind_speed;
	public $wave_height;
	public $air_temperature;
	public $exposure;
	public $exposures = array("skin","shorty","farmer","wetsuit","drysuit","gloves","hood");
	public $description;
	public $created_at;
	public $updated_at;
	public $user;//dynamic
	public $fk_divesiteid;
	public $divesite;//dynamic

	public function __construct() {
		$args = func_get_args();
		parent::__construct($args[0]);

		if($this->fk_userid>0)
			$this->user = new User($this->fk_userid);
		if($this->fk_divesiteid>0)
			$this->divesite = new Divesite($this->dive->fk_divesiteid);

		$ts_start = strtotime($this->time_start);
		$ts_end = strtotime($this->time_end);
		if ($ts_end > $ts_start)
			$this->total_time = ($ts_end - $ts_start)/60;
		else {
			$this->total_time = ($this->bottom_time + $this->deco_time);
			$this->time_end = date("Y-m-d G:i:s",$ts_start + (60 * $this->total_time));
		}
		$this->air_used = $this->air_start - $this->air_end;
		//$this->efficiency = ($this->air_start - $this->air_end);
	}

	public static function load () {
		parent::$table = "dive";
		$args = func_get_args();
		return parent::load($args[0]);
	}
	public static function getCount () {
		parent::$table = "dive";
		$args = func_get_args();
		return parent::getCount($args[0]);
	}
	function save () {
		parent::$table = "dive";
		return parent::save('diveid');
	}
	function delete ($id) {
		parent::$table = "dive";
		return parent::delete('diveid',obj_to_arr($this));
	}

	function set ($data) {
		if(!$this->created_at) $this->created_at = date('Y-m-d H:i:s');

		$data['max_depth'] = max(0,$data['max_depth']);
		$data['bottom_time'] = max(0,$data['bottom_time']);
		$data['deco_time'] = max(0,$data['deco_time']);

		if(isset($_POST['date_start']) && $_POST['date_start']>0)
			$data['time_start'] = date('Y-m-d H:i:s',strtotime($data['date_start'] . " " . $data['time_start']));
		else
			$data['time_start'] = date('Y-m-d H:i:s',strtotime($data['time_start']));

		if($data['time_end'])
			$data['time_end'] = date('Y-m-d H:i:s',strtotime($data['date_start'] . " " . $data['time_end']));
		else {
			$this->total_time = $data['bottom_time'] + $data['deco_time'];
			$data['time_end'] = date('Y-m-d H:i:s',strtotime($data['time_start'])+($this->total_time*60));
		}

		$data['air_start'] = max(0,$data['air_start']);
		$data['air_end'] = max(0,$data['air_end']);
		$data['air_used'] = floatval($data['air_start']) - floatval($data['air_end']);
		$data['efficiency'] = ($data['max_depth']>0) ? intval($data['air_used'] / ($data['bottom_time']/$data['max_depth'])):0;
		$data['weight'] = max(0,$data['weight']);

		$data['temperature'] = max(0,$data['temperature']);
		$data['current'] = max(0,$data['current']);
		$data['visibility'] = max(0,$data['visibility']);

		$data['wind_speed'] = max(0,$data['wind_speed']);
		$data['wave_height'] = max(0,$data['wave_height']);
		$data['air_temperature'] = max(0,$data['air_temperature']);

		parent::set($data);
	}
	
	public function getExposure() {
		return explode(",",$this->exposure);
	}

	public function canEdit($user) {
		return ($this->id <=0 || $user->userid==$this->fk_userid || $user->status=="admin");
	}
}


?>
