<?php

class Admin extends Controller {

	public $users;
	public $hashtags;
	public $venues;
	private $id;

	function __construct () {
		$this->id = Dispatcher::instance()->params['id'];
		if($_GET['do']!=""){
			$this->action = $_GET['do'];
		}
		parent::__construct($this->title,$this->view);
	}

	public function index() {
		$this->title = "Admin area";
		$this->view = 'admin/admin.tpl';
	}

	public function users () {
		//$do = Dispatcher::instance()->params['do'];
		$u = new User();
		if($_POST['do']=="save")
		{
			$u->set($_POST);
			$u->save();
		}
		if($_POST['do']=="delete")
		{
			$u->setFrom($_POST);
			if($u->delete()) {
				$this->redirect = "/admin/users";
			}
		}

		if($this->id>0) {
			$this->users = User::load(array('userid'=>$this->id));
		}
		else
			$this->users = User::load();
		$this->view = 'admin/users.tpl';
	}

}


?>