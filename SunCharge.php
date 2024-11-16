<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SunCharge</title>
</head>
<body>
    <div>
        <center>
            <form action="" method="post" onsubmit="validateUID()">
                <label for="uid">Scan ID</label>
                <input type="text" name="scanned-uid" id="uid">
                <br><br>
                <input type="submit" value="Scan" name="scan">
            </form>
        </center>
    </div>  
</body>
</html>

<?php 
$conn = mysqli_connect("localhost", "root", "", "cvsu");


if(isset($_POST['scan'])){
    //rfid id from scanner
    $uid = $_POST['scanned-uid'];

    //get list of rfid in database with the scanned rfid
    $sql = "SELECT * FROM tbl_cards WHERE card_id = '$uid'";
    $qry = mysqli_query($conn, $sql);
    $numRows = mysqli_num_rows($qry);

    //check number of rows
    if($numRows > 0){
        $result = mysqli_fetch_assoc($qry);
        
        //insert rfid data in variables
        $card = $result['card_no'];

        echo('RFID found.');
    }else{
        echo('RFID does not exists.');
    }
}
?>