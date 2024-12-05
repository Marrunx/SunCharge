<?php
// Ensure your MySQL connection is set up correctly
$servername = "localhost"; // Your server name
$username = "root"; // Your MySQL username
$password = ""; // Your MySQL password
$dbname = "suncharge"; // Your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get the UID and RFID balance from the POST data
if (isset($_POST['card_uid']) && isset($_POST['rfid_balance'])) {
    $card_uid = $_POST['card_uid'];
    $rfid_balance = $_POST['rfid_balance'];

    // Sanitize the inputs to prevent SQL injection
    $card_uid = $conn->real_escape_string($card_uid);
    $rfid_balance = (int)$rfid_balance; // Ensure it's an integer

    // Update the coinslot_balance column in the tbl_card table based on the card UID
    $sql = "UPDATE tbl_card SET coinslot_balance = $rfid_balance WHERE card_uid = '$card_uid'";

    if ($conn->query($sql) === TRUE) {
        // After successfully updating the balance, reset the rfid_balance to 0
        $reset_sql = "UPDATE tbl_card SET rfid_balance = 0 WHERE card_uid = '$card_uid'";

        if ($conn->query($reset_sql) === TRUE) {
            echo "Balance updated successfully and RFID balance reset to 0";
        } else {
            echo "Error resetting RFID balance: " . $conn->error;
        }
    } else {
        echo "Error updating balance: " . $conn->error;
    }
} else {
    echo "Missing card_uid or rfid_balance";
}

$conn->close();
?>
