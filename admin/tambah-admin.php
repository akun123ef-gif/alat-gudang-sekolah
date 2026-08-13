<?php
session_start();
include '../config.php';
include '../db.php';

trace_event("OPEN PAGE admin/tambah-admin.php");

if(isset($_POST['tambah-admint'])){
    trace_event("POST form submitted");

    $nama     = $_POST['nama'];
    $username = $_POST['username'];
    $password = md5($_POST['password']);
    $level    = $_POST['level'];
    $uid      = $_POST['uid'];

    trace_event("DATA INPUT | nama=$nama | username=$username | level=$level | uid=$uid");

    $query_insert = mysqli_query($conn, "
        INSERT INTO user (nama, username, password, level, uid) 
        VALUES ('$nama', '$username', '$password', '$level', '$uid')
    ");

    trace_event("RUN QUERY INSERT INTO user");

    if($query_insert){
        trace_event("INSERT user BERHASIL: username=$username");
        echo "<script>alert('Data Berhasil Dikirim!');</script>";
        echo "<script>window.location.href = 'data-user.php';</script>";
    }else{
        trace_event("GAGAL INSERT user: ".mysqli_error($conn));
        echo "Gagal kirim data ke server!; " . mysqli_error($conn);
    }
}
?>

<!doctype html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang=""> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8" lang=""> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9" lang=""> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js" lang=""> <!--<![endif]-->

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin - Tambah Admin & Petugas & peminjam</title>
    <meta name="description" content="Sufee Admin - HTML5 Admin Template">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="apple-icon.png">
    <link rel="shortcut icon" href="favicon.ico">

    <link rel="stylesheet" href="assets/css/normalize.css">
    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
    <link rel="stylesheet" href="assets/css/themify-icons.css">
    <link rel="stylesheet" href="assets/css/flag-icon.min.css">
    <link rel="stylesheet" href="assets/css/cs-skin-elastic.css">
    <link rel="stylesheet" href="assets/scss/style.css">

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>

</head>

<body>
    <?php include 'sidebar.php'; ?>
    <div id="right-panel" class="right-panel">
        <?php include 'header.php'; ?>
        <div class="breadcrumbs">
            <div class="col-sm-6">
                <div class="page-header float-left">
                    <div class="page-title" style="padding: 20px 0;">
                        <h1 style="display: unset;">Tambah Admin & Petugas & peminjam</h1>
                        <a href="data-user.php" class="btn btn-info btn-sm" style="margin-left: 20px;">
                            <i class="fa fa-search"></i>
                            Lihat Data User
                        </a>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="#">Dashboard</a></li>
                            <li><a href="#">Barang</a></li>
                            <li class="active">Tambah Admin & Petugas & peminjam</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <div class="content mt-3">
            <div class="animated fadeIn">
                <div class="row">
                    <div class="col-lg-3"></div>
                    <div class="col-lg-6">
                        <div class="card">
                            <div class="card-header"><strong>Tambah Data Admin & Petugas & peminjam</strong></div>
                            <form class="card-body card-block" action="" method="POST" enctype="multipart/form-data">
                                <div class="form-group">
                                    <label for="nama" class="form-control-label">Nama</label>
                                    <input type="text" id="nama" name="nama" placeholder="Isikan Nama Anda"
                                        class="form-control" required>
                                </div>

                                <div class="form-group">
                                    <label for="username" class="form-control-label">Username</label>
                                    <input type="text" id="username" name="username"
                                        placeholder="Username dipakai untuk login" class="form-control" required>
                                </div>

                                <div class="form-group">
                                    <label for="password" class="form-control-label">Password</label>
                                    <input type="password" id="password" name="password" placeholder="Password Anda"
                                        class="form-control" required>
                                </div>

                                <div class="form-group">
                                    <label class="form-control-label">Level</label><br>
                                    <small class="text-muted">Pilih Admin & Petugas & peminjam, Diisi Jika BUKAN Admin & Petugas & peminjam</small><br>
                                    <label>
                                        <input type="radio" name="level" value="admin" checked> Admin
                                    </label>
                                    <label>
                                        <input type="radio" name="level" value="petugas"> Petugas
                                    </label>
                                    <label>
                                        <input type="radio" name="level" value="peminjam"> Peminjam
                                    </label>
                                </div>

                                <div class="form-group">
                                    <label class="form-control-label">UID</label><br>
                                    <small class="text-muted">Pilih UID Jika Admin = 2024 | Petugas = 2025 | Peminjam = 2026</small><br>
                                    <label>
                                        <input type="radio" name="uid" value="2024" checked> 2024
                                    </label>
                                    <label>
                                        <input type="radio" name="uid" value="2025"> 2025
                                    </label>
                                    <label>
                                        <input type="radio" name="uid" value="2026"> 2026
                                    </label>
                                </div>

                                <button type="submit" class="btn btn-success" name="tambah-admint">
                                    <i class="fa fa-check"></i> Tambah
                                </button>
                            </form>

                        </div>

                    </div>
                </div>
            </div>

        </div>

        <script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
        <script src="assets/js/popper.min.js"></script>
        <script src="assets/js/plugins.js"></script>
        <script src="assets/js/main.js"></script>
</body>

</html>
