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
    die(json_encode([
        "status" => "error",
        "message" => "Connection failed: " . $conn->connect_error
    ]));
}

// Get the UID from the request
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $card_uid = $_POST['card_uid']; // Fetch the UID from POST data

    if (empty($card_uid)) {
        echo json_encode([
            "status" => "error",
            "message" => "No UID provided"
        ]);
        exit;
    }

    // Check if the card exists in the database
    $stmt = $conn->prepare("SELECT card_uid, used_by FROM tbl_card WHERE card_uid = ?");
    $stmt->bind_param("s", $card_uid);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();

        // Check if the card is assigned to charger1
        if ($row['used_by'] === "charger2") {
            echo json_encode([
                "status" => "success",
                "message" => "Access granted for charger2",
                "used_by" => "charger2"
            ]);
        } 
        // Check if the card is in use by another charger
        else if ($row['used_by'] !== null) {
            echo json_encode([
                "status" => "in_use",
                "message" => "Card is already assigned to " . $row['used_by']
            ]);
        } 
        // Card is unassigned, no further action here
        else {
            echo json_encode([
                "status" => "not_assigned",
                "message" => "Card is not yet assigned to a charger"
            ]);
        }
    } else {
        // No matching record found
        echo json_encode([
            "status" => "not_found",
            "message" => "Card UID not recognized"
        ]);
    }

    $stmt->close();
}

// Close connection
$conn->close();
?>
