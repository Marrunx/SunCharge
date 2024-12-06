<?php
// Database credentials
$servername = "localhost";   // Your database server (use 'localhost' if running locally)
$username = "root";          // Database username
$password = "";              // Database password
$dbname = "suncharge";     // Database name

// Create a connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check the connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// SQL query to get the coinslot balance
$sql = "SELECT coinslot_balance FROM tbl_card WHERE locker_number = 1"; // Adjust table and field names as needed
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    // Fetch the balance
    $row = $result->fetch_assoc();
    echo $row['coinslot_balance']; // Return the balance as plain text
} else {
    echo "0"; // Return 0 if no balance is found
}

// Close the connection
$conn->close();
?>
