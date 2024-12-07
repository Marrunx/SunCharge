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
    die(json_encode(["status" => "error", "message" => "Connection failed: " . $conn->connect_error]));
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $card_uid = $_POST['card_uid'];

    if (empty($card_uid)) {
        echo json_encode(["status" => "error", "message" => "No UID provided"]);
        exit;
    }

    // Prepare SQL statement to fetch the balance
    $stmt = $conn->prepare("SELECT card_uid, locker_number, used_by, balance FROM tbl_cardext WHERE card_uid = ?");
    $stmt->bind_param("s", $card_uid);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $response = [
            "status" => "success",
            "balance" => $row['balance'],
            "locker_number" => $row['locker_number'],
            "used_by" => $row['used_by'],
            "message" => "Access granted for locker " . $row['locker_number']
        ];

        if ($row['locker_number'] != "1") {
            $response["status"] = "access_denied";
            $response["message"] = "Card UID does not match assigned locker number";
        }

        echo json_encode($response); // Return the entire response as JSON
    } else {
        echo json_encode([
            "status" => "not_found",
            "message" => "Card UID not recognized"
        ]);
    }

    $stmt->close();
}

$conn->close();
?>
