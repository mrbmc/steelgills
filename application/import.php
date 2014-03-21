<?php
ini_set('display_errors',true);

$dir = getcwd()."/../data";
$filename = isset($_REQUEST['file'])?$_REQUEST['file']:"divesites.xml";
$fc = file_get_contents($dir."/".$filename);
$xml = new SimpleXMLElement($fc);

header("Content-Type: text/plain");
//echo "delete from divesite where divesiteid > 10;\n\n";
foreach($xml->Document->Placemark as $k=>$v) 
{
//	print_r($v);
	if(!isset($v->Point))
		continue;
	$point = explode(",",$v->Point->coordinates);
	$description = "";//addslashes(trim(strip_tags($v->description)));
	$region = explode(",",$description);
	$city = count($region)>1 ? trim($region[0]) : "";
	$country = isset($_REQUEST['country']) ? trim($_REQUEST['country']) : (count($region)>1 ? trim($region[1]) : "");

	$sql = "INSERT INTO divesite ";
	$sql .= "(title,country,description,latitude,longitude,created_at) ";
	$sql .= "VALUES (";

	$sql .= "'".addslashes($v->name)."'";
	$sql .= ",'".$country."'";
	$sql .= ",'".$description."'";
	if(count($point)>1) {
		$sql .= ",'".$point[1]."'";
		$sql .= ",'".$point[0]."'";
	} else {
		$sql .= ",'"."'";
		$sql .= ",'"."'";
	}
	$sql .= ",NOW()";
	$sql .= ");\n\r\n\r";
	echo $sql;
}

exit();
?>
