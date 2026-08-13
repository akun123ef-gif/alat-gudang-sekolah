<?php
session_start();
include 'config.php';
include 'db.php';

if (isset($_POST['login'])) {
    $username = $_POST['username'];
    $password = md5($_POST['password']);

    $sql = "SELECT * FROM user WHERE username = '$username'";
    $query_username = db_query($conn, $sql);

    if (mysqli_num_rows($query_username) > 0) {
        $data = mysqli_fetch_array($query_username);

        if ($password == $data['password']) {

            $_SESSION['username'] = $data['username'];
            $_SESSION['name']     = $data['nama'];
            $_SESSION['uid']      = $data['uid'];
            $_SESSION['level']    = $data['level'];

            $ip      = $_SERVER['REMOTE_ADDR'] ?? '-';
            $browser = $_SERVER['HTTP_USER_AGENT'] ?? '-';
            $halaman = basename($_SERVER['PHP_SELF']);
            $device  = preg_match('/mobile/i', $browser) ? 'Mobile' : 'Desktop';

            mysqli_query($conn, "
                UPDATE user_log SET
                    action     = 'online',
                    ip_address = '$ip',
                    browser    = '$browser',
                    appname    = '$halaman',
                    device     = '$device',
                    tanggal    = NOW()
                WHERE uid = '{$data['uid']}'
            ");

            trace_event($conn, "LOGIN SUCCESS username=$username");

            if ($data['level'] == 'admin' && $data['uid'] == 2026) {
                header('Location: admin/index.php');
            } elseif ($data['level'] == 'petugas' && $data['uid'] == 2025) {
                header('Location: petugas/index.php');
            } else {
                header('Location: index.php');
            }

        } else {
            trace_event($conn, "LOGIN FAILED password salah, username=$username");
            echo "<script>alert('Password salah'); window.history.back();</script>";
        }
    } else {
        trace_event($conn, "LOGIN FAILED username tidak di temukan, username=$username");
        echo "<script>alert('Username atau Password tidak terdaftar'); window.history.back();</script>";
    }
}
?>
