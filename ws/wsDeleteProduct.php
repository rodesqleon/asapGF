<?php
	include_once('connection.php');
	//Call object of class connection and create a new connection to my localhost database
	$connection = new createConnection(); 
	$connection->connectToDatabase();
	$connection->selectDatabase();

	if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data
	$codebar = isset($_POST['codebar']) ? mysql_real_escape_string($_POST['codebar']) : "";

	// Insert data into data base
	$sql = "DELETE FROM `products` WHERE `codebar`='$codebar';";
	$qur = mysql_query($sql);
		if($qur){
			$json = array("status" => "OK", "msg" => "Product deleted successfull!");
		}else{
			$json = array("status" => "NOK", "msg" => "Error occur deleting user!");
		}
	}else{
		$json = array("status" => "NOK", "msg" => "Request method not accepted");
	}

@mysql_close($conn);

/* Output header */
	header('Content-type: application/json');
	echo json_encode($json);

	//Close connection
	$connection->closeConnection();
?>