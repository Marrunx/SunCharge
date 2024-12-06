<?php
// Database connection
$servername = "localhost";  // Assuming XAMPP is running locally
$username = "root";         // Default MySQL username (root)
$password = "";             // Default MySQL password (empty in XAMPP by default)
$dbname = "suncharge";      // Your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if parameters are set
if (isset($_GET['charging1'])) {
    $charger1 = intval($_GET['charging1']); // Get the amount from the parameter

    // Get name from the other table
    $getDataSql = "SELECT * FROM tbl_card WHERE locker_number = 1"; // Assuming locker_number = 1
    $getDataQRY = mysqli_query($conn, $getDataSql);
    $userData = mysqli_fetch_assoc($getDataQRY);

    // Data needed in sales
    $locker_number = 1;
    $userNameTbl = $userData['used_by']; // Assuming 'used_by' column holds the name

    // Get current date and time
    $date = date("Y-m-d"); // Format: YYYY-MM-DD
    $time = date("H:i:s"); // Format: HH:MM:SS

    // Insert into sales (ID will auto-increment)
    $salesRecordSql = "INSERT INTO tbl_sales (transaction_id, date, time, locker_number, name, amount) 
                       VALUES (NULL, '$date', '$time', '$locker_number', '$userNameTbl', '$charger1')";
    $salesRecordQRY = mysqli_query($conn, $salesRecordSql);

    // Check if the query executed successfully
    if ($salesRecordQRY) {
        echo "Transaction successfully recorded!";
    } else {
        echo "Error: " . mysqli_error($conn);
    }
} else {
    echo "Error: Missing parameters.";
}

// Close the connection
$conn->close();
?>
