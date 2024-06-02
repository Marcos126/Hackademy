<?php

    $server = "localhost"; 
    $username = "angel" ;
    $password = "angel" ; 
    $database = "Hack4u" ;

    //Conexion a la base de datos
    $conn = new mysqli($server, $username, $password, $database);

    $id = $_GET['id'];

    echo "[+] Tu valor introducido es: " . $id . "<br>------------------------------------------------------------------------------<br>";

    $data = mysqli_query($conn, "select username from users where id = '$id' ");

    $response = mysqli_fetch_array($data);
    echo $response['username'];
?>
