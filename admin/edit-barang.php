<?php
session_start();
include '../config.php';
include '../db.php';

trace_event("OPEN PAGE admin/edit-barang.php");

$query_kategori = mysqli_query(
    $conn,
    "SELECT * FROM kategori ORDER BY kategori ASC"
);

trace_event("RUN QUERY SELECT kategori");

if (isset($_POST['edit-barang'])) {

    trace_event("SUBMIT FORM edit-barang");

    $id          = $_POST['id'];
    $nama_barang = $_POST['nama_barang'];
    $stok_barang = $_POST['stok_barang'];
    $kategori_id = $_POST['kategori_id'];

    trace_event("POST DATA id=$id nama_barang=$nama_barang stok_barang=$stok_barang kategori_id=$kategori_id");

    $sql = "UPDATE tbl_barang SET
                nama_barang='$nama_barang',
                stok_barang='$stok_barang',
                kategori_id='$kategori_id'
            WHERE id='$id'";

    trace_event("PREPARE UPDATE tbl_barang id=$id");

    if (!empty($_FILES['gambar_barang']['name'])) {

        trace_event("UPLOAD IMAGE detected for tbl_barang id=$id");

        $file_name = str_replace(" ", "_", $_FILES['gambar_barang']['name']);
        $file_size = $_FILES['gambar_barang']['size'];
        $file_type = $_FILES['gambar_barang']['type'];
        $tmp_name  = $_FILES['gambar_barang']['tmp_name'];
        $extension = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
        $max_size  = 2000000;

        if (
            in_array($extension, ['jpg','jpeg','png','gif']) &&
            in_array($file_type, ['image/jpeg','image/png','image/gif']) &&
            $file_size <= $max_size
        ) {

            trace_event("UPLOAD IMAGE VALID file=$file_name size=$file_size");

            move_uploaded_file($tmp_name, "../assets/img/uploads/".$file_name);

            trace_event("MOVE UPLOADED FILE success file=$file_name");

            $sql = "UPDATE tbl_barang SET
                        nama_barang='$nama_barang',
                        stok_barang='$stok_barang',
                        kategori_id='$kategori_id',
                        gambar_barang='$file_name'
                    WHERE id='$id'";

            trace_event("PREPARE UPDATE tbl_barang WITH IMAGE id=$id");
        }
    }

    if (mysqli_query($conn, $sql)) {

        trace_event("UPDATE SUCCESS tbl_barang id=$id");

        echo "<script>alert('Berhasil Disimpan');</script>";
        echo "<script>window.location.href = 'data-barang.php';</script>";
        exit;
    } else {

        trace_event("UPDATE FAILED tbl_barang id=$id : ".mysqli_error($conn));

        echo "<script>alert('Gagal Update');</script>";
    }
}

if (isset($_GET['id'])) {

    $id = $_GET['id'];

    trace_event("REQUEST GET edit-barang id=$id");

    $q  = mysqli_query($conn, "SELECT * FROM tbl_barang WHERE id='$id'");

    if(!$q){
        trace_event("QUERY FAILED tbl_barang id=$id : ".mysqli_error($conn));
    }

    $d  = mysqli_fetch_assoc($q);

    trace_event("FETCH tbl_barang id=$id");

    $nama_barang   = $d['nama_barang'];
    $stok_barang   = $d['stok_barang'];
    $gambar_barang = $d['gambar_barang'];
    $kategori_id   = $d['kategori_id'];
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
    <title>Admin - Tambah Barang</title>
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
    <!-- <link rel="stylesheet" href="assets/css/bootstrap-select.less"> -->
    <link rel="stylesheet" href="assets/scss/style.css">

    <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700,800' rel='stylesheet' type='text/css'>

    <!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/html5shiv/3.7.3/html5shiv.min.js"></script> -->

</head>

<body>
    <?php
        include 'sidebar.php';
        trace_event("LOAD sidebar.php");
    ?>
    <div id="right-panel" class="right-panel">
        <?php
            include 'header.php'; 
            trace_event("LOAD header.php");
        ?>
        <div class="breadcrumbs">
            <div class="col-sm-6">
                <div class="page-header float-left">
                    <div class="page-title" style="padding: 20px 0;">
                        <h1 style="display: unset;">Edit Data Barang</h1>
                        <a href="data-barang.php" class="btn btn-info btn-sm" style="margin-left: 20px;">
                            <i class="fa fa-arrow-left"></i>
                            Kembali
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
                            <li class="active">Edit Data</li>
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
                            <div class="card-header"><strong>Edit Data Barang </strong></div>
                            <form class="card-body card-block" action="" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="id" value="<?php echo$id;?>">
                                <div class="form-group">
                                    <label for="nama" class=" form-control-label">Nama Barang</label>
                                    <input type="text" id="nama" name="nama_barang" class="form-control"
                                        value="<?php echo $nama_barang;?>">
                                </div>
                                <div class="form-group">
                                    <label class="form-control-label">Kategori</label>
                                    <select name="kategori_id" class="form-control" required>
                                        <option value="">-- Pilih Kategori --</option>
                                        <?php while ($k = mysqli_fetch_assoc($query_kategori)) { ?>
                                        <option value="<?php echo $k['id']; ?>" <?php if ($k['id']==$kategori_id)
                                            echo 'selected' ; ?>>
                                            <?php echo $k['kategori']; ?>
                                        </option>
                                        <?php } ?>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <img src="../assets/img/uploads/<?php echo $gambar_barang;?>"
                                        style="width: 200px;"><br>
                                    <label for="gambar" class="form-control-label">Upload Foto Barang</label>
                                    <input type="file" id="gambar" name="gambar_barang" class="form-control">
                                </div>
                                <div class="form-group">
                                    <label for="stok" class=" form-control-label">Jumlah Barang</label>
                                    <input type="number" id="stok" name="stok_barang" value="<?php echo $stok_barang;?>"
                                        class="form-control">
                                </div>
                                <button type="submit" class="btn btn-success" name="edit-barang">
                                    <i class="fa fa-check"></i>
                                    Simpan
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
