<?php
// Database configuration
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "suncharge";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die(json_encode([
        "status" => "error",
        "message" => "Connection failed: " . $conn->connect_error
    ]));
}

// Get the UID and locker ID from the POST request
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $card_uid = $_POST['card_uid'];
    $locker_id = $_POST['locker_id'];

    // Validate input
    if (empty($card_uid) || empty($locker_id)) {
        echo json_encode([
            "status" => "error",
            "message" => "UID or locker ID missing"
        ]);
        exit;
    }

    // Check if the card UID exists and is assigned to the correct locker
    $stmt = $conn->prepare("SELECT card_uid, locker_number, used_by FROM tbl_card WHERE card_uid = ? AND locker_number = ?");
    $stmt->bind_param("ss", $card_uid, $locker_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();

        // Access granted
        echo json_encode([
            "status" => "success",
            "message" => "Access granted for locker $locker_id",
            "locker_number" => "locker" . $locker_id,
            "used_by" => $row['used_by'] // Include user information
        ]);
    } else {
        // Access denied
        echo json_encode([
            "status" => "access_denied",
            "message" => "Card UID not recognized or not assigned to locker $locker_id"
        ]);
    }

    $stmt->close();
}

// Close connection
$conn->close();
?>