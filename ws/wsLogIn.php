<?php
	include_once('connection.php');
	//Call object of class connection and create a new connection to my localhost database
	$connection = new createConnection(); 
	$connection->connectToDatabase();
	$connection->selectDatabase();

	$password = isset($_GET['pwd']) ? mysql_real_escape_string($_GET['pwd']) :  "";
	if(!empty($password)){
	 $qur = mysql_query("select id, name, email from `users` where password='$password'");
	 $result =array();
		while($r = mysql_fetch_array($qur)){
		 extract($r);
		 $result[] = array("id" => $id,"name" => $name, "email" => $email); 
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