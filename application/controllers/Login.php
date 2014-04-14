<?php

class Login extends Controller {

	private $twitter;
	private $facebook;

	function __construct () {
		parent::__construct("Login");
	}

	public function index () {
		if($this->user->userid > 0) {
			$this->redirect = '/';
			return;
		}

		if(isset($_POST['username']) && $_POST['username']!="") {
			$userkey = (stristr($_POST['username'],"@")!==false) ? "email" : "username";
			$user = new User(
				array(
					$userkey=>sql_sanitize($_POST['username']),
					'password'=>md5(sql_sanitize($_POST['password']))
				)
			);
			if($this->setUser($user))
				$this->redirect = $_REQUEST['referrer'] ? $_REQUEST['referrer'] : "/";
			else 
				$this->setError("Sorry, we couldn't log you in. Please check your email &amp; password and try again.");
			return;
		}
//		Debugger::trace('user',$this->user,true);
//		Debugger::trace('session',$_SESSION,true);
	}

	public function modal() {
		$this->index();
		$this->view = 'login_form.tpl';
	}

	public function logout () {
		unset($this->user);
		Session::instance()->set('user',null);
		$this->redirect = $_REQUEST['referrer'] ? $_REQUEST['referrer'] : "/";
	}
	
	private function setUser($_user) {
			if($_user->userid <= 0)
				return false;
			unset($this->user);
			unset($_user->password);
			Session::instance()->set('user',$_user);
			return true;
	}

	private function newUser() {
			$this->setError('Thank you for registering.\n\nAn email has been sent to you with details on activating your account.');
			$this->format = "email";
			$this->view = "emails/signup.tpl";
			$this->EMAIL_LIST = array($this->user->email);
			$this->title = "Welcome to Steel Gills - Please confirm your account";
			$this->view_post = "index.tpl";
	}

	public function twitter() {
		include_once LIB.'/twitteroauth/twitteroauth/twitteroauth.php';
		// The TwitterOAuth instance  
		$this->twitter = new TwitterOAuth(Config::TWITTER_APIKEY, Config::TWITTER_APISECRET);  
		// Requesting authentication tokens, the parameter is the URL we will be redirected to
		$request_token = $this->twitter->getRequestToken('http://'.$_SERVER['HTTP_HOST'].'/login/twitter_oauth');

		// Saving them into the session  
		$_SESSION['oauth_token'] = $request_token['oauth_token'];  
		$_SESSION['oauth_token_secret'] = $request_token['oauth_token_secret'];  

		// If everything goes well..  
		if($this->twitter->http_code==200){  
			// Let's generate the URL and redirect  
			$url = $this->twitter->getAuthorizeURL($request_token['oauth_token']); 
			header('Location: '. $url); 
		} else { 
			// It's a bad idea to kill the script, but we've got to know when there's an error.  
			die('TwitterOAuth Failed.');  
		}
	}

	public function twitter_oauth () {
		if(!empty($_GET['oauth_verifier']) && !empty($_SESSION['oauth_token']) && !empty($_SESSION['oauth_token_secret'])){  
	    // We've got everything we need  
			include_once LIB.'/twitteroauth/twitteroauth/twitteroauth.php';
			$this->twitter = new TwitterOAuth(Config::TWITTER_APIKEY, Config::TWITTER_APISECRET, $_SESSION['oauth_token'], $_SESSION['oauth_token_secret']);  
			$access_token = $this->twitter->getAccessToken($_GET['oauth_verifier']); 
			$twitter_user = $this->twitter->get('account/verify_credentials'); 

			/*
			 * SCENARIOS
			 * logged in / connected
			 * logged in / unconnected
			 * logged out / connected
			 * logged out / unconnected
			 * guest
			 */

			// LOGGED IN
			if($this->user->userid > 0) {
				$user = new User(array('userid'=>$this->user->userid));
				if($user->twitter_uid <= 0) {
					$user->twitter_uid = $twitter_user->id;
				}
			// LOGGED OUT
			} else {
				$user = new User(array('twitter_uid'=>sql_sanitize($twitter_user->id)));
				//UNCONNECTED
				if($user->userid <= 0) {
					$user = new User(array('twitter_uid'=>sql_sanitize($twitter_user->id)));
					$user->twitter_uid = $twitter_user->id;
					$user->confirmation = substr(md5(uniqid(rand())),0,10);
					$user->status = "member";
					$user->created_at = date('Y-m-d H:i:s');
					$user->username = $twitter_user->screen_name;
					$test = new User(array('username'=>$twitter_user->screen_name));
					if($test->userid > 0)
						$user->username .= rand(100,999);
					unset($this->user->userid);//userid can't be 0 or MySQL won't insert
					$user->twitter_uid = $twitter_user->id;
				}
			}

			// ALL SCENARIOS
			if(($user->first_name.$user->last_name)=="") {
				$name = explode(" ",$twitter_user->name);
				if(count($name)>1)
					$user->last_name = array_pop($name);
				$user->first_name = implode(" ",$name);
			}
			$user->twitter_token = $access_token['oauth_token'];
			$user->twitter_secret = $access_token['oauth_token_secret'];
			$user->save();
			if($user->userid <= 0) $user = new User(array('twitter_uid'=>sql_sanitize($twitter_user->id)));

			// LOG ME IN
			if($this->setUser($user))
				$this->redirect = "/";
			return;

//			header('Content-type: text/plain');
//			Debugger::trace('user',$user,true);
//			Debugger::trace('request',$_REQUEST,true);
//			Debugger::trace('session',$_SESSION,true);

		} else {  
		    // Something's missing, go back to square 1  
		    header('Location: /login');
		}  
		exit;
	}

	public function facebook () {
		# We require the library  
		require_once(FACEBOOK_PATH);

		# Creating the facebook object  
		$this->facebook = new Facebook(array(  
			'appId'  => Config::FB_APPID,  
			'secret' => Config::FB_APISECRET,  
			'cookie' => true  
		));
		
		# Let's see if we have an active session 
		$session = $this->facebook->getSession(); 
		
		if(!empty($session)) { 
			# Active session, let's try getting the user id (getUser()) and user info (api->('/me'))  
			try{  
				$uid = $this->facebook->getUser();
				$this->facebook->user = $this->facebook->api('/me');
			} catch (Exception $e){
			}

			if(!empty($this->facebook->user)){  
				# User info ok? Let's print it (Here we will be adding the login and registering routines) 
				return $this->facebook_oauth();
			} else { 
				# For testing purposes, if there was an error, let's kill the script
				header('Content-type: text/plain');
				print_r($session);
				die("There was an error.");  
			}  
		} else {  
			# There's no active session, let's generate one  
			//$login_url = $this->facebook->getLoginUrl();  
			$login_url = $this->facebook->getLoginUrl(array( 
			    'req_perms' => 'email,user_birthday,status_update,publish_stream,user_photos,user_videos'  
			));  
			header("Location: ".$login_url);  
		}
		# check for extended permissions
		//$api_call = array(  
		//    'method' => 'users.hasAppPermission',  
		//    'uid' => $this->user->facebook_uid,  
		//    'ext_perm' => 'publish_stream'  
		//);  
		//$users_hasapppermission = $facebook->api($api_call);  
		
		# publish to the wall
		//$facebook->api('/'.$this->user->facebook_uid.'/feed', 'post', array('message' => 'I just added a dive on Steel Gills:')); 
	}

	public function facebook_oauth() {
		$facebook_user =& $this->facebook->user;
//		Debugger::trace('fb_user',$this->facebook->user,true);

		// LOGGED INTO SG
		if($this->user->userid > 0) {
			$user = new User(array('userid'=>$this->user->userid));
			//CONNECTED
			if($user->facebook_uid > 0) {
			//UNCONNECTED
			} else {
				$user->facebook_uid = $facebook_user['id'];
			}
			// LOGGED OUT
		} else {
			$user = new User(array('facebook_uid'=>sql_sanitize($facebook_user['id'])));
			// USER EXISTS
			if($user->userid <= 0) {
				$user = new User(array('email'=>sql_sanitize($facebook_user['email'])));
			}
			if($user->userid > 0) {
				$user->facebook_uid = $facebook_user['id'];
			// NEW USER
			} else {
				//$user = new User(array('facebook_uid'=>sql_sanitize($facebook_user[id])));
				$user->facebook_uid = $facebook_user['id'];
				$user->confirmation = substr(md5(uniqid(rand())),0,10);
				$user->status = "member";
				$user->created_at = date('Y-m-d H:i:s');
				$user->email = $facebook_user['email'];
				$user->username = ucfirst(strtolower($facebook_user['first_name']))." ".strtoupper(substr($facebook_user['last_name'],0,1));
				$test = new User(array('username'=>$user->username));
				if($test->userid > 0)
					$user->username .= rand(100,999);
				unset($user->userid);
				$user->facebook_uid = $facebook_user['id'];

				$this->setError('Thank you for signing up!\n\nYou can get started by adding dives in your logbook or browsing our database of divesites.');
			}
		}
		
		// ALL SCENARIOS
		if($user->first_name=="" && $user->last_name=="") {
			$user->last_name = $facebook_user['last_name'];
			$user->first_name = $facebook_user['first_name'];
		}
//		$user->facebook_token = $access_token['oauth_token'];
//		$user->facebook_secret = $access_token['oauth_token_secret'];
		$user->save();
		if($user->userid <= 0) $user = new User(array('facebook_uid'=>sql_sanitize($facebook_user['id'])));

		// LOG ME IN
		if($this->setUser($user))
			$this->redirect = "/";

//			header('Content-type: text/plain');
//			Debugger::trace('user',$user,true);
//			Debugger::trace('request',$_REQUEST,true);
//			Debugger::trace('session',$_SESSION,true);
		return;
	}


}

?>
