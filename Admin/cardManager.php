<?php 
session_start();
if(empty($_SESSION['status'])){
    header('Location: ../login.html');
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="style/main.css">
    <link rel="stylesheet" href="style/cardManager.css">
    <link rel="stylesheet" href="style/nav.css">


    <title>RE:Charge | Card Manager</title>
</head>
<body>
    <div class="main">
        <div class="nav-bar">
            <h1>RE:Charge</h1>
            
            <a href="">Card Manager</a>
            <a href="accountSettings.php">Settings</a>
            
            <div>
            <a href="logout.php" id="log-out">Logout</a>
            </div>
        </div>



        <div class="main-body">
            <h1 class="header">Card Manager</h1>

            <div class="sub-container-wrapper">
                <div class="tbl-container">
                    
                        <table class="card-tbl" id="cards-table">
                            <thead>
                                <th>Card No.</th>
                                <th>Used by</th>
                                <th>Section</th>
                                <th>Time Taken</th>
                            </thead>

                            <tbody>
                            <?php 
                                    $conn = mysqli_connect('localhost', 'root', '', 'suncharge');
                                    $sql = "SELECT * FROM tbl_card";
                                    $qry = mysqli_query($conn, $sql);

                                    while($result = mysqli_fetch_assoc($qry)){         
                                        $cardNumber = $result['card_number'];
                                        $cardUID = $result['card_uid'];
                                        $section = $result['section'];
                                        if(is_null($result['used_by'])){
                                            $cardUser = "none";
                                        }else{
                                            $cardUser = $result['used_by'];
                                        }

                                        if(is_null($result['time_taken'])){
                                            $hours12 = "-- : --";
                                        }else{
                                            $cardTaken = $result['time_taken'];
                                            $hours12 = date("h: i A", strtotime($cardTaken));
                                        }
                                ?>
                                <tr>

                                    <td><?php echo $cardNumber;?></td>
                                    <td><?php echo $cardUser;?></td>
                                    <td><?php echo $section?></td>
                                    <td><?php echo $hours12;?></td>               
                                </tr>
                                <?php }?>
                            </tbody>          
                        </table>
                        
                </div>
                
                <div class="right-container">
                    <div class="action-container">
                        <div class="action-sub-container">
                            <div class="side-label">
                                <p>Card No.</p>
                                <p>Used By</p>
                                <p>Section</p>
                                <p>Time Taken</p>
                            </div>

                            <div class="data-container" id="rowDetails">
                                <p><span id="cardNumber"></span></p>
                                <p id="cardUID"></p>
                                <p id="cardUser"></p>
                                <p id="cardSection"></p>
                                <p id="cardTaken"></p>
                            </div>
                        </div>
                        
                        <button class="deploy-btn" id="deploy-btn">Deploy Card</button>
                        <button class="return-btn" id="return-btn">Return Card</button>
                    </div>
                    <p class="sales" id="sales-btn">Sales report</p>
                    <p class="history" id="history-btn">History</p>
                </div>
            </div> 


        </div>
    </div>

    
    <div class="dim-background" id="dim-background"></div>

       <!--History-->

    <div class="history-main" id="history-main">
        <div class="history-head">
            <h1>History</h1>
            <img src="images/close.png" style="width: 4%; padding-right: 3%; cursor: pointer;" id="history-close">
        </div>
        <div class="history-tbl-head-container">
            <table class="history-tbl-head">
                <thead>
                    <th>Date</th>
                    <th>Name</th>
                    <th>Section</th>
                    <th>Time Taken</th>
                    <th>Time Returned</th>
                </thead>
            </table>
        </div>
        
        <div class="history-scrollable-body">
            <table class="history-tbl-body">
            <tbody>
                <?php 
                $historySql = "SELECT * FROM tbl_history";
                $historyQry = mysqli_query($conn, $historySql);

                while($historyData = mysqli_fetch_assoc($historyQry)){


                //time conversion
                $timeTaken = $historyData['time_taken'];
                $timeReturned = $historyData['time_returned'];

                $timeTakenFrmt = date("h: i A", strtotime($timeTaken));
                $timeReturnedFrmt = date("h: i A", strtotime($timeReturned));
                ?>
                <tr>
                    <td><?php echo $historyData['date']?></td>
                    <td><?php echo $historyData['name']?></td>
                    <td><?php echo $historyData['section']?></td>
                    <td><?php echo $timeTakenFrmt?></td>
                    <td><?php echo $timeReturnedFrmt?></td>
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
    <div class="deploy-popUp" id="deploy-popUp">
        <div class="deploy-header">
            <img src="images/close.png" style="width: 7%; padding-right: 3%; cursor: pointer;" id="close-btn">
        </div>
        <div class="deploy-body">
            <h1>Card No. <span id="cardUID2"></span></h1>
            <form action="" method="POST" class="deploy-forms">
                <input type="text" value="" id="cardID" name="cardID" hidden>
                <div class="deploy-input">
                    <input type="text" name="customer_name" id="" class="stud-id-txt" placeholder="Name">
                    <input type="text" name="section" id="" class="stud-id-txt" placeholder="Section">
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
            <h1>Card No. <span id="cardUID3"></span></h1>
            <p>Are you sure you want to return this card?</p>
            <div class="return-form">
                <form action="" method="post">
                    <input type="text" value="" id="cardID2" name="cardID2" hidden>
                    <input type="submit" value="Confirm" class="return-confirm-btn" name="returnCard">
                </form>
                <button class="return-cancel-btn" id="return-cancel-btn">Cancel</button>
            </div>
        </div>
    </div>

 


    <script src="javascript/cardManager.js" defer></script>
</body>
</html>
<?php
    if(isset($_POST['deployCard'])){
        $cardID = $_POST['cardID'];
        $name = $_POST['customer_name'];
        $section = $_POST['section'];
        


        $sql = "UPDATE tbl_card SET used_by ='$name', section = '$section', time_taken = NOW() WHERE card_number = '$cardID'";
        $qry = mysqli_query($conn, $sql);

        echo"
        <script>
            alert('$name is now using the locker charger');
            window.location.href = 'cardManager.php';
        </script>";
    }

    if(isset($_POST['returnCard'])){
        $card = $_POST['cardID2'];

        //put current values in history table
        $sqlID = "SELECT * FROM tbl_card WHERE card_number = '$card'";
        $qryID = mysqli_query($conn, $sqlID);
        $cardInfo = mysqli_fetch_assoc($qryID);

            //values to put in history table

        $cardNumber = $cardInfo['card_number'];
        $name = $cardInfo['used_by'];
        $section = $cardInfo['section'];
        $timeTaken = $cardInfo['time_taken'];

            //update history table;
        $historySql = "INSERT INTO tbl_history VALUES ('', NOW(), '$cardNumber', '$name', '$section', '$timeTaken', NOW())";
        $historyQry = mysqli_query($conn, $historySql);

        //update values in database
        $sql = "UPDATE tbl_card SET used_by = null, section = null, time_taken = null WHERE card_number = '$card'";
        $qry = mysqli_query($conn, $sql);
        
        echo"
        <script>
            alert('Card no.$card has been returned.');
            window.location.href = 'cardManager.php';
        </script>
        ";
    }
?>

