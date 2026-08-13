<?php
    session_start();
    include '../config.php';
        include '../db.php';

    trace_event("OPEN PAGE petugas/data-user.php");

    if(isset($_GET['opsi']) && $_GET['opsi'] == 'hapus' && isset($_GET['id'])){
        $id           = $_GET['id']; 

        trace_event("REQUEST DELETE user id=$id");

        $query_delete = mysqli_query($conn,"DELETE FROM user WHERE id='$id'");

        if($query_delete){

            trace_event("DELETE SUCCESS user id=$id");

            echo "<script>alert('Data User Berhasil Dihapus');</script>";
            echo "<script>window.location.href = 'data-user.php';</script>";
        }else{

            trace_event("DELETE FAILED user id=$id : ".mysqli_error($conn));

            echo "Gagal hapus ke database;";
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
    <title>Petugas - Peminjaman Alat kebersihan Sekolah</title>
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
    <link rel="stylesheet" href="assets/css/lib/datatable/dataTables.bootstrap.min.css">
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

    <!-- Left Panel -->

    <!-- Right Panel -->

    <div id="right-panel" class="right-panel">

        <?php
            include 'header.php';
            trace_event("LOAD header.php");
        ?>
        <div class="breadcrumbs">
            <div class="col-sm-4">
                <div class="page-header float-left">
                    <div class="page-title">
                        <h1>Data User
                            <a href="data-user.php" class="btn btn-info btn-sm">
                                <i class="fa fa-refresh"></i>
                                Refresh
                            </a>
                        </h1>
                    </div>
                </div>
            </div>
            <div class="col-sm-8">
                <div class="page-header float-right">
                    <div class="page-title">
                        <ol class="breadcrumb text-right">
                            <li><a href="#">Dashboard</a></li>
                            <li><a href="#">User</a></li>
                            <li class="active">Data User</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>

        <div class="content mt-3">
            <div class="animated fadeIn">
                <div class="row">

                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <strong class="card-title">Data User</strong>
                                <a href="javascript:void(0);" class="btn btn-success btn-sm disabled"
                                    style="margin-left: 20px;">
                                    <i class="fa fa-plus"></i>
                                    Tambah Admin & Petugas
                                </a>
                                <a href="javascript:void(0);" onclick="cetakLaporan(event)"
                                    class="btn btn-success btn-sm " style="margin-left: 20px;">
                                    <i class="fa fa-print"></i>
                                    Cetak Laporan
                                </a>
                            </div>
                            <div class="card-body">
                                <table id="bootstrap-data-table" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Nama</th>
                                            <th>Username</th>
                                            <th>Jabatan</th>
                                            <th>Opsi</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                            include '../config.php';

                            trace_event("RUN QUERY SELECT * FROM user");

                            $query = mysqli_query($conn,"SELECT * FROM user ORDER BY id");

                            if(!$query){
                                trace_event("QUERY FAILED user : ".mysqli_error($conn));
                            }

                            $no = 1;
                            while ($data=mysqli_fetch_array($query)) {

                                trace_event("FETCH user id=".$data['id']." username=".$data['username']);
                        ?>
                                        <tr>
                                            <td>
                                                <?php echo $no++; ?>
                                            </td>
                                            <td>
                                                <?php echo $data['nama']; ?>
                                            </td>
                                            <td>
                                                <?php echo $data['username']; ?>
                                            </td>
                                            <td>
                                                <?php echo ucfirst($data['level']); ?>
                                            </td>
                                            <td>
                                                <a class="btn btn-danger btn-sm disabled" href="javascript:void(0);"
                                                    onclick="return confirm('Yakin hapus user ini?')">
                                                    <i class="fa fa-times"></i> Hapus
                                                </a>

                                                <a class="btn btn-info btn-sm disabled" href="javascript:void(0);">

                                                    <i class="fa fa-pencil"></i> Edit
                                                </a>
                                            </td>

                                        </tr>
                                        <?php
                            }
                        ?>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>


                </div>
            </div><!-- .animated -->
        </div><!-- .content -->


    </div><!-- /#right-panel -->

    <!-- Right Panel -->


    <script src="assets/js/vendor/jquery-2.1.4.min.js"></script>
    <script src="assets/js/popper.min.js"></script>
    <script src="assets/js/plugins.js"></script>
    <script src="assets/js/main.js"></script>


    <script src="assets/js/lib/data-table/datatables.min.js"></script>
    <script src="assets/js/lib/data-table/dataTables.bootstrap.min.js"></script>
    <script src="assets/js/lib/data-table/dataTables.buttons.min.js"></script>
    <script src="assets/js/lib/data-table/buttons.bootstrap.min.js"></script>
    <script src="assets/js/lib/data-table/jszip.min.js"></script>
    <script src="assets/js/lib/data-table/pdfmake.min.js"></script>
    <script src="assets/js/lib/data-table/vfs_fonts.js"></script>
    <script src="assets/js/lib/data-table/buttons.html5.min.js"></script>
    <script src="assets/js/lib/data-table/buttons.print.min.js"></script>
    <script src="assets/js/lib/data-table/buttons.colVis.min.js"></script>
    <script src="assets/js/lib/data-table/datatables-init.js"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            $('#bootstrap-data-table-export').DataTable();
        });
    </script>
    <script>
        function cetakLaporan(e) {
            if (e) e.preventDefault();

            var table = $('#bootstrap-data-table').DataTable();
            var length = table.page.len();
            var page = table.page.info().page;
            var start = page * length;

            window.open(
                'cetak_data_user.php?limit=' + length + '&start=' + start,
                '_blank'
            );
        }


    </script>

</body>

</html>