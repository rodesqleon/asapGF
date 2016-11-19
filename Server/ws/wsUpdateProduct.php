<?php
	include_once('connection.php');
	//Call object of class connection and create a new connection to my localhost database
	$connection = new createConnection(); 
	$connection->connectToDatabase();
	$connection->selectDatabase();

	if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data
	$name = isset($_POST['name']) ? mysql_real_escape_string($_POST['name']) : "";
	$codebar = isset($_POST['codebar']) ? mysql_real_escape_string($_POST['codebar']) : "";
	$description = isset($_POST['description']) ? mysql_real_escape_string($_POST['description']) : "";

	// Insert data into data base
	$sql = "UPDATE `products` SET `name` = '$name', `description`='$description' where `codebar`='$codebar';";
	$qur = mysql_query($sql);
		if($qur){
			$json = array("status" => "OK", "msg" => "Product updated successfull!");
		}else{
			$json = array("status" => "NOK", "msg" => "Error ocurr updating user!");
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