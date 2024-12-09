<?php 
session_start();
if(empty($_SESSION['status'])){
    header('Location: ../login.html');
}

$LockerTable = "tbl_card";
$cardTable = "tbl_card";

$conn = mysqli_connect('localhost', 'root', '', 'suncharge');

if(isset($_POST['deployCard'])){

    //check card ID of the UID;
    $lockerID = $_POST['lockerID'];
    $cardNumber = $_POST['cardUID'];

    //search for card number in tbl_cardext
    $cardInfoSql = "SELECT * FROM tbl_cardExt WHERE card_number = '$cardNumber'";
    $cardInfoQry = mysqli_query($conn, $cardInfoSql);
    $cardInfoRows = mysqli_num_rows($cardInfoQry);

    if($cardInfoRows < 1){
        echo"
        <script>
            alert('Card #$cardNumber does not exist');
        </script>
        ";
    }else{
    $cardInfo = mysqli_fetch_assoc($cardInfoQry);

    $name = $cardInfo['used_by'];
    $cardUID = $cardInfo['card_uid'];
    $section = $cardInfo['section'];


    $expDate = date('Y-m-d', strtotime('+30 days'));
    
    
    $sql = "UPDATE $LockerTable SET card_uid = '$cardUID', locker_status = 'Rented', used_by ='$name', section = '$section', card_number = '$cardNumber', locker_status='Rented',date_rented = NOW(), date_expired = '$expDate' WHERE locker_number = '$lockerID'";
    $qry = mysqli_query($conn, $sql);

    $sqlLockerNumber = "UPDATE tbl_cardext SET locker_number = '$lockerID' WHERE card_uid = '$cardUID'";
    mysqli_query($conn, $sqlLockerNumber);

    //log action into tbl_log
    $logSql = "INSERT INTO tbl_log VALUES ('', '', NOW(), NOW(), '$name has rented locker number $lockerID', 'Rent')";
    mysqli_query($conn, query: $logSql);

    echo"
    <script>
        alert('$name is now using the locker charger');
        window.location.href = 'lockerManager.php';
    </script>";
    }
}

if(isset($_POST['returnCard'])){
    $card = $_POST['return-locker'];

    //put current values in log table
    $sqlID = "SELECT * FROM $LockerTable WHERE locker_number = '$card'";
    $qryID = mysqli_query($conn, $sqlID);
    $cardInfo = mysqli_fetch_assoc($qryID);

    $locker_number = $cardInfo['locker_number'];
    $cardNumber = $cardInfo['card_number'];
    $name = $cardInfo['used_by'];
    $section = $cardInfo['section'];

    $logSql = "INSERT INTO tbl_log VALUES('','', NOW(), NOW(), 'Administrator has removed $name and Card $cardNumber from Locker Number $locker_number', 'Return')";
    mysqli_query($conn, $logSql);

    //remove users in locker table
    $sqlRemove = "UPDATE $LockerTable SET card_number = null, card_uid = '', locker_status ='Free', used_by = '', date_rented = '', date_expired = '', section = '', card_balance ='0', coinslot_balance = '0' WHERE locker_number  = '$locker_number'";
    mysqli_query($conn, $sqlRemove);

    //remove locker number in user card
    $removeLockerSql = "UPDATE tbl_cardext SET locker_number = null WHERE card_number = '$cardNumber'";
    mysqli_query($conn, $removeLockerSql);
    echo"
    <script>
        alert('Card no.$card has been returned.');
        window.location.href = 'lockerManager.php';
    </script>
    ";
}

//balance checker
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="style/main.css">
    <link rel="stylesheet" href="style/lockerManager.css">
    <link rel="stylesheet" href="style/nav.css">

    <script src="javascript/cardManager2.js" defer></script>
    <script src="lockerDeploy.js" defer></script>

    <title>RE:Charge | Locker Manager</title>
</head>
<body>
    <div class="main">
        <div class="nav-bar">
            <h1>RE:Charge</h1>
            
            <a href="">Locker Manager</a>
            <a href="cardManager.php">Card Manager</a>
            <a href="accountSettings.php">Settings</a>
            <a href="logout.php" id="log-out">Logout</a>
        </div>



        <div class="main-body">
            <h1 class="header">Locker Manager</h1>

            <div class="sub-container-wrapper">
                <div class="tbl-container">
                        <table class="card-tbl" id="cards-table">
                            <thead>
                                <th>Locker No.</th>
                                <th>Status</th>
                                <th>Used by</th>
                                <th>Card No.</th>
                                <th>Date Rented</th>
                                <th>Date Expired</th>
                                <th></th>
                            </thead>

                            <tbody>
                            <?php 
                                    $conn = mysqli_connect('localhost', 'root', '', 'suncharge');
                                    $sql = "SELECT * FROM $LockerTable";
                                    $qry = mysqli_query($conn, $sql);

                                    while($result = mysqli_fetch_assoc($qry)){         
                                        $cardNumber = $result['locker_number'];
                                        $lockerStatus = $result['locker_status'];
                                        $usedBy = $result['used_by'];

                                        $rentDate = $result['date_rented'];
                                        $expiration = $result['date_expired'];
                                        
                                        //user string and cardNumber
                                        if($usedBy == null){
                                            $usedByStr = "None";
                                            $cardNoStr = "None";
                                            $rentDateStr = "--:--";
                                            $expirationStr = "--:--";
                                        }else{
                                            $usedByStr = $result['used_by'];
                                            $cardNoStr = $result['card_number'];
                                            
                                            //date conversion
                                                //rent date conversion
                                                $dateRentObj = new DateTime($rentDate);
                                                $rentDateStr = $dateRentObj->format('M j, Y');

                                                //expiration conversion
                                                $expObj = new DateTime($expiration);
                                                $expirationStr = $expObj->format('M j, Y');
                                        }
                                ?>
                                <tr>

                                    <td><?php echo $cardNumber;?></td>
                                    <td><?php echo $lockerStatus;?></td>
                                    <td><?php echo $usedByStr?></td>
                                    <td><?php echo $cardNoStr?></td>
                                    <td><?php echo $rentDateStr?></td>
                                    <td><?php echo $expirationStr?></td>
                                    <td><!--action buttons-->
                                        <?php if($usedBy == !null){?>
                                            <button class="return-btn" id="return-btn">Return</button>
                                        <?php }else if($usedBy == null){?>
                                            <button class="deploy-btn"id="deploy-btn<?php echo$cardNumber;?>">Deploy</button>    
                                        <?php }?>
                                    </td>       
                                </tr>
                                <?php }?>
                            </tbody>          
                        </table>
                </div>
                
                <div class="container-bottom">
                    <p>Sales Record</p>
                    <p id="activity-log">Activity Log</p>
                </div>
            </div> 


        </div>
    </div>

    
    <div class="dim-background" id="dim-background"></div>

    <div class="deploy-popUp" id="deploy-popUp">
        <div class="deploy-header">
            <img src="images/close.png" style="width: 7%; padding-right: 3%; cursor: pointer;" id="close-btn">
        </div>
        <div class="deploy-body">
            <h1>Locker No.<span id="locker-number"></span></h1>
            <form action="" method="POST" class="deploy-forms">
                <div class="deploy-input">
                    <input type="text" name="lockerID" id="locker-number-forms">
                    <input type="text" name="cardUID" id="" class="stud-id-txt" placeholder="Card Number">
                  <input type="submit" value="Confirm" class="confirm-btn" name="deployCard">
                </div>
            </form>
        </div>
    </div>

    <div class="return-popUp" id="return-popUp">
        <div class="return-header">
            <img src="images/close.png" style="width: 7%; padding-right: 3%; cursor: pointer;" id="return-close-btn">
        </div>
        <div class="return-body">
            <h1>Locker No. <span id="return-locker-number"></span></h1>
            <p>Are you sure you want to return this card?</p>
            <div class="return-form">
                <form action="" method="post">
                    <input type="text" id="return-locker-hidden" name="return-locker"hidden>
                    <input type="submit" value="Confirm" class="return-confirm-btn" name="returnCard">
                </form>
                <button class="return-cancel-btn" id="return-cancel-btn">Cancel</button>
            </div>
        </div>
    </div>
       <!--History-->

    <div class="history-main" id="history-main">
        <div class="history-head">
            <h1>Activity Logs</h1>
            <img src="images/close.png" style="width: 4%; padding-right: 3%; cursor: pointer;" id="history-close">
        </div>
        <div class="history-tbl-head-container">
            <table class="history-tbl-head">
                <thead>
                    <th>Date</th>
                    <th>Time</th>
                    <th>Action</th>
                    <th>Description</th>
                </thead>
            </table>
        </div>
        
        <div class="history-scrollable-body">
            <table class="history-tbl-body">
            <tbody>
                <?php 
                $historySql = "SELECT * FROM tbl_log";
                $historyQry = mysqli_query($conn, $historySql);

                while($historyData = mysqli_fetch_assoc($historyQry)){


                //time conversion
                $time = $historyData['time'];
                $timeTakenFrmt = date("h: i A", strtotime($time));
                ?>
                <tr>
                    <td><?php echo $historyData['date']?></td>
                    <td><?php echo $timeTakenFrmt?></td>
                    <td><?php echo $historyData['action']?></td>
                    <td><?php echo $historyData['description']?></td>
                </tr>                
                <?php }?>
            </tbody>
            </table>
        </div>
    </div>


    <!--Sales report window-->
    <div class="sales-main" id="sales-main">

        <div class="sales-head">
            <h1>Sales</h1>
            <img src="images/close.png" style="width: 7%; padding-right: 3%; cursor: pointer;" id="sales-close">
        </div>

        <div class="sales-tbl-head-container">
            <table class="sales-tbl-head">
                <thead class="sales-tbl-body">
                    <th>Date</th>
                    <th>Locker Charger 1</th>
                    <th>Charger 2</th>
                </thead>
            </table>
        </div>

        <div class="sales-scrollable-body">
            <table class="sales-tbl-body">
                <tbody>
                    <?php 
                    //get sales from database
                    $sqlSales = "SELECT * FROM tbl_sales";
                    $qrySales = mysqli_query($conn, $sqlSales);
                    while($resultSales = mysqli_fetch_assoc($qrySales)){

                        $dateSales = $resultSales['date'];
                        $charger1Sales = $resultSales['charger1'];
                        $charger2Sales = $resultSales['charger1'];
                    ?>
                    <tr>
                        <td><?php echo$dateSales;?></td>
                        <td>₱ <?php echo$charger1Sales?></td>
                        <td>₱ <?php echo$charger2Sales?></td>
                    </tr>
                    <?php }?>
                </tbody>
            </table>
        </div>
    </div>

    <!--Deploy pop up-->


        
</body>
</html>
