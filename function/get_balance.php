<?php
// Include your database connection or any other required logic
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "suncharge"; // Using the correct database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the UID from the POST request
$card_uid = $_POST['card_uid'];  // This will be the UID sent by the ESP8266

// Query to get the balance based on UID
$sql = "SELECT rfid_balance FROM tbl_card WHERE card_uid = '$card_uid'";  // Using the correct table and column names
$result = $conn->query($sql);

// Check if the UID exists and return the balance
if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo $row['rfid_balance'];  // Return the balance as plain text
} else {
    echo "0";  // Return 0 if UID is not found
}

$conn->close();
?>
