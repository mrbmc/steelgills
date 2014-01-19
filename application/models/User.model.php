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
	public $address;
	public $address_2;
	public $city;
	public $state;
	public $zipcode;
	public $phone;

	public $twitter_uid;
	public $twitter_token;
	public $twitter_secret;

	public $facebook_uid;
	public $facebook_token;
	public $facebook_secret;

	function save () {
		parent::$table = "user";
		return parent::save('userid');
	}


}


?>
