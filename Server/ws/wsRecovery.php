<?php

include_once('connection.php');
	//Call object of class connection and create a new connection to my localhost database
	$connection = new createConnection(); 
	$connection->connectToDatabase();
	$connection->selectDatabase();

	$email = isset($_GET['email']) ? mysql_real_escape_string($_GET['email']) :  "";

	if(!empty($email)){
	 $qur = mysql_query("select name, password from `users` where email='$email'");
	 $result =array();
		while($r = mysql_fetch_array($qur)){
		 extract($r);

		 $result[] = array("name" => $name, "password" => $password);
		
		}
	
	 $json = array("status" => "OK", "info" => $result);
	}else{
	 $json = array("status" => "NOK", "msg" => "User doesn' exist");
	}
	 @mysql_close($conn);
	 
	 /* Output header */
	 header('Content-type: application/json');
	 echo json_encode($json);

	//Close connection
	$connection->closeConnection();

?>