<?php
    include ('connection.php');
    

    $connection = new createConnection(); //i created a new object

    $connection->connectToDatabase(); // connected to the database

    echo "<br />"; // putting a html break

    $connection->selectDatabase();// closed connection

    $connection->createUsers();

    echo "<br />";

    $connection->closeConnection();
?>