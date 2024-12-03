<?php
// Start session to store the UID
session_start();

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // Get UID from POST request
    $uid = $_POST['uid'] ?? '';

    if (!empty($uid)) {
        // Absolute path to the log file
        $logFile = 'C:/xampp/htdocs/SunChargeV2/logs/rfid_logs.txt';

        // Log the UID to the file
        if (file_put_contents($logFile, $uid . "\n", FILE_APPEND)) {
            // Store UID in session
            $_SESSION['uid'] = $uid;

            // Send success response
            echo "UID logged successfully: $uid";
        } else {
            // File write failed
            echo "Failed to write UID to the log file.";
        }
    } else {
        // No UID received
        echo "No UID received in POST data.";
    }
}
?>
