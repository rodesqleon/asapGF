<?php
require_once "lib/nusoap.php";


function getUserInfo($rut) {
    if ($rut == "18394092-9") {
        return join(",", array(
            "Nombre" => "Rodrigo",
            "Apellido Paterno" => "Esquivel",
            "Apellido Materno" => "Leon"));
    }
    else {
        return "User doesn't exist";
    }
}

$server = new soap_server();
$server->configureWSDL("userList", "urn:userList");

$server->register("getUserInfo",
    array("rut" => "xsd:string"),
    array("return" => "xsd:string"),
    "urn:userList",
    "urn:userList#getUserInfo",
    "rpc",
    "encoded",
    "Get a listing of user info by rut");

if ( !isset( $HTTP_RAW_POST_DATA ) ) $HTTP_RAW_POST_DATA =file_get_contents( 'php://input' );
$server->service($HTTP_RAW_POST_DATA);

?>