<?php
 require 'lib/nusoap.php';
 $server = new nusoap_server();
 $server->configureWSDL("SOAP"."urn:SOAP");
 $server->register(
 		 	"price", //name of function
 		 	array("name" => 'xsd:string'), //inputs
 		 	array("return" => 'xsd:inter') //outputs
 		  );

 $HTTP_RAW_POST_DATA = isset($HTTP_RAW_POST_DATA) ? $HTTP_RAW_POST_DATA  : '';
 $server->service($HTTP_RAW_POST_DATA);
?>