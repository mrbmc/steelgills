<?php

class Profile extends Controller {

	public $id;
	public $member;
	public $dives;

	function __construct ($controller="Profile") {
		parent::__construct($controller);
	}

	public function index () {
		if($this->user->userid<=0) {
			$this->redirect = "/login/index/referrer/".urlencode('profile');
		} else 
			$this->redirect = "/".$this->user->username;
	}

	public function show () {
		$this->redirect = "/".Dispatcher::instance()->params['id'];
		return;
	}
	public function view () {$this->show();}

	public function edit () {
		if($this->user->userid<=0) {
			$this->redirect = "/login/index/referer/".urlencode('?referrer=/profile/edit');
			return false;
		}

		$this->id = Dispatcher::instance()->params['id'];
		if(!$this->id && $this->user->userid>0)
			$this->id = $this->user->username;
		$key = is_numeric($this->id) ? 'userid' : 'username';
		$this->member = new User(array($key=>$this->id));
		$this->view = "profile/profile.edit.tpl";
	}


	public function update () {
		if($this->user->userid<=0)
		{
			$this->redirect = "/login";
			return;
		}
		$user = new User(array('userid'=>$_POST['userid']));
		$user->set($_POST);
//		Debugger::trace("user",$user,true);
		if(md5($_REQUEST['password_old']) == $user->password)
			$user->password = md5($_POST['password_new']);
		if($user->save()) {
			//$this->user = new User($user->userid);
			Session::instance()->set('user',$user);
			$this->redirect = "/profile/edit";
			$this->setError("Your profile was saved");
		} else {
			die('Caught exception: '.$e->getMessage()."\n");
		}
	}

	public function newUser() {
			$this->setError('Thank you for registering. An email has been sent to you with details on activating your account.');
			$this->format = "email";
			$this->view = "emails/signup.tpl";
			$this->EMAIL_LIST = array($this->user->email);
			$this->title = "Welcome to Steel Gills - Please confirm your account";
			$this->view_post = "index.tpl";
	}


	public function create () {
		$this->user = new User();
		$this->user->set($_POST);
		$this->user->password = md5($_POST['password']);
		if($this->user->userid<=0) {
			$this->user->confirmation = substr(md5(uniqid(rand())),0,10);
			$this->user->created_at = date('Y-m-d H:i:s');
			unset($this->user->userid);
		}
		if($this->user->save()) {
			return $this->newUser();
		} else {
			$this->user->set($_POST);
			$this->setError('An error occured creating your account.');
			$this->format = "html";
			$this->view = "signup.tpl";
			//$this->redirect = "/signup";
		}

	}
	public function confirm () {
		$this->user = new User(array("confirmation"=>$_GET['code']));
		if($this->user->userid > 0)
		{
			$this->user->status="member";
			$this->user->save();
			Session::instance()->set("userstatus",$this->user->status);
			$this->redirect = isset($_REQUEST['referer']) ? $_REQUEST['referer'] : "/";
		}
	}
	public function username_exists () {
		$u = new User(array("username"=>$_GET['username']));
		echo ($u->userid > 0) ? "true" : "false";
		exit;
	}
	public function username_unique () {
		$u = new User(array("username"=>$_GET['username']));
		echo ($u->userid <= 0) ? "true" : "false";
		exit;
	}
	public function email_exists () {
		$u = new User(array("email"=>$_GET['email']));
		echo ($u->userid > 0) ? "true" : "false";
		exit;
	}
	public function email_unique () {
		$u = new User(array("email"=>$_GET['email']));
		echo ($u->userid <= 0) ? "true" : "false";
		exit;
	}
	public function validate_pw () {
		echo (md5($_REQUEST['password_old']) == $this->user->password) ? "true" : "false";
		exit;
	}
	public function pw_reminder () {
		$this->view = 'pw_reminder';
	}
	public function send_pw() {

		if($_POST['username'])
			$this->user = new User(array("username"=>$_POST['username']));
		else if($_POST['email'])
			$this->user = new User(array("email"=>$_POST['email']));

		if($this->user->userid>0)
		{
			$this->EMAIL_LIST = array($this->user->email);
			$this->view = 'emails/pw_reminder';
			$this->format = "email";
			$this->redirect = "/";
		} else 
			$this->redirect = "/profile/pw_reminder";
	}

}

?>
