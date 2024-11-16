<?php
// Database connection
$servername = "localhost";  // Assuming XAMPP is running locally
$username = "root";         // Default MySQL username (root)
$password = "";             // Default MySQL password (empty in XAMPP by default)
$dbname = "suncharge";           // Your database name

// Set timezone to ensure correct date
date_default_timezone_set('Asia/Manila'); // Adjust timezone if necessary

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get current date from server
$date = date("Y-m-d"); // Format: YYYY-MM-DD
echo "Current Date: $date<br>"; // Debugging line to verify date

// Check if parameters are set
if (isset($_GET['charging1'])) {
    $charger1 = intval($_GET['charging1']);

    // Check if a record for the current date exists
    $stmt = $conn->prepare("SELECT id FROM tbl_sales WHERE date = ?");
    $stmt->bind_param("s", $date);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        // Record exists, update the charging1 value
        $stmt = $conn->prepare("UPDATE tbl_sales SET charger1 = charger1 + ? WHERE date = ?");
        $stmt->bind_param("is", $charger1, $date);
        if ($stmt->execute()) {
            echo "Record updated successfully";
        } else {
            echo "Error updating record: " . $stmt->error;
        }
    } else {
        // No record for this date, insert a new one
        $stmt = $conn->prepare("INSERT INTO tbl_sales (date, charger1) VALUES (?, ?)");
        $stmt->bind_param("si", $date, $charger1);
        if ($stmt->execute()) {
            echo "New record created successfully";
        } else {
            echo "Error: " . $stmt->error;
        }
    }

    $stmt->close(); // Close the statement
} else {
    echo "Error: Missing parameters.";
}

// Close the connection
$conn->close();
?>
