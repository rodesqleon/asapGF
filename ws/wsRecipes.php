<?php
	include_once('connection.php');
	//Call object of class connection and create a new connection to my localhost database
	$connection = new createConnection(); 
	$connection->connectToDatabase();
	$connection->selectDatabase();

	if ($_SERVER["REQUEST_METHOD"] == "GET") {
  		$result = mysql_query("SELECT * FROM `recipes` ORDER BY name ASC");  
		$arr_json = array();
		while ($row = mysql_fetch_assoc($result)) {
		   $json = json_encode($row);
		   $arr_json[] = $row;
		}
		$validateArray = array();

		 if($result == $validateArray){
		 	$json = array("status" => "NOK");
		 }else{
		 	$json = array("status" => "OK", "info" => $arr_json);
		 }
	}	 
  /* output in necessary format */
  if($format == 'json') {
    header('Content-type: application/json');
    echo json_encode($result);
 }

@mysql_close($conn);

/* Output header */
	header('Content-type: application/json');
	echo json_encode($json);

	//Close connection
	$connection->closeConnection();
?>