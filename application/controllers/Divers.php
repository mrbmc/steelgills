<?php
class Divers extends Controller
{
	public $divers;
	public $diver;
	private $id;

	public function __construct() {
		parent::__construct("Divers");
		if(!Dispatcher::instance()->action)
			return $this->index();
	}
	public function index() {
		$this->id = Dispatcher::instance()->params['id'];
		if($this->id>0 || $this->id!=null)
			$this->redirect = "/".$this->id;
		else
			$this->loadDivers();
	}
	public function loadDivers() {
		$this->pagenav->urlTemplate = "/divers/?p={#}";
		$this->pagenav->totalItems = $this->divecount;
		$where = "";
		$order = "created_at DESC ";
		$limit = $this->pagenav->getSQLLimit();
		$sql_params = array("where"=>$where,"order"=>$order,"limit"=>$limit);

		$this->diver = new User();
		$this->divers = User::load($sql_params);
		$this->pagenav->totalItems = $this->diver->getCount($sql_params);

		$this->data = $this->divers;
		$this->json = json_encode($this->data);
	}
	public function data() {
		$this->format = "xml";
		$this->xml = $this->user;
	}
}
?>