<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="style/main.css">
    <link rel="stylesheet" href="style/cardManager.css">
    <link rel="stylesheet" href="style/nav.css">


    <title>SunCharge | Card Manager</title>
</head>
<body>
    <div class="main">
        <div class="nav-bar">
            <h1>SunCharge</h1>
            
            <a href="">Card Manager</a>
            <a href="accountSettings.php">Account Settings</a>
            
            <div>
            <a href="">Logout</a>
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
                                <p>Time Taken</p>
                            </div>

                            <div class="data-container" id="rowDetails">
                                <p><span id="cardNumber"></span></p>
                                <p id="cardUID"></p>
                                <p id="cardUser"></p>
                                <p id="cardTaken"></p>
                            </div>
                        </div>
                        
                        <button class="deploy-btn" id="deploy-btn">Deploy Card</button>
                        <button class="return-btn" id="return-btn">Return Card</button>
                    </div>
                    <p class="history" id="history-btn">History</p>
                </div>
            </div> 


        </div>
    </div>

    <!--Deploy pop up-->
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
                    <th>Card No.</th>
                    <th>Name</th>
                    <th>Student ID</th>
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
                    <td><?php echo $historyData['card_number']?></td>
                    <td><?php echo $historyData['name']?></td>
                    <td><?php echo $historyData['student_id']?></td>
                    <td><?php echo $timeTakenFrmt?></td>
                    <td><?php echo $timeReturnedFrmt?></td>
                </tr>                
                <?php }?>
            </tbody>
            </table>
        </div>
    </div>

    <div class="deploy-popUp" id="deploy-popUp">
        <div class="deploy-header">
            <img src="images/close.png" style="width: 7%; padding-right: 3%; cursor: pointer;" id="close-btn">
        </div>
        <div class="deploy-body">
            <h1>Card No. <span id="cardUID2"></span></h1>
            <form action="" method="POST">
                <input type="text" value="" id="cardID" name="cardID" hidden>
                <div class="deploy-input">
                    <label for="" class="stud-id-lbl">Student ID</label>
                    <input type="text" name="studentID" id="" class="stud-id-txt">
                </div>

                <div class="deploy-body">
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
        $studentID = $_POST['studentID'];
        
        //get name of the student in studentList
        $getSql = "SELECT * FROM tbl_studentList WHERE studentID = '$studentID'";
        $getQry = mysqli_query($conn, $getSql);
        $getResult = mysqli_fetch_assoc($getQry);
        $numRows = mysqli_num_rows($getQry);
        if($numRows > 0){
        $fname = $getResult['firstname'];
        $sname = $getResult['surname'];


        $sql = "UPDATE tbl_card SET used_by ='$fname $sname', studentID = '$studentID', time_taken = NOW() WHERE card_number = '$cardID'";
        $qry = mysqli_query($conn, $sql);

        echo"
        <script>
            alert('$fname $sname is now using card no.$cardID');
            window.location.href = 'cardManager.php';
        </script>";
        }else{
            echo"
            <script>
                alert('Student ID does not exist');
            </script>";
        }
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
        $studentID = $cardInfo['studentID'];
        $timeTaken = $cardInfo['time_taken'];

            //update history table;
        $historySql = "INSERT INTO tbl_history VALUES ('', NOW(), '$cardNumber', '$name', '$studentID', '$timeTaken', NOW())";
        $historyQry = mysqli_query($conn, $historySql);

        //update values in database
        $sql = "UPDATE tbl_card SET used_by = null, studentID = null, time_taken = null WHERE card_number = '$card'";
        $qry = mysqli_query($conn, $sql);
        
        echo"
        <script>
            alert('Card no.$card has been returned.');
            window.location.href = 'cardManager.php';
        </script>
        ";
    }
?>

