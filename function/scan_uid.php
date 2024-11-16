<?php
// Database configuration
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

// Get the UID from the request
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $card_uid = $_POST['card_uid']; // Fetch the UID from POST data

    // Prepare and bind the SQL statement to find the UID in the database
    $stmt = $conn->prepare("SELECT card_number, card_uid, studentID FROM tbl_card WHERE card_uid = ?");
    $stmt->bind_param("s", $card_uid);

    // Execute the statement
    $stmt->execute();
    $result = $stmt->get_result();

    // Check if a matching record was found
    if ($result->num_rows > 0) {
        // Fetch the matching record
        $row = $result->fetch_assoc();
        
        // Respond with the student information
        echo json_encode([
            "status" => "found",
            "Card_number" => $row['card_number'],
            "Card_UID" => $row['card_uid'],
            "StudentID" => $row['studentID']
        ]);
    } else {
        // No matching record found
        echo json_encode(["status" => "not_found"]);
    }

    $stmt->close();
}

// Close connection
$conn->close();
?>
