<?php
// Database credentials
$servername = "localhost";   // Your database server (use 'localhost' if running locally)
$username = "root";          // Database username
$password = "";              // Database password
$dbname = "suncharge";       // Database name

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to reset the coinslot balance
$sql = "UPDATE tbl_cardext SET balance = 0 WHERE locker_number = 1"; // Adjust table and field names as needed
if ($conn->query($sql) === TRUE) {
    echo "Coin balance reset successfully";
} else {
    echo "Error updating record: " . $conn->error;
}

// Close the connection
$conn->close();
?>
