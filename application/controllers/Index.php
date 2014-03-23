<?php

class Index extends Controller {

	function __construct () {
		parent::__construct("Index");
	}

	public function index() {
		$this->view = Dispatcher::instance()->view!="" ? strtolower(Dispatcher::instance()->view) : $this->view;
		if($this->view!='index')
			return $this->profile();
		elseif($this->user->userid>0)
			return $this->member();
	}

	public function profile () {
		$this->id = Dispatcher::instance()->params['id'];
		if(!$this->id && $this->user->userid>0)
			$this->id = $this->user->username;
		$key = is_numeric($this->id) ? 'userid' : 'username';
		Dispatcher::instance()->controller = "Profile";
		$this->member = new User(array($key=>$this->id));
		$this->view = "profile/profile.show.tpl";
		if($this->member->userid<=0) {
			$this->view = "errors/404";
			return false;
		}
		$params = array('where'=>"AND fk_userid = '".$this->member->userid."'",'order'=>"time_start DESC");
		$this->member->dives = Dive::load($params);
		$this->member->diveslogged = Dive::getCount($params);
		$this->member->divesites = Divesite::load(array('where'=>"AND fk_userid = '".$this->member->userid."'",'order'=>"divesiteid DESC"));
		return;
	}
	
	public function member() {
		$where = "AND fk_userid = '".$this->user->userid."'";
		$limit = 5;
		$order = "time_start DESC";
		$params = array("where"=>$where,"order"=>$order,"limit"=>$limit);
		$this->dives = Dive::load($params);

		if(!$this->dives[0]) {
			$this->redirect = "/logbook/add";
		}

//		$order = "created_at DESC ";
//		$params = array("where"=>$where,"order"=>$order,"limit"=>$limit);
//		$this->divesites = Divesite::load($params);
	}
	
	public function divesites () {
		$sql_params = array(
			"where"=>"AND fk_userid = '".$this->user->userid."'",
			"order"=>"created_at DESC ",
			"limit"=>$this->pagenav->getSQLLimit(),
			);
		$this->divesites = Divesite::load($sql_params);
		$this->pagenav->totalItems = Divesite::getCount($sql_params);
		$this->data =& $this->divesites;
		$this->json = json_encode($this->data);
		$this->view = "divesites/index";
		return;
	}


}
?>