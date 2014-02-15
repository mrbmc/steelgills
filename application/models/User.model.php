<?php

class User extends Model {

	public $userid = 0;
	public $status;
	public $created_at;
	public $updated_at;
	public $confirmation;
	public $username;
	public $password;
	public $email;
	public $first_name;
	public $last_name;
	public $name;
	public $address;
	public $address_2;
	public $city;
	public $state;
	public $zipcode;
	public $phone;
	public $image;

	public $twitter_uid;
	public $twitter_token;
	public $twitter_secret;

	public $facebook_uid;
	public $facebook_token;
	public $facebook_secret;

	public function __construct($args=null) {
		parent::__construct($args);
		$this->image = $this->get_avatar();
		$this->name = ($this->first_name!="") ? $this->first_name." ".$this->last_name : $this->username;
	}

	function save () {
		parent::$table = "user";
		return parent::save('userid');
	}

	private function get_avatar () {
		$grav_url = "http://www.gravatar.com/avatar/";
		$grav_url .= md5( strtolower( trim( $this->email ) ) );
		//$grav_url .= "?d=" . urlencode( "default.jpg" );
		//$grav_url .= "&s=" . 32;
		return $grav_url;
	}

}


?>
