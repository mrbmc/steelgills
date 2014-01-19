<?php
include_once LIB.'/captcha/CaptchaSecurityImages.php';
include_once LIB.'/captcha/CaptchaPictures.php';
class Captcha extends Controller
{
	public $captcha;

	public function __construct() {
		parent::__construct("Captcha");
		$this->captcha = new CaptchaPictures();
	}

	public function index() {
		$this->captcha->create(4);
	}

	public function validate () {
		echo ($this->captcha->validate($_GET['captcha'])) ? "true" : "false";
		exit;
	}

	protected function renew()
	{
//		$this->captcha->code = $this->captcha->generateCode();
//		Session::instance()->set('captcha_code',$this->captcha->code);
		$this->captcha->create();
		//echo Session::instance()->get('captcha_code');
	}
}
?>