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
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Masuk SMKN 1 Sanden</title>
    <link rel="stylesheet" type="text/css" href="tambahan/bootstrap-4.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="tambahan/font-awesome/css/font-awesome.css">
    
    <style>
        :root {
            --bg-gradient: linear-gradient(135deg, #0b1528 0%, #111e36 100%);
            --card-bg: #1a263f;
            --accent-blue: #38bdf8;
            --accent-purple: #818cf8;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --input-border: #334155;
            --input-focus: #38bdf8;
        }

        body {
            background: var(--bg-gradient);
            font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
            height: 100vh;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            padding: 15px;
        }

        /* Wrapper Box Login */
        .login-split-wrapper {
            width: 100%;
            max-width: 950px;
            height: 600px;
            background: var(--card-bg);
            border-radius: 24px;
            box-shadow: 0 25px 60px rgba(0, 0, 0, 0.5);
            display: flex;
            position: relative;
            overflow: hidden;
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        /* SISI KIRI: Efek Potongan Miring */
        .visual-slanted-side {
            flex: 1.1;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: var(--text-main);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px;
            text-align: center;
            position: relative;
            z-index: 2;
        }

        /* Potongan miring diagonal */
        .visual-slanted-side::after {
            content: '';
            position: absolute;
            top: 0;
            right: -80px;
            bottom: 0;
            width: 160px;
            background: inherit;
            transform: skewX(-8deg); 
            z-index: 1;
            border-right: 1px solid rgba(56, 189, 248, 0.1);
        }

        .inner-visual-content {
            position: relative;
            z-index: 3;
        }

        .brand-logo-modern {
            width: 110px;
            height: auto;
            margin-bottom: 25px;
            border-radius: 16px;
            padding: 6px;
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.1);
            filter: drop-shadow(0px 10px 20px rgba(0, 0, 0, 0.4));
            animation: floatAnimation 4s ease-in-out infinite;
        }

        @keyframes floatAnimation {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-8px); }
            100% { transform: translateY(0px); }
        }

        .brand-main-title {
            font-size: 28px;
            font-weight: 800;
            letter-spacing: 1.5px;
            margin-bottom: 8px;
            color: var(--text-main);
        }

        .brand-tagline {
            font-size: 14px;
            color: var(--text-muted);
            line-height: 1.6;
        }

        /* SISI KANAN: Area Form */
        .form-slanted-side {
            flex: 1;
            padding: 50px 50px 50px 100px; /* Jarak kiri lebar agar tidak terpotong area miring */
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: var(--card-bg);
            position: relative;
            z-index: 2;
        }

        .welcome-text {
            color: var(--text-main);
            font-weight: 800;
            font-size: 26px;
            margin-bottom: 5px;
        }

        .sub-welcome {
            color: var(--text-muted);
            font-size: 14px;
            margin-bottom: 30px;
        }

        /* NAV TAB SEJAJAR (TIDAK ATAS BAWAH) */
        .modern-underline-tabs {
            border-bottom: 2px solid var(--input-border);
            margin-bottom: 30px;
            display: flex !important;
            flex-direction: row !important; /* Memaksa menu berjejer menyamping */
            flex-wrap: nowrap;
        }

        .modern-underline-tabs .nav-item {
            margin-bottom: -2px;
        }

        .modern-underline-tabs .nav-link {
            border: none;
            color: var(--text-muted);
            font-weight: 700;
            font-size: 14px;
            padding: 10px 0;
            margin-right: 30px; /* Jarak antar menu samping */
            position: relative;
            background: transparent !important;
            white-space: nowrap; /* Mencegah teks patah ke bawah */
            transition: all 0.3s;
        }

        .modern-underline-tabs .nav-link.active {
            color: var(--accent-blue) !important;
        }

        .modern-underline-tabs .nav-link.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: var(--accent-blue);
            border-radius: 3px;
            box-shadow: 0 0 10px rgba(56, 189, 248, 0.5);
        }

        .form-group {
            margin-bottom: 22px;
        }

        .form-group label {
            font-weight: 700;
            color: var(--text-muted);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 8px;
            display: block;
        }

        .input-container-block {
            position: relative;
        }

        .input-container-block i {
            position: absolute;
            left: 16px;
            top: 15px;
            color: var(--text-muted);
            font-size: 16px;
            z-index: 5;
            transition: color 0.3s;
        }

        /* Input Style */
        .slanted-input-style {
            padding-left: 48px !important;
            height: 48px;
            border-radius: 12px;
            border: 1.5px solid var(--input-border);
            background-color: rgba(15, 23, 42, 0.3);
            color: var(--text-main);
            font-size: 14px;
            width: 100%;
            transition: all 0.3s ease;
            display: block;
        }

        .slanted-input-style:focus {
            border-color: var(--input-focus);
            background-color: rgba(15, 23, 42, 0.5);
            box-shadow: 0 0 0 4px rgba(56, 189, 248, 0.1);
            outline: none;
        }

        .slanted-input-style:focus + i {
            color: var(--accent-blue);
        }

        /* Tombol Gradasi */
        .btn-slanted-submit {
            background: linear-gradient(135deg, var(--accent-blue) 0%, var(--accent-purple) 100%);
            border: none;
            color: #0b1528;
            height: 48px;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 700;
            margin-top: 20px;
            box-shadow: 0 6px 20px rgba(129, 140, 248, 0.3);
            transition: all 0.3s ease;
            width: 100%;
        }

        .btn-slanted-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(129, 140, 248, 0.45);
            color: #0b1528;
        }

        .hint-register-text {
            text-align: center;
            margin-top: 25px;
            font-size: 13px;
            color: var(--text-muted);
        }

        .hint-register-text a {
            color: var(--accent-blue);
            font-weight: 700;
            text-decoration: none;
        }

        /* Responsif HP */
        @media (max-width: 850px) {
            .login-split-wrapper {
                flex-direction: column;
                height: auto;
            }
            .visual-slanted-side {
                padding: 40px 20px;
                flex: none;
            }
            .visual-slanted-side::after {
                display: none;
            }
            .form-slanted-side {
                padding: 40px 25px;
            }
            .brand-logo-modern {
                width: 85px;
            }
            .modern-underline-tabs .nav-link {
                margin-right: 20px;
                font-size: 13px;
            }
        }
    </style>
</head>

<body>

    <div class="login-split-wrapper">
        
        <div class="visual-slanted-side">
            <div class="inner-visual-content">
                <img src="assets/img/smk.jpg" alt="Logo SMKN 1 Sanden" class="brand-logo-modern">
                <h1 class="brand-main-title">E-GUDANG</h1>
                <p class="brand-tagline">Sistem Informasi Peminjaman Sarpras<br>SMKN 1 Sanden Bantul</p>
            </div>
        </div>

        <div class="form-slanted-side">
            <h2 class="welcome-text">Selamat Datang 👋</h2>
            <p class="sub-welcome">Silakan masuk untuk menggunakan layanan logistik sekolah.</p>

            <ul class="nav nav-tabs modern-underline-tabs" id="gudangTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="siswa-tab" data-toggle="tab" href="#siswa-form" role="tab">
                        <i class="fa fa-user mr-1"></i> Siswa / Peminjam
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="admin-tab" data-toggle="tab" href="#admin-form" role="tab">
                        <i class="fa fa-user-secret mr-1"></i> Petugas / Admin
                    </a>
                </li>
            </ul>

            <div class="tab-content" id="gudangTabContent">
                <div class="tab-pane fade show active" id="siswa-form" role="tabpanel">
                    <form action="proses-login.php" method="POST">
                        <input type="hidden" name="role" value="peminjam">
                        
                        <div class="form-group">
                            <label>Username / NISN</label>
                            <div class="input-container-block">
                                <input type="text" name="username" class="slanted-input-style" placeholder="Masukkan ID pengguna" required autocomplete="off">
                                <i class="fa fa-user"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Kata Sandi</label>
                            <div class="input-container-block">
                                <input type="password" name="password" class="slanted-input-style" placeholder="••••••••" required>
                                <i class="fa fa-lock"></i>
                            </div>
                        </div>

                        <button type="submit" name="login" class="btn btn-slanted-submit">
                            Masuk Ke Akun <i class="fa fa-arrow-right ml-1"></i>
                        </button>
                    </form>
                </div>

                <div class="tab-pane fade" id="admin-form" role="tabpanel">
                    <form action="proses-login.php" method="POST">
                        <input type="hidden" name="role" value="staff">

                        <div class="form-group">
                            <label>ID Petugas</label>
                            <div class="input-container-block">
                                <input type="text" name="username" class="slanted-input-style" placeholder="Username khusus petugas" required autocomplete="off">
                                <i class="fa fa-user-circle"></i>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Kata Sandi</label>
                            <div class="input-container-block">
                                <input type="password" name="password" class="slanted-input-style" placeholder="••••••••" required>
                                <i class="fa fa-lock"></i>
                            </div>
                        </div>

                        <button type="submit" name="login" class="btn btn-slanted-submit">
                            Otorisasi Admin <i class="fa fa-shield ml-1"></i>
                        </button>
                    </form>
                </div>
            </div>

            <div class="hint-register-text">
                Belum terdaftar sebagai peminjam? <a href="register.php">Buat Akun Baru</a>
            </div>
        </div>

    </div>

    <script type="text/javascript" src="tambahan/jquery/dist/jquery.min.js"></script>
    <script type="text/javascript" src="tambahan/bootstrap-4.1.3/dist/js/bootstrap.min.js"></script>
</body>
</html>