<?php
/**
 * DEBUGGING AND ERROR REPORTING
 */
define("DEBUG",true);
ini_set('display_errors', true);
ini_set('error_reporting', (DEBUG ? (E_ERROR | E_WARNING | E_PARSE ) : E_ERROR));
ini_set('error_reporting', E_ERROR | E_WARNING | E_PARSE);
include_once getcwd().'/../lib/Erector.class.php';
$erector = Erector::instance();

/**
 * Load the appropriate controller class based on 
 * the URL. 
 * Will also look for views if no controller is 
 * available. This allows you to create static pages with no
 * controller. Not that you should... but you could.
 * By convention the controllers are named in plural:
 * i.e. Users
 */
Dispatcher::instance()->dispatch();

/**
 * The Presenter class takes the data from the Controller
 * and generates the appropriate output. This allows 
 * full model / view separation.
 */
Presenter::instance()->present();

exit();
?>
