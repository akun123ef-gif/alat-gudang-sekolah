<?php
	session_start();
	include '../config.php';
	include '../db.php';

	trace_event("OPEN PAGE admin/edit-kategori.php");

	if(isset($_POST['edit-kategori'])){
        $id         = $_POST['id'];
		$kategori   = $_POST['nama_kategori'];
		$deskripsi  = $_POST['deskripsi'];

		trace_event("REQUEST UPDATE kategori id=$id nama='$kategori' deskripsi='$deskripsi'");

		$query_update = mysqli_query($conn,"UPDATE kategori SET kategori='$kategori', desc1='$deskripsi' WHERE id='$id'");
        if($query_update){
            trace_event("UPDATE SUCCESS kategori id=$id");
            echo "<script>alert('Berhasil Update Kategori!');</script>";
            echo "<script>window.location.href = 'data-kategori.php' ;</script>";
        }else{
            trace_event("UPDATE FAILED kategori id=$id : ".mysqli_error($conn));
            echo "Gagal update data ke server!;";
        } 
    }

	if(isset($_GET['id'])){
		$id = $_GET['id'];
		trace_event("REQUEST FETCH kategori id=$id");

		$query = mysqli_query($conn,"SELECT * FROM kategori WHERE id='$id'");
		if(!$query){
			trace_event("FETCH FAILED kategori id=$id : ".mysqli_error($conn));
		}

		$data  = mysqli_fetch_array($query);
		trace_event("FETCH SUCCESS kategori id=$id nama=".$data['kategori']);

		$nama_kategori   = $data['kategori'];
		$deskripsi       = $data['desc1'];
	}
?>

<!doctype html>
<html class="no-js" lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Admin - Edit Kategori</title>
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
                        <h1 style="display: unset;">Edit Data Kategori</h1>
                        <a href="data-kategori.php" class="btn btn-info btn-sm" style="margin-left: 20px;">
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
                            <li><a href="#">Kategori</a></li>
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
                          <div class="card-header"><strong>Edit Data Kategori </strong></div>
                          <form class="card-body card-block" action="" method="POST">
                          	<input type="hidden" name="id" value="<?php echo$id;?>">
                            <div class="form-group">
                                <label for="nama" class=" form-control-label">Kategori</label>
                                <input type="text" id="nama" name="nama_kategori" class="form-control" value="<?php echo $nama_kategori;?>"> 
                            </div>
                            <div class="form-group">
                                <label for="stok" class=" form-control-label">Deskripsi</label>
                                <input type="text" id="stok" name="deskripsi" value="<?php echo $deskripsi;?>" class="form-control"> 
                            </div>
                            <button type="submit" class="btn btn-success" name="edit-kategori">
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
