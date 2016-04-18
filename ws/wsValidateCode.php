<?php
	include_once('connection.php');
	//Call object of class connection and create a new connection to my localhost database
	$connection = new createConnection(); 
	$connection->connectToDatabase();
	$connection->selectDatabase();

	$codebar = isset($_GET['codebar']) ? mysql_real_escape_string($_GET['codebar']) :  "";
	
	if(!empty($codebar)){
	 $qur = mysql_query("select id, name, description from `products` where codebar='$codebar'");
	 $result =array();
		while($r = mysql_fetch_array($qur)){
		 extract($r);
		 $result[] = array("id" => $id,"name" => $name, "description" => $description); 
		}
	 $json = array("status" => "OK", "info" => $result);
	}else{
	 $json = array("status" => "NOK", "msg" => "Product doesn' exist");
	}
	 @mysql_close($conn);
	 
	 /* Output header */
	 header('Content-type: application/json');
	 echo json_encode($json);

	//Close connection
	$connection->closeConnection();

?>