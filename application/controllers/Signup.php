<?php

class Signup extends Controller {

	public function __construct () {
		parent::__construct("Sign up");
	}

	public function index() {
		include_once LIB.'/captcha/CaptchaSecurityImages.php';
		include_once LIB.'/captcha/CaptchaPictures.php';
		$this->captcha = new CaptchaPictures();
		$this->captcha->create(4);
	}
}

?>
