<?php
	session_start();
	include 'config.php';
	include 'db.php';
	trace_event("OPEN FORM PINJAM BARANG");

	if (isset($_SESSION['username'])) {
    	$username = $_SESSION['username'];
		trace_event("SESSION ACTIVE username=$username");

		$qUser = mysqli_query($conn,"SELECT nama, level FROM user WHERE username='$username' ");
		trace_event("RUN SQL : SELECT nama, level FROM user WHERE username='$username'");

		$dUser = mysqli_fetch_array($qUser);
		$nama_peminjam = $dUser['nama'];
		$jabatan = $dUser['level'];

		$id_barang 		= $_GET['id_barang'];
		trace_event("GET id_barang=$id_barang");

		$search_barang 	= mysqli_query($conn,"SELECT * FROM tbl_barang WHERE id='$id_barang'");
		trace_event("RUN SQL : SELECT * FROM tbl_barang WHERE id='$id_barang'");

		$data 			= mysqli_fetch_array($search_barang);
		$nama_barang	= $data['nama_barang'];
		trace_event("BARANG FOUND nama_barang=$nama_barang");

?>
<!DOCTYPE html>
<html>

<head>
	<title>Peminjaman | Peminjaman Alat kebersihan Sekolah</title>
	<link rel="stylesheet" type="text/css" href="tambahan/bootstrap/dist/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="tambahan/bootstrap/dist/css/bootstrap.min.css">
	<link href="assets/datepicker/css/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
	<link rel="stylesheet" type="text/css" href="tambahan/font-awesome/css/font-awesome.css">
	<link rel="stylesheet" type="text/css" href="assets/css/register-style.css">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

</head>

<body style="background-image: url('') !important;">
	<div class="container">
		<div class='row'>
			<div class="col-md-4"></div>
			<div class="col-md-4 form-register-container">
				<h2 class="">Peminjaman Barang</h2>
				<form action="request-barang.php" method="post">
					<label>Username</label>
					<input class="form-control" name="username" value="<?= $username; ?>" readonly>
					<label>Nama Peminjam</label>
					<input class="form-control" name="nama_peminjam" value="<?= $nama_peminjam; ?>" readonly>
					<label>Kelas</label>
					<input class="form-control" name="level" value="<?= $jabatan; ?>" readonly>
					<label>Nama Barang</label>
					<input class="form-control" type="" name="nama_barang" required readonly
						value="<?php echo $data['nama_barang'];?>">
					<label>Jumlah barang</label>
					<input class="form-control" type="number" name="jml_barang" required>
					<div class="form-group">
						<label>Tanggal Pinjam</label>
						<input type="date" name="tgl_pinjam" class="form-control" required>
					</div>

					<div class="form-group">
						<label>Tanggal Kembali</label>
						<input type="date" name="tgl_kembali" class="form-control" required>
					</div>

					<button type="submit" name="request-pinjam" class="btn btn-success btn-request"
						style="margin-top: 20px;">REQUEST</button>
				</form>
			</div>
		</div>
	</div>
	<?php
} else {
	trace_event("SESSION EMPTY - REDIRECT LOGIN");
    header("Location: login.php");
    exit;
}

?>
	<script type="text/javascript" src="tambahan/jquery/dist/jquery.min.js"></script>
	<script type="text/javascript" src="tambahan/bootstrap/dist/js/bootstrap.js"></script>
	<script type="text/javascript" src="tambahan/bootstrap/dist/js/bootstrap.min.js"></script>

	<script src="assets/js/moment.min.js"></script>
	<script type="text/javascript" src="assets/datepicker/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>
	<script type="text/javascript" src="assets/datepicker/js/locales/bootstrap-datetimepicker.id.js"
		charset="UTF-8"></script>
	<script type="text/javascript">
		$('.form_datetime').datetimepicker({
			language: 'id',
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			forceParse: 0,
			showMeridian: 1
		});
		$('.form_date').datetimepicker({
			language: 'id',
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
		});
		$('.form_time').datetimepicker({
			language: 'id',
			weekStart: 1,
			todayBtn: 1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 1,
			minView: 0,
			maxView: 1,
			forceParse: 0
		});
	</script>
	<script>
		document.querySelectorAll('.btn-request').forEach(function (btn) {
			btn.addEventListener('click', function (e) {
				if (this.classList.contains('disabled')) {
					e.preventDefault();
					return false;
				}

				this.classList.add('disabled');
				this.innerHTML = '<i class="fa fa-spinner fa-spin"></i> Proses...';
			});
		});
	</script>
</body>

</html>
