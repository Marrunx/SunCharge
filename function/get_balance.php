<?php
if (isset($_POST['card_uid'])) {
    $card_uid = $_POST['card_uid'];

    // Database connection
    $servername = "localhost";
    $username = "root";
    $password = ""; // Your password here
    $dbname = "suncharge";

    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Fetch balance from tbl_cardext
    $sql = "SELECT balance FROM tbl_cardext WHERE card_uid = '$card_uid'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // Fetch the balance
        $row = $result->fetch_assoc();
        $balance = $row['balance'];

        // Now update the tbl_card with the balance
        $update_sql = "UPDATE tbl_card SET coinslot_balance = $balance WHERE card_uid = '$card_uid'";
        if ($conn->query($update_sql) === TRUE) {
            // Return a JSON response
            echo json_encode(array(
                "status" => "success",
                "balance" => $balance,
                "message" => "Balance updated successfully"
            ));
        } else {
            // Error while updating the balance
            echo json_encode(array(
                "status" => "error",
                "message" => "Error updating balance: " . $conn->error
            ));
        }
    } else {
        // No such UID found
        echo json_encode(array(
            "status" => "error",
            "message" => "No such UID found in tbl_cardext."
        ));
    }

    $conn->close();
}
?>
