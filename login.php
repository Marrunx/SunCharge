<?php 
session_start();
$conn = mysqli_connect('localhost', 'root', '', 'suncharge');

$username = $_GET['username'];
$password = $_GET['password'];

$sql = "SELECT * FROM admin WHERE username = '$username' && password = '$password'";
$qry = mysqli_query($conn, $sql);
$result = mysqli_num_rows($qry);

if($result < 1){
    echo"<script>
    alert('Invalid Credentials.');
    window.location.href = 'login.html';
    </script>";
}else{
    $_SESSION['status'] = 'logged-in';
    echo"
    <script>
        window.location.href = 'admin/lockerManager.php';
    </script>
    ";
}
?>