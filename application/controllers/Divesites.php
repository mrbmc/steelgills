<?php
class Divesites extends Controller
{
	public $divesites;
	public $divesite;
	private $id;
	public $member;

	public function __construct() {
		parent::__construct("Dive Sites");
	}
	public function index() {
		$this->divesites = $this->loadSites();//$this->user->userid
		$this->data = $this->divesites;
		$this->json = json_encode($this->data);
		$this->view = "divesites/index";
	}
	public function loadSites($uid=0) {
		$this->pagenav->urlTemplate = "/divesites/".Dispatcher::instance()->action."/p/|#|";
		$this->pagenav->totalItems = $this->divecount;

		$where = "";
		if(isset($_REQUEST['q'])) {
			$g = explode(",",$_REQUEST['q']);
			$swx = min($g[0],$g[2]);
			$swy = min($g[1],$g[3]);
			$nex = max($g[0],$g[2]);
			$ney = max($g[1],$g[3]);
			
			$where .= "AND 
							MBRIntersects(GeomFromText('Polygon((
	            $ney $swx, $ney $nex,
	            $swy $nex, $swy $swx,
	            $ney $swx
	            ))'),divesite.coord)
	  	";
		}
		if($uid>0) $where .= "AND fk_userid = '".$this->user->userid."'";
		if($uid>0) $order = "created_at DESC ";
		//else $order = "title ASC ";
		$limit = $this->pagenav->getSQLLimit();
		$sql_params = array(
			"where"=>$where,
			"order"=>$order,
			"limit"=>$limit,
//			"select"=>(Divesite::getDistanceSQL(40,-70)." distance")
			);
//		Debugger::trace('sql',$sql_params,true);
		$divesites = Divesite::load($sql_params);
		$this->pagenav->totalItems = Divesite::getCount($sql_params);
		//Debugger::trace('divesites',$divesites);
		return $divesites;
	}
	public function all() {
		$this->divesites = $this->loadSites(0);
		$this->data =& $this->divesites;
		$this->json = json_encode($this->data);
		$this->view = "divesites/index";
	}
	public function data() {
		$this->format = "xml";
		$this->xml = $this->user;
	}
	
	public function flat() {
		$this->pagenav->perpage = 999;
		$this->data = $this->loadSites(0);
		header("Content-type: text/plain");
		foreach($this->data as $site){
			echo $site->title."|".$site->divesiteid."\n";
		}
		exit;
	}
	
	public function view() {
		$this->show();
	}
	public function show() {
		$this->divesite = new Divesite(array("divesiteid"=>Dispatcher::instance()->params['id']));
		$this->view = "divesites/divesite.show";
	}
	public function edit() {
		$this->divesite = new Divesite(array("divesiteid"=>Dispatcher::instance()->params['id']));
		$this->view = "divesites/divesite.edit";
	}
	public function update() {
		$this->divesite = new Divesite(array("divesiteid"=>$_POST['divesiteid']));
		$this->divesite->set($_POST);
		if(!$this->divesite->fk_userid) 
			$this->divesite->fk_userid = $this->user->userid;
		if($this->divesite->save())
			$this->redirect = "/divesites/show/" . $this->divesite->divesiteid;
		else
			die("Your divesite was not saved. Please hit the back button and try again; or contact an site administrator on our <a href=\"/contact\">Contact Page</a>");
	}
	public function delete() {
	}

}
?>