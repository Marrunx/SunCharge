<?php
// Database connection
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "suncharge";

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get POST data
$uid = $_POST['card_uid'];
$description = $_POST['description'];

// Insert into the log table
$sql = "INSERT INTO tbl_log (card_uid, date, time, description) 
        VALUES ('$uid', DATE(NOW()), TIME(NOW()), '$description')";


if ($conn->query($sql) === TRUE) {
    echo "Log entry created successfully";
} else {
    echo "Error: " . $sql . "<br>" . $conn->error;
}

$conn->close();
?>
