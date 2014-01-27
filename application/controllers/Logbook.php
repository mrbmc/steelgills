<?php
class Logbook extends Controller
{
	private $id;
	public $dives;
	public $dive;
	public $divecount;
	public $member;
	public $chart_info;
	public $chart_cond;
	public $chart_air;
	public $breadcrumb;
	public $divesites = array();
	public $last_dive;
	public $sort;
	public $order;

	public function __construct() {
		parent::__construct("My Logbook");
		$this->view = "logbook/index";
//		if(stristr(Dispatcher::instance()->action,"chart_data")!==false) {
//			$this->index();
//		} else {
//			$this->action(Dispatcher::instance()->action);
//		}
	}
	public function index() {
		if($this->user->userid<=0)
			return $this->redirect = "/login";

		//List sorting
		$this->order = (Session::instance()->get('order')!="") ? Session::instance()->get('order') : "DESC";
		// if($_GET['order']!="") $this->order = $_GET['order'];
		$this->sort = (Session::instance()->get('sort_col')!="") ? Session::instance()->get('sort_col') : "time_start";
		if(isset($_GET['sort']) && Dispatcher::instance()->action!="chart_data") {
			switch ($_GET['sort'])
			{
				case "title":
					$this->sort = "title";
				break;
				case "location":
					$this->sort = "location";
				break;
				case "depth":
					$this->sort = "max_depth";
				break;
				case "time":
					$this->sort = "bottom_time";
				break;
				case "date":
				default:
					$this->sort = "time_start";
				break;
			}
			if(($this->sort == Session::instance()->get('sort_col')))
				$this->order = ($this->order == "ASC") ? "DESC" : "ASC";
		}
		
		Session::instance()->set("sort_col",$this->sort);
		Session::instance()->set("sort_order",$this->order);

		$this->pagenav->urlTemplate = "/logbook/index/p/|#|";
		$this->pagenav->totalItems = $this->divecount;
		//$this->pagenav->perpage = 3;

		$where = "AND fk_userid = '".$this->user->userid."'";
		$order = $this->sort . " " . $this->order;
		$limit = $this->pagenav->getSQLLimit();

		$params = array("where"=>$where,"order"=>$order,"limit"=>$limit);

		if(Dive::getCount($params)<=0)
			return $this->redirect = "/logbook/add";

		$this->dives = Dive::load($params);
		$this->data = $this->dives;
		$this->pagenav->totalItems = Dive::getCount($params);

		//$this->member = new User(array('userid'=>$this->userid));
		$this->member =& $this->user;
//		if(stristr(Dispatcher::instance()->action,"chart_data")!==false)
//			$this->chart_data();
//		else
//			$this->chart();
	}

	public function edit() {
		if($this->user->userid<=0)
			return $this->redirect = "/login";
		$this->dive = new Dive(Dispatcher::instance()->params['id']);
		if(!$this->dive->canEdit($this->user))
			return $this->view = "errors/nopermission";
		$this->title = "Edit a dive";

		$divesites_results = Divesite::load();
		foreach($divesites_results as $d)
		{
			$this->divesites[] = $d->title.", ".($d->city!=''?trim($d->city).", ":"").trim($d->country)."^".$d->divesiteid;
		}
		$this->divesites = json_encode($this->divesites);

		$this->last_dive = new Dive(array('order'=>'diveid DESC','limit'=>1,'where'=>"AND fk_userid=".$this->user->userid));
	}


	
	public function add(){
		$this->title = "Log a dive";
		$this->divesites = Divesite::load();
		$this->last_dive = new Dive(array('order'=>'diveid DESC','limit'=>1,'where'=>"AND fk_userid=".$this->user->userid));
	}

	public function show() {
		$this->dive = new Dive(Dispatcher::instance()->params['id']);
	}

	public function update() {
		$this->dive = new Dive(array("diveid"=>$_POST['diveid']));
		$this->dive->set($_POST);
		if($this->dive->save())
			$this->redirect = "/logbook/show/" . $this->dive->diveid;
		else
			die("Your dive was not saved. Please hit the back button and try again.");
	}

	public function delete() {
	}

	public function chart () {
		include_once LIB . '/charts.php';
		$this->chart_info = InsertChart ( "/swf/charts.swf", "/swf/charts_library", "/logbook/chart_data_info/".(isset($_GET['sort']) ? "?sort=".$_GET['sort'] : ""), 470, 240, "FFFFFF" );
		$this->chart_air = InsertChart ( "/swf/charts.swf", "/swf/charts_library", "/logbook/chart_data_air/".(isset($_GET['sort']) ? "?sort=".$_GET['sort'] : ""), 470, 240, "FFFFFF" );
		$this->chart_cond = InsertChart ( "/swf/charts.swf", "/swf/charts_library", "/logbook/chart_data_conditions/".(isset($_GET['sort']) ? "?sort=".$_GET['sort'] : ""), 470, 240, "FFFFFF" );
	}
	private function chart_data () {
		include_once LIB . '/charts.php';

		if(Dispatcher::instance()->action=="chart_data_info")
			$rows = array("dive","max_depth","bottom_time");
		else if(Dispatcher::instance()->action=="chart_data_air")
			$rows = array("dive","air_used");
		else
			$rows = array("dive","temperature","visibility");

		for ($row = 0,$rowmax = count($rows); $row < $rowmax; $row++ ) 
		{
			$chart['chart_data'][$row][0] = $rows[$row];
			for ( $col = 1,$colmax=count($this->dives); $col <= $colmax; $col++ ) 
			{
				$dive = $this->dives[$col-1];
				$chart['chart_data'][$row][$col] = ($rows[$row]=="dive") ? $col : $dive->$rows[$row];
			}
		}
		$chart['chart_type'] = "line";
		$chart[ 'series_color' ] = array ( "FF0066", "0099FF" );
		header("Content-type: text/plain");
		SendChartData ( $chart );
		exit;
	}

}
?>
