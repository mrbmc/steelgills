<?php

class Message {
	public $name;
	public $email;
	public $subject;
	public $message;
}

class Contact extends Controller {
	public $form_data;

	function __construct () {
		parent::__construct("Contact");
		$this->form_data = new Message();
	}

	public function index () {
		$this->view = "contact";
	}

	public function send () {
		$this->form_data->name = trim($_POST['name']);
		$this->form_data->email = trim($_POST['email']);
		$this->form_data->subject = trim($_POST['subject']);
		$this->form_data->message = trim($_POST['message']);

		$this->view = "emails/contact.tpl";
		$this->EMAIL_LIST = array(Config::instance()->EMAIL_ADDRESS);
		$this->title = $_POST['subject'];
		$this->format = "email";
		$this->redirect = "/contact/sent";
//		Debugger::trace($this->form_data);
	}
	public function sent () {
		$this->view = "contact.sent";
	}

}

?>
