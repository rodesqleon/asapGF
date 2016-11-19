<?php
	include_once('connection.php');
	//Call object of class connection and create a new connection to my localhost database
	$connection = new createConnection(); 
	$connection->connectToDatabase();
	$connection->selectDatabase();

	if($_SERVER['REQUEST_METHOD'] == "POST"){
	// Get data
	$name = isset($_POST['name']) ? mysql_real_escape_string($_POST['name']) : "";
	$email = isset($_POST['email']) ? mysql_real_escape_string($_POST['email']) : "";
	$password = isset($_POST['pwd']) ? mysql_real_escape_string($_POST['pwd']) : "";

	// Insert data into data base
	$sql = "INSERT INTO `users` (`id`, `name`, `email`, `password`) VALUES (NULL, '$name', '$email', '$password');";
	$qur = mysql_query($sql);
		if($qur){
			$json = array("status" => "OK", "msg" => "User created successfull!");
		}else{
			$json = array("status" => "NOK", "msg" => "Error creating user!");
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