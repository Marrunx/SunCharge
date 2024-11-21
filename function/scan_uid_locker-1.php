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
    $stmt = $conn->prepare("SELECT card_uid, locker_number, used_by FROM tbl_card WHERE card_uid = ?");
    $stmt->bind_param("s", $card_uid);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();

        // Check if the card UID matches the assigned locker number
        if ($row['locker_number'] === "1") {
            // If the card matches the locker number, grant access
            echo json_encode([
                "status" => "success",
                "message" => "Access granted for charger1",
                "locker_number" => "charger1",
                "used_by" => $row['used_by']  // Display the name of the user
            ]);
        } else {
            // If the card UID does not match the assigned locker number
            echo json_encode([
                "status" => "access_denied",
                "message" => "Card UID does not match assigned locker number"
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
