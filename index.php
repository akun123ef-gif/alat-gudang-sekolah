<?php
session_start();
include 'config.php';
include 'db.php';

trace_event("OPEN PAGE index_barang.php");

$kategoriQuery = db_query($conn, "SELECT * FROM kategori ORDER BY kategori ASC");
trace_event("RUN QUERY kategori list");

$selectedKategori = $_GET['kategori'] ?? 'all';
$search = $_GET['search'] ?? '';

trace_event("FILTER kategori=$selectedKategori search=$search");

$where = [];

if ($selectedKategori !== 'all') {
    $where[] = "b.kategori_id = '" . mysqli_real_escape_string($conn, $selectedKategori) . "'";
}

if (!empty($search)) {
    $where[] = "b.nama_barang LIKE '%" . mysqli_real_escape_string($conn, $search) . "%'";
}

$whereSql = count($where) ? "WHERE " . implode(" AND ", $where) : "";

$sql = "
    SELECT 
        b.*, 
        k.kategori
    FROM tbl_barang b
    LEFT JOIN kategori k ON b.kategori_id = k.id
    $whereSql
    ORDER BY b.id ASC
";

$queryBarang = db_query($conn, $sql);
trace_event("RUN QUERY tbl_barang join kategori");
?>
<!DOCTYPE html>
<html>

<head>
    <title>Peminjaman Alat Gudang Sekolah</title>
    <link rel="stylesheet" type="text/css" href="tambahan/bootstrap-4.1.3/dist/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="tambahan/bootstrap-4.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="tambahan/font-awesome/css/font-awesome.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <style>
        /* 1. Mengganti background seluruh halaman */
        body {
            background-color: #607aa1 !important; 
        }

        /* 2. Mengganti background area Selamat Datang (Jumbotron) */
        .jumbotron {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%) !important; 
            color: #ffffff !important; 
            padding: 3rem 1rem !important;
            margin-bottom: 0;
        }

        .jumbotron h1, .jumbotron p {
            color: #ffffff !important;
        }

        /* 3. Mengganti background area daftar barang (Album) */
        .album.bg-light {
            background-color: #607aa1 !important; 
        }

        /* Kartu barang (Card) */
        .album .card {
            background-color: #dfe7ed !important;
            border: none !important;
            border-radius: 15px !important; 
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15) !important; 
            overflow: hidden; 
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            position: relative;
        }

        .album .card:hover {
            transform: translateY(-8px); 
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.25) !important; 
        }

        .album .card-body strong {
            color: #000000 !important; 
            font-size: 16px;
            display: block;
            margin-bottom: 3px;
        }

        .album .card-body .text-muted {
            color: #000000 !important;
        }

        /* Mengubah total tampilan tombol "Pinjam" */
        .album .btn-outline-info {
            color: #000000 !important;
            border-color: #000000 !important;
            border-radius: 25px !important; 
            font-weight: bold;
            width: 100%; 
            margin-top: 10px;
            transition: all 0.2s ease;
        }

        .album .btn-outline-info:hover {
            background-color: #fffcfc !important;
            color: #000000 !important;
            border-color: #980303 !important;
        }

        /* STYLE UNTUK STOK HABIS */
        .album .card.out-of-stock {
            background-color: #9e9e9e !important;
            opacity: 0.7;
        }

        .album .card.out-of-stock:hover {
            transform: none; 
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15) !important;
        }

        .album .card.out-of-stock img {
            filter: grayscale(100%);
            opacity: 0.6;
        }

        /* Badge stok */
        .stock-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0, 0, 0, 0.7);
            color: white;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            z-index: 10;
        }

        .stock-badge.out {
            background-color: #dc3545;
        }

        .stock-badge.available {
            background-color: #28a745;
        }

        /* Informasi stok di card body */
        .stock-info {
            font-size: 13px;
            margin: 8px 0;
            padding: 6px 10px;
            background-color: rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            display: inline-block;
            width: 100%;
            text-align: center;
        }

        .stock-info.out {
            background-color: #f8d7da;
            color: #721c24;
            font-weight: bold;
        }

        .stock-info.available {
            background-color: #d4edda;
            color: #155724;
        }

        /* Tombol disabled untuk stok habis */
        .album .btn-outline-info:disabled {
            background-color: #6c757d !important;
            border-color: #6c757d !important;
            color: #ffffff !important;
            cursor: not-allowed;
            opacity: 0.6;
        }
    </style>
</head>

<body>
    <header>
        <div class="navbar navbar-dark bg-dark shadow-sm">
            <div class="container">
                <a class="navbar-brand align-items-center" style="color:#fff;">
                    <strong>Peminjaman Alat Gudang Sekolah</strong>
                </a>
            </div>
        </div>
    </header>

    <main role="main">
        <section class="jumbotron text-center">
            <div class="container">

                <?php if (isset($_SESSION['username'])) { 
                    $username = $_SESSION['username'];
                    trace_event("SESSION ACTIVE username=$username");
                ?>
                <h1 class="jumbotron-heading" style="font-size: 36px; font-weight: bold;">
                    Selamat Datang, <?= htmlspecialchars($username); ?> 👋
                </h1>

                <p style="margin-bottom: 5px;">
                    Yuk, manfaatkan fasilitas ini untuk meminjam alat Gudang sekolah dengan mudah.
                </p>
                <p style="margin-bottom: 5px;">
                    Bersama, kita bisa membuat sekolah lebih bersih dan nyaman untuk semua.
                </p>
                <p style="margin-bottom: 20px;">
                    Pilih barang yang ingin dipinjam dari daftar barang di bawah.
                </p>

                <div class="btn-group" style="margin-top: 15px;">
                    <a href="logout.php" class="btn btn-danger btn-sm">
                        <i class="fa fa-sign-out"></i> Logout
                    </a>
                </div>

                <?php } else { 
                    trace_event("SESSION EMPTY (GUEST)");
                ?>
                <h1 class="jumbotron-heading" style="font-style: italic; font-weight: bold;">
                    Daftar Barang Gudang Sekolah
                </h1>
                <p>Silahkan masuk ke akun Anda untuk mulai melakukan peminjaman alat.</p>
                <?php } ?>

            </div>
        </section>

        <div class="album py-5 bg-light">
            <div class="container">
                <div class="row">

                    <!-- Bagian Filter & Pencarian -->
                    <div class="col-12 mb-4">
                        <div class="card shadow-sm">
                            <div class="card-body">
                                <form method="GET">
                                    <div class="form-row align-items-end">

                                        <div class="col-md-4 mb-2">
                                            <label style="color: #333 !important;"><b>Kategori</b></label>
                                            <select name="kategori" class="form-control">
                                                <option value="all">Semua Kategori</option>
                                                <?php
                                                mysqli_data_seek($kategoriQuery, 0);
                                                while ($kat = mysqli_fetch_assoc($kategoriQuery)) { ?>
                                                <option value="<?= $kat['id']; ?>" <?=($selectedKategori==$kat['id']) ? 'selected' : '' ; ?>>
                                                    <?= $kat['kategori']; ?>
                                                </option>
                                                <?php } ?>
                                            </select>
                                        </div>

                                        <div class="col-md-5 mb-2">
                                            <label style="color: #333 !important;"><b>Cari Barang</b></label>
                                            <input type="text" name="search" class="form-control" placeholder="Cari nama barang..." value="<?= htmlspecialchars($search); ?>">
                                        </div>

                                        <div class="col-md-3 mb-2">
                                            <button class="btn btn-primary btn-block">
                                                <i class="fa fa-filter"></i> Filter
                                            </button>
                                        </div>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <?php if (mysqli_num_rows($queryBarang) == 0) { 
                        trace_event("RESULT EMPTY tbl_barang");
                    ?>
                    <div class="col-12 text-center text-light">
                        Data barang tidak ditemukan.
                    </div>
                    <?php } ?>

                    <!-- Loop Data Barang -->
                    <?php while ($data = mysqli_fetch_assoc($queryBarang)) { 
                        $stok = isset($data['stok_barang']) ? $data['stok_barang'] : (isset($data['stok']) ? $data['stok'] : 0);
                        $isOutOfStock = ($stok <= 0);
                        $cardClass = $isOutOfStock ? 'out-of-stock' : '';
                        
                        if ($isOutOfStock) {
                            $badgeClass = 'out';
                            $badgeText = 'Stok Habis';
                        } else {
                            $badgeClass = 'available';
                            $badgeText = 'Stok: ' . $stok;
                        }
                    ?>
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm <?= $cardClass; ?>">
                            <span class="stock-badge <?= $badgeClass; ?>">
                                <?= $badgeText; ?>
                            </span>

                            <img src="assets/img/uploads/<?= $data['gambar_barang']; ?>" class="card-img-top" style="height:250px; object-fit:cover;">

                            <div class="card-body">
                                <p class="card-text mb-1">
                                    <strong><?= $data['nama_barang']; ?></strong>
                                    <small class="text-muted">Kategori: <?= $data['kategori'] ?? '-'; ?></small>
                                </p>

                                <div class="stock-info <?= $badgeClass; ?>">
                                    <i class="fa fa-cube"></i> 
                                    <?php if ($isOutOfStock) { ?>
                                        <strong>STOK HABIS</strong>
                                    <?php } else { ?>
                                        Stok Tersedia: <strong><?= $stok; ?></strong>
                                    <?php } ?>
                                </div>

                                <?php if ($isOutOfStock) { ?>
                                    <button class="btn btn-outline-info btn-sm" disabled>
                                        <i class="fa fa-ban"></i> Tidak Tersedia
                                    </button>
                                <?php } else { ?>
                                    <a href="proses-pinjam.php?id_barang=<?= $data['id']; ?>" class="btn btn-outline-info btn-sm">
                                        <i class="fa fa-shopping-cart"></i> Pinjam
                                    </a>
                                <?php } ?>
                            </div>
                        </div>
                    </div>
                    <?php } ?>

                </div>
            </div>
        </div>
    </main>

    <footer>
        <div class="bg-dark py-4 text-white mt-5">
            <div class="container">
                <div class="row">
                    <div class="col-sm-8">
                        <h4>Tentang Kami</h4>
                        <p>Peminjaman Alat Gudang Sekolah adalah aplikasi berbasis web yang dibuat untuk mempermudah penanganan sarana & prasarana serta menyesuaikan dengan perkembangan Teknologi Informasi.</p>
                    </div>
                    
                    <!-- Bagian Footer Kanan yang Sudah Disesuaikan Secara Dinamis -->
                    <div class="col-sm-4">
                        <h4>Kontak</h4>
                        <p class="mb-4">
                            <i class="fa fa-phone"></i> 0882005977435<br>
                            <i class="fa fa-envelope"></i> akun123ef@email.com
                        </p>
                        
                        <?php if (!isset($_SESSION['username'])) { ?>
                            <h4>Akses Anggota</h4>
                            <p class="text-muted small">Anda belum masuk. Silahkan login terlebih dahulu untuk meminjam barang.</p>
                            <a href="login.php" class="btn btn-primary btn-sm btn-block shadow-sm mb-2">
                                <i class="fa fa-sign-in"></i> Masuk Ke Akun
                            </a>
                           
                        <?php } else { ?>
                            <h4>Status Sesi</h4>
                            <p class="mb-1"><i class="fa fa-user-circle"></i> Login sebagai: <b><?= htmlspecialchars($_SESSION['username']); ?></b></p>
                            <span class="badge badge-success"><i class="fa fa-check-circle"></i> Akun Terhubung</span>
                        <?php } ?>
                    </div>
                </div>
                <hr class="bg-white">
                <div class="text-center">
                    &copy; <?php echo date("Y"); ?> . BRAMI HENDRIANSYAH
                </div>
            </div>
        </div>
    </footer>

    <script type="text/javascript" src="tambahan/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript" src="tambahan/bootstrap-4.1.3/dist/js/bootstrap.min.js"></script>
</body>

</html>