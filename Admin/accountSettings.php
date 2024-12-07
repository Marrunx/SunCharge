<?php 
session_start();
if(empty($_SESSION['status'])){
    header('Location: ../login.html');
}

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

    <link rel="stylesheet" href="style/main.css">
    <link rel="stylesheet" href="style/nav.css">
    <link rel="stylesheet" href="style/accountSettings.css">


    <title>RE:Charge | Settings </title>
</head>

<body>
    <div class="main">
        <div class="nav-bar">
            <h1>RE:Charge</h1>
            
            <a href="lockerManager.php">Locker Manager</a>
            <a href="cardManager.php">Card Manager</a>
            <a href="">Settings</a>
            <a href="logout.php" id="log-out">Logout</a>
        </div>

        <div class="body">
            <div class="side-nav">
                <p id="user-settings-btn">Change username and password</p>
                <p id="locker-settings-btn">Locker settings</p>
            </div>

            <div class="selected-content">
                <div class="user-settings" id="user-settings">
                    <h1>Administrator Settings</h1>
                    <form action="" method="post" class="user-forms">
                        <input type="text" name="username" id="" class="input-txt" placeholder="New Username">
                        <input type="password" name="password" class="input-txt" placeholder="New Password">
                        <input type="password" name="old-password" class="input-txt" placeholder="Old password">
                        <input type="submit" name="save-user" value="Save Changes" class="save-btn">
                    </form>
                </div>

                <div class="locker-settings" id="locker-settings">
                    <h1>Locker Settings</h1>
                    <form action="" method="post" class="locker-forms">
                        <input type="text" id="uid-display"  placeholder="Change locker UID" class="input-txt" name="locker1">
                        <input type="submit" class="save-btn" name="save-locker" value="Save changes">
                    </form>
                </div>
            </div>
        </div>


    </div>
</body>

<script src="javascript/settings.js" defer></script>
<script src="../js/scan_uid.js" defer></script>
</html>


<?php
$conn = mysqli_connect('localhost', 'root', '', 'suncharge');

//save admin changes
if(isset($_POST['save-user'])){
    //get all input values
    $username = $_POST['username'];
    $newPassword = $_POST['password'];
    $oldPassword = $_POST['old-password'];

    //check if old password matches with password in database
    $sqlCheckPw = "SELECT * FROM admin WHERE password = '$oldPassword'";
    $qryCheckPw = mysqli_query($conn, $sqlCheckPw);

    if(empty($_POST['username']) && empty($_POST['password'])){
        echo"
        <script>
            alert('Insert at least new username or new password');
        </script>
        ";
    }else if($checkPwResult = mysqli_num_rows($qryCheckPw) < 1){
        echo"
        <script>
            alert('Password does not match');
        </script>
        ";
    }else{
        if(!empty($_POST['username']) && !empty($_POST['password'])){
            $updateSql = "UPDATE admin SET username = '$username', password = '$newPassword' WHERE id=0";
            $updateQry = mysqli_query($conn, $updateSql);

            echo"
            <script>
                alert('Changes saved successfully');
            </script>
            ";
        }else if(!empty($_POST['username']) && empty($_POST['password'])){
            $updateSql = "UPDATE admin SET username = '$username' WHERE id=0";
            $updateQry = mysqli_query($conn, $updateSql);

            echo"
            <script>
                alert('Changes saved successfully');
            </script>
            ";
        }else if(empty($_POST['username']) && !empty($_POST['password'])){
            $updateSql = "UPDATE admin SET password = '$newPassword' WHERE id=0";
            $updateQry = mysqli_query($conn, $updateSql);

            echo"
            <script>
                alert('Changes saved successfully');
            </script>
            ";
        }
    }
}


//save locker changes
if(isset($_POST['save-locker'])){

    $locker1 = $_POST['locker1'];

    if(!empty($_POST['locker1']) && !empty($_POST['locker2'])){
        $sqlUID1 = "UPDATE tbl_card SET card_uid = '$locker1' WHERE card_number = 1";
        $qryUID1 = mysqli_query($conn, $sqlUID1);

        $sqlUID2 = "UPDATE tbl_card SET card_uid = '$locker2' WHERE card_number = 2";
        $qryUID2 = mysqli_query($conn, $sqlUID2);

        echo"
        <script>
            alert('Changes has been saved.');
        </script>
        ";

    }else if(!empty($_POST['locker1']) && empty($_POST['locker2'])){
        $sqlUID1 = "UPDATE tbl_card SET card_uid = '$locker1' WHERE card_number = 1";
        $qryUID1 = mysqli_query($conn, $sqlUID1);

        echo"
        <script>
            alert('Changes has been saved.');
        </script>
        ";

    }else if(empty($_POST['locker1']) && !empty($_POST['locker2'])){
        $sqlUID2 = "UPDATE tbl_card SET card_uid = '$locker2' WHERE card_number = 2";
        $qryUID2 = mysqli_query($conn, $sqlUID2);

        echo"
        <script>
            alert('Changes has been saved.');
        </script>
        ";
    }
}
?>


