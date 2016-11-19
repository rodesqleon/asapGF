<?php
	include_once('connection.php');
	//Call object of class connection and create a new connection to my localhost database
	$connection = new createConnection(); 
	$connection->connectToDatabase();
	$connection->selectDatabase();

	$username = isset($_GET['usr']) ? mysql_real_escape_string($_GET['usr']) :  "";
	$password = isset($_GET['pwd']) ? mysql_real_escape_string($_GET['pwd']) :  "";
	
	if(!empty($username) && !empty($password)){
	 $qur = mysql_query("select id, name, email, role from `users` where password='$password' and name='$username'");
	 $result =array();
		while($r = mysql_fetch_array($qur)){
		 extract($r);
		 $result[] = array("id" => $id,"name" => $name, "email" => $email, "role" => $role); 
		}
	 $json = array("status" => "OK", "info" => $result);
	}else{
	 $json = array("status" => "NOK", "msg" => "User doesn' exist");
	}
	 @mysql_close($conn);
	 
	 /* Output header */
	 header('Access-Control-Allow-Origin: *');
	 header('Content-type: application/json');
	 echo json_encode($json);

	//Close connection
	$connection->closeConnection();

?>