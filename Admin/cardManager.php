<?php 
$conn = mysqli_connect('localhost', 'root', '', 'suncharge');

$logFile = '../logs/rfid_logs.txt'; // Adjust the path if needed
if (file_exists($logFile)) {
    file_put_contents($logFile, ''); // Overwrite the file with an empty string
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RE:Charge | Card Manager</title>

    <link rel="stylesheet" href="style/main.css">
    <link rel="stylesheet" href="style/nav.css">
    <link rel="stylesheet" href="style/cardManager.css">
</head>

<body>
    <div class="main">
        <div class="nav-bar">
            <h1>RE:Charge</h1>
            
            <a href="lockerManager.php">Locker Manager</a>
            <a href="">Card Manager</a>
            <a href="accountSettings.php">Settings</a>
            <a href="logout.php" id="log-out">Logout</a>
        </div>


        <div class="main-body">
            <h1 class="header">Card Manager</h1>

            <div class="sub-container-wrapper">
                <div class="tbl-container">
                        <table class="card-tbl" id="cards-table">
                            <thead>
                                <th>Card No.</th>
                                <th>Card UID</th>
                                <th>Status</th>
                                <th>Used By</th>
                                <th>Section</th>
                                <th>Balance</th>
                                <th>Date taken</th>
                            </thead>
                        </table>
                        <div class="scrollable-body">
                        <table class="scrollable-table" id="scrollable-table">
                            <tbody>
                                <?php 
                                //display database data
                                $cardListSql = "SELECT * FROM tbl_cardext";
                                $cardListQry = mysqli_query($conn, $cardListSql);
                                while($cardListData = mysqli_fetch_assoc($cardListQry)){
                                
                                $dateTaken = $cardListData['date_taken'];
                                
                                if($dateTaken != null){
                                $dateTakenObj = new DateTime($dateTaken);
                                $dateTakenStr = $dateTakenObj->format('M j, Y');
                                }else if($dateTaken == null){
                                    $dateTakenStr = "--/--/--";
                                }

                                ?>
                                <tr>
                                    <td><?php echo$cardListData['card_number']?></td>
                                    <td><?php echo $cardListData['card_uid']?></td>
                                    <td><?php echo$cardListData['status']?></td>
                                    <td><?php echo$cardListData['used_by']?></td>
                                    <td><?php echo$cardListData['section']?></td>
                                    <td><?php echo$cardListData['balance']?></td>
                                    <td><?php echo$dateTakenStr?></td>
                                </tr>
                                <?php }?>
                            </tbody>
                        </div>
                        </table>
                </div>
            </div> 

            <div class="sub-container-bottom">
                <div class="bottom-left">
                    <button class="bottom-btn" id="add-card-btn">Add Card</button>
                </div>

                <div class="bottom-right">
                    <div class="selected-row">
                    <p>Selected Card: |<span id="selected-id" style="border: solid 1px; padding-inline: 20px;"></span></p>
                    </div>
                    <button class="bottom-btn" id="edit-card" disabled>Edit</button>
                    <button class="bottom-btn" id="add-balance" disabled>Add Balance</button>
                    <form method="post"class="bottom-right-form">
                    <input type="text" name="selected-card-id" id="selected-card-id" hidden>
                    <input type="submit" class="bottom-btn-return" name="return-card" id="return-card" value="Return Card"disabled>
                    </form>
                    <button class="bottom-btn-missing" id="missing-card" name="remove_card"disabled>Remove Card</button>
                </div>
            </div>
        </div>

        

        <div class="dim-background" id="dim-background"></div>

        <div class="locker-settings" id="locker-settings">
            <div style="display: flex; align-items: center; justify-content: end; margin-inline: 40px; gap: 12%;" id="add-close">
                <h1>Add Card</h1>
                <img src="images/close.png" style="width: 10%; height: 10%;"alt="">
            </div>
            <form action="" method="post" class="locker-forms">
                <input type="text" id="uid-display"  placeholder="Scan Card to see UID" class="input-txt" name="cardUID" required>
                <input type="submit" class="save-btn" name="addCard" value="Add Card">
            </form>
        </div>

        <div class="deploy-popUp" id="edit-popUp">
        <div class="deploy-header">
            <img src="images/close.png" style="width: 7%; padding-right: 3%; cursor: pointer;" id="edit-close">
        </div>
        <div class="deploy-body">
            <h1>Card No.<span id="edit-header"></span></h1>
            <form action="" method="POST" class="deploy-forms">
                <div class="deploy-input">
                    <input type="text" name="edit_id" id="edit-card-id" hidden>
                    <input type="text" name="edit_name" id="" class="stud-id-txt" placeholder="Name" required>
                    <input type="text" name="edit_section" id="" class="stud-id-txt" placeholder="Section">
                  <input type="submit" value="Confirm" class="confirm-btn" name="edit-confirm">
                </div>
            </form>
        </div>
        </div>

        <div class="balance-popUp" id="balance-popUp">
        <div class="balance-header">
            <img src="images/close.png" style="width: 7%; padding-right: 3%; cursor: pointer;" id="bal-close">
        </div>
        <div class="balance-body">
            <h1>Card No.<span id="bal-header"></span></h1>
            <form action="" method="POST" class="deploy-forms">
                <div class="balance-input">
                    <input type="text" name="balance_id" id="balance-card-id" hidden>
                    <input type="text" name="balance" id="" class="stud-id-txt" placeholder="Balance Value">
                  <input type="submit" value="Confirm" class="confirm-btn" name="addBalance">
                </div>
            </form>
        </div>
        </div>
        
        <div class="remove-popUp" id="remove-popUp">
            <img src="images/warning.png" style="height: 20%; margin-top: 20px;" alt="warning.png">
            <h2>Are you sure you want to remove Card No.<span id="remove-Header"></span>? This will remove the card permanently.</h1>
            <form action="" method="post">
                <input type="hidden" name="remove-id"id="remove-card-id">
                <input type="submit" name="removeCard"class="bottom-btn-missing" style="width: 120px; margin-inline: 20px;"value="Confirm">
                <button class="bottom-btn" id="remove-close">Cancel</button>
            </form>
        </div>
        
    </div>


    <script src="javascript/cardManager3.js" defer></script>
    <script src="../js/scan_uid.js" defer></script>
</body>
</html>

<?php 
$conn = mysqli_connect('localhost', 'root', '', 'suncharge');
//adding card
if(isset($_POST['addCard'])){
    $cardUID = $_POST['cardUID'];

    //search for card UID if it exists already
    $scanSql = "SELECT * FROM tbl_cardext WHERE card_uid = '$cardUID'";
    $scanQry = mysqli_query($conn, $scanSql);
    $scanResult = mysqli_num_rows($scanQry);

    if($scanResult > 0){
        echo"
        <script>
            alert('This card UID already exists.');
            window.location.href = 'cardManager.php';
        </script>
        ";
    }else{

    $addSql = "INSERT INTO tbl_cardext VALUES ('', '$cardUID', 'Unused', null, null, null, null, '0')";
    mysqli_query($conn, $addSql);
    echo"
    <script>
        alert('A new card has been added');
        window.location.href = 'cardManager.php';
    </script>
    ";}
}
?>

<?php 
//editing a card
if(isset($_POST['edit-confirm'])){
    $cardNumber = $_POST['edit_id'];
    $name = $_POST['edit_name'];
    $section = $_POST['edit_section'];

    $sql = "UPDATE tbl_cardext SET status = 'Used', used_by = '$name', section = '$section', date_taken = NOW() WHERE card_number = '$cardNumber'";
    mysqli_query($conn, $sql);

    echo"
    <script>
        alert('Card #$cardNumber is now given to $name');
        window.location.href = 'cardManager.php';
    </script>
    ";

}
//returning a card
if(isset($_POST['return-card'])){
    $cardNumber = $_POST['selected-card-id'];

    $sqlReturn = "UPDATE tbl_cardext SET status = 'Unused', used_by = null, section = null, date_taken = null WHERE card_number = '$cardNumber'";
    mysqli_query($conn, $sqlReturn);

    echo"
    <script>
        alert('Card #$cardNumber has been returned');
        window.location.href = 'cardManager.php';
    </script>
    ";
}
//adding balance
if(isset($_POST['addBalance'])){
    $cardNumber = $_POST['balance_id'];
    $balance = $_POST['balance'];

    //get balance
    $getBalanceSql = "SELECT * FROM tbl_cardext WHERE card_number = '$cardNumber'";
    $getBalanceQry = mysqli_query($conn, $getBalanceSql);
    $getBalanceData = mysqli_fetch_assoc($getBalanceQry);
    $currentBalance = $getBalanceData['balance'];

    $newBalance = $balance + $currentBalance;

    $balanceSql = "UPDATE tbl_cardext SET balance = '$newBalance' WHERE card_number = '$cardNumber'";
    mysqli_query($conn, $balanceSql);

    //insert into sales
    $salesBal = "INSERT INTO tbl_sales VALUES ('', NOW(), NOW(), null, 'Card No.$cardNumber', '$balance')";
    mysqli_query($conn, $salesBal);

    echo"
    <script>
        alert('$balance balance has been added to Card #$cardNumber');
        window.location.href = 'cardManager.php'
    </script>
    
    ";
}

if(isset($_POST['removeCard'])){
    $cardNumber = $_POST['remove-id'];

    $removeSql = "DELETE FROM tbl_cardext WHERE card_number = '$cardNumber'";
    mysqli_query($conn, $removeSql);

    echo"
    <script>
        alert('Card No.$cardNumber has been remove in the card list');
        window.location.href = 'cardManager.php';
    </script>
    ";
}
?>