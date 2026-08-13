-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 10, 2026 at 08:58 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_pinjam_barang`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `desc_all` ()   BEGIN
  DECLARE done INT DEFAULT 0;
  DECLARE tname VARCHAR(255);
  DECLARE cur CURSOR FOR 
    SELECT table_name FROM information_schema.tables 
    WHERE table_schema = DATABASE();
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

  OPEN cur;

  read_loop: LOOP
    FETCH cur INTO tname;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SET @s = CONCAT('DESC ', tname);
    PREPARE stmt FROM @s;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
  END LOOP;

  CLOSE cur;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bck_user`
--

CREATE TABLE `bck_user` (
  `id` int(11) NOT NULL DEFAULT 0,
  `nama` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `level` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `uid` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bck_user`
--

INSERT INTO `bck_user` (`id`, `nama`, `username`, `password`, `level`, `uid`, `timestamp`) VALUES
(1, 'admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 2026, '2026-01-30 00:55:59'),
(2, 'petugas', 'petugas', 'afb91ef692fd08c445e8cb1bab2ccf9c', 'petugas', 2025, '2026-01-30 00:55:59');

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` int(20) NOT NULL,
  `kategori` varchar(200) NOT NULL,
  `desc1` varchar(200) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `kategori`, `desc1`, `timestamp`) VALUES
(1, 'Pembersih Lantai', 'Khusus Pembersih Lantai', '2026-02-01 13:26:14'),
(2, 'Pembersih Kaca', 'Khusus Pembersih Kaca', '2026-01-31 12:46:39'),
(3, 'Pembersih Plafon', 'Khusus plafon', '2026-02-03 05:58:11'),
(5, 'Pembersih Toilet', 'Khusus Toilet', '2026-02-03 07:25:38');

--
-- Triggers `kategori`
--
DELIMITER $$
CREATE TRIGGER `kategori_ai` AFTER INSERT ON `kategori` FOR EACH ROW BEGIN
INSERT INTO kategori_temp (id,kategori,desc1,timestamp)
VALUES (NEW.id,NEW.kategori,NEW.desc1,NEW.timestamp)
ON DUPLICATE KEY UPDATE kategori=NEW.kategori,desc1=NEW.desc1,timestamp=NEW.timestamp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `kategori_au` AFTER UPDATE ON `kategori` FOR EACH ROW BEGIN
INSERT INTO kategori_temp (id,kategori,desc1,timestamp)
VALUES (NEW.id,NEW.kategori,NEW.desc1,NEW.timestamp)
ON DUPLICATE KEY UPDATE kategori=NEW.kategori,desc1=NEW.desc1,timestamp=NEW.timestamp;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kategori_temp`
--

CREATE TABLE `kategori_temp` (
  `id` int(20) NOT NULL,
  `kategori` varchar(200) NOT NULL,
  `desc1` varchar(200) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori_temp`
--

INSERT INTO `kategori_temp` (`id`, `kategori`, `desc1`, `timestamp`) VALUES
(1, 'Pembersih Lantai', 'Khusus Pembersih Lantai', '2026-02-01 13:26:14'),
(2, 'Pembersih Kaca', 'Khusus Pembersih Kaca', '2026-01-31 12:46:39'),
(3, 'Pembersih Plafon', 'Khusus plafon', '2026-02-03 05:58:11'),
(5, 'Pembersih Toilet', 'Khusus Toilet', '2026-02-03 07:25:38'),
(6, 'Pembersih Taman', 'Untuk Memangkas Daun Taman', '2026-02-09 13:47:14');

-- --------------------------------------------------------

--
-- Table structure for table `pemberitahuan`
--

CREATE TABLE `pemberitahuan` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `konten` varchar(1000) NOT NULL,
  `status` enum('terima','tolak') NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `pemberitahuan`
--
DELIMITER $$
CREATE TRIGGER `pemberitahuan_ai` AFTER INSERT ON `pemberitahuan` FOR EACH ROW BEGIN
INSERT INTO pemberitahuan_temp (id,username,konten,status,timestamp)
VALUES (NEW.id,NEW.username,NEW.konten,NEW.status,NEW.timestamp)
ON DUPLICATE KEY UPDATE username=NEW.username,konten=NEW.konten,status=NEW.status,timestamp=NEW.timestamp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `pemberitahuan_au` AFTER UPDATE ON `pemberitahuan` FOR EACH ROW BEGIN
INSERT INTO pemberitahuan_temp (id,username,konten,status,timestamp)
VALUES (NEW.id,NEW.username,NEW.konten,NEW.status,NEW.timestamp)
ON DUPLICATE KEY UPDATE username=NEW.username,konten=NEW.konten,status=NEW.status,timestamp=NEW.timestamp;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `pemberitahuan_temp`
--

CREATE TABLE `pemberitahuan_temp` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `konten` varchar(1000) NOT NULL,
  `status` enum('terima','tolak') NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_barang`
--

CREATE TABLE `tbl_barang` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `gambar_barang` varchar(100) NOT NULL,
  `stok_barang` int(10) NOT NULL,
  `kategori_id` int(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_barang`
--

INSERT INTO `tbl_barang` (`id`, `nama_barang`, `gambar_barang`, `stok_barang`, `kategori_id`, `timestamp`) VALUES
(1, 'Sapu irenk', 'sapu_ijuk1.png', 3, 1, '2026-02-09 05:33:05'),
(2, 'Pel Kain', 'df47cbc6505d756f9575e1c957532aec1.jpeg', 3, 1, '2026-02-09 05:11:34'),
(3, 'Pel Putar', 'alat-pel-lantai-yang-bagus-1024x695.jpg', 3, 1, '2026-02-09 05:11:47'),
(4, 'Wiper', 'wiper-karet-alat-bersih-kaca-jendela-glass-mobil-wiper-cleaner-rubber.jpg', 8, 2, '2026-02-09 05:33:08'),
(5, 'Wiper teleskopik', 'images.png', 4, 2, '2026-02-09 06:04:59'),
(6, 'Cling - cairan pembersih kaca', 'mr_muscle.jpg', 5, 2, '2026-02-09 05:32:35'),
(7, 'Sekop sampah', 'sekop.jpg', 8, 1, '2026-02-09 06:05:07'),
(8, 'Sapu plafon', 'sapuplafon.jpg', 3, 3, '2026-02-09 05:32:54'),
(9, 'Sikat Toilet', 'sikat-toilet-sikat-kloset-toilet-pembersih-wc-unik-sikat-kamar-mandi-panjang-sfeg_600.jpeg', 5, 5, '2026-02-09 05:33:02');

--
-- Triggers `tbl_barang`
--
DELIMITER $$
CREATE TRIGGER `tbl_barang_ai` AFTER INSERT ON `tbl_barang` FOR EACH ROW BEGIN
INSERT INTO tbl_barang_temp (id,nama_barang,gambar_barang,stok_barang,kategori_id,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.gambar_barang,NEW.stok_barang,NEW.kategori_id,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,gambar_barang=NEW.gambar_barang,stok_barang=NEW.stok_barang,kategori_id=NEW.kategori_id,timestamp=NEW.timestamp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tbl_barang_au` AFTER UPDATE ON `tbl_barang` FOR EACH ROW BEGIN
INSERT INTO tbl_barang_temp (id,nama_barang,gambar_barang,stok_barang,kategori_id,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.gambar_barang,NEW.stok_barang,NEW.kategori_id,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,gambar_barang=NEW.gambar_barang,stok_barang=NEW.stok_barang,kategori_id=NEW.kategori_id,timestamp=NEW.timestamp;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_barang_temp`
--

CREATE TABLE `tbl_barang_temp` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(100) NOT NULL,
  `gambar_barang` varchar(100) NOT NULL,
  `stok_barang` int(10) NOT NULL,
  `kategori_id` int(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `tbl_barang_temp`
--

INSERT INTO `tbl_barang_temp` (`id`, `nama_barang`, `gambar_barang`, `stok_barang`, `kategori_id`, `timestamp`) VALUES
(1, 'Sapu irenk', 'sapu_ijuk1.png', 3, 1, '2026-02-09 05:33:05'),
(2, 'Pel Kain', 'df47cbc6505d756f9575e1c957532aec1.jpeg', 3, 1, '2026-02-09 05:11:34'),
(3, 'Pel Putar', 'alat-pel-lantai-yang-bagus-1024x695.jpg', 3, 1, '2026-02-09 05:11:47'),
(4, 'Wiper', 'wiper-karet-alat-bersih-kaca-jendela-glass-mobil-wiper-cleaner-rubber.jpg', 8, 2, '2026-02-09 05:33:08'),
(5, 'Wiper teleskopik', 'images.png', 4, 2, '2026-02-09 06:04:59'),
(6, 'Cling - cairan pembersih kaca', 'mr_muscle.jpg', 5, 2, '2026-02-09 05:32:35'),
(7, 'Sekop sampah', 'sekop.jpg', 8, 1, '2026-02-09 06:05:07'),
(8, 'Sapu plafon', 'sapuplafon.jpg', 3, 3, '2026-02-09 05:32:54'),
(9, 'Sikat Toilet', 'sikat-toilet-sikat-kloset-toilet-pembersih-wc-unik-sikat-kamar-mandi-panjang-sfeg_600.jpeg', 5, 5, '2026-02-09 05:33:02');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pinjam`
--

CREATE TABLE `tbl_pinjam` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(100) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(50) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `tbl_pinjam`
--
DELIMITER $$
CREATE TRIGGER `tbl_pinjam_ai` AFTER INSERT ON `tbl_pinjam` FOR EACH ROW BEGIN
INSERT INTO tbl_pinjam_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,timestamp=NEW.timestamp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tbl_pinjam_au` AFTER UPDATE ON `tbl_pinjam` FOR EACH ROW BEGIN
INSERT INTO tbl_pinjam_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,timestamp=NEW.timestamp;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_pinjam_temp`
--

CREATE TABLE `tbl_pinjam_temp` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(100) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(50) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request`
--

CREATE TABLE `tbl_request` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `tbl_request`
--
DELIMITER $$
CREATE TRIGGER `tbl_request_ai` AFTER INSERT ON `tbl_request` FOR EACH ROW BEGIN
INSERT INTO tbl_request_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,timestamp=NEW.timestamp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tbl_request_au` AFTER UPDATE ON `tbl_request` FOR EACH ROW BEGIN
INSERT INTO tbl_request_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,timestamp=NEW.timestamp;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_request_temp`
--

CREATE TABLE `tbl_request_temp` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_req_kembali`
--

CREATE TABLE `tbl_req_kembali` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kembali` date DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `tbl_req_kembali`
--
DELIMITER $$
CREATE TRIGGER `tbl_req_kembali_ai` AFTER INSERT ON `tbl_req_kembali` FOR EACH ROW BEGIN
INSERT INTO tbl_req_kembali_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,kembali=NEW.kembali,timestamp=NEW.timestamp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tbl_req_kembali_au` AFTER UPDATE ON `tbl_req_kembali` FOR EACH ROW BEGIN
INSERT INTO tbl_req_kembali_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,kembali=NEW.kembali,timestamp=NEW.timestamp;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_req_kembali_temp`
--

CREATE TABLE `tbl_req_kembali_temp` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kembali` date DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transaksi`
--

CREATE TABLE `tbl_transaksi` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(100) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kembali` date DEFAULT NULL,
  `tgl_appr` datetime DEFAULT NULL,
  `status_appr` varchar(50) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Triggers `tbl_transaksi`
--
DELIMITER $$
CREATE TRIGGER `tbl_transaksi_ai` AFTER INSERT ON `tbl_transaksi` FOR EACH ROW BEGIN
INSERT INTO tbl_transaksi_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,kembali,tgl_appr,status_appr,keterangan,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.kembali,NEW.tgl_appr,NEW.status_appr,NEW.keterangan,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,kembali=NEW.kembali,tgl_appr=NEW.tgl_appr,status_appr=NEW.status_appr,keterangan=NEW.keterangan,timestamp=NEW.timestamp;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tbl_transaksi_au` AFTER UPDATE ON `tbl_transaksi` FOR EACH ROW BEGIN
INSERT INTO tbl_transaksi_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,kembali,tgl_appr,status_appr,keterangan,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.kembali,NEW.tgl_appr,NEW.status_appr,NEW.keterangan,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,kembali=NEW.kembali,tgl_appr=NEW.tgl_appr,status_appr=NEW.status_appr,keterangan=NEW.keterangan,timestamp=NEW.timestamp;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `tbl_transaksi_temp`
--

CREATE TABLE `tbl_transaksi_temp` (
  `id` int(11) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(100) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kembali` date DEFAULT NULL,
  `tgl_appr` datetime DEFAULT NULL,
  `status_appr` varchar(50) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tracelog`
--

CREATE TABLE `tracelog` (
  `idtracelog` int(20) NOT NULL,
  `appname` varchar(200) NOT NULL,
  `log` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` varchar(30) NOT NULL,
  `uid` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama`, `username`, `password`, `level`, `uid`, `timestamp`) VALUES
(1, 'admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 2026, '2026-01-30 00:55:59'),
(2, 'petugas', 'petugas', 'afb91ef692fd08c445e8cb1bab2ccf9c', 'petugas', 2025, '2026-01-30 00:55:59');

--
-- Triggers `user`
--
DELIMITER $$
CREATE TRIGGER `user_ai` AFTER INSERT ON `user` FOR EACH ROW BEGIN
    INSERT INTO user_temp
        (nama, username, password, level, uid, timestamp)
    VALUES
        (NEW.nama, NEW.username, NEW.password, NEW.level, NEW.uid, NEW.timestamp);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `user_au` AFTER UPDATE ON `user` FOR EACH ROW BEGIN
    UPDATE user_temp
    SET
        nama      = NEW.nama,
        username  = NEW.username,
        password  = NEW.password,
        level     = NEW.level,
        uid       = NEW.uid,
        timestamp = NEW.timestamp
    WHERE uid = OLD.uid;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `user_log_ai` AFTER INSERT ON `user` FOR EACH ROW BEGIN
INSERT INTO user_log (nama,username,level,uid,action,ip_address,browser,appname,device,tanggal)
VALUES (NEW.nama,NEW.username,NEW.level,NEW.uid,NULL,NULL,NULL,NULL,NULL,NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `user_log_au` AFTER UPDATE ON `user` FOR EACH ROW BEGIN
UPDATE user_log SET nama=NEW.nama,username=NEW.username,level=NEW.level,uid=NEW.uid WHERE uid=OLD.uid;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `user_log`
--

CREATE TABLE `user_log` (
  `id` int(20) NOT NULL,
  `nama` varchar(220) NOT NULL,
  `username` varchar(200) NOT NULL,
  `level` varchar(100) NOT NULL,
  `uid` int(20) NOT NULL,
  `action` varchar(100) DEFAULT NULL,
  `ip_address` varchar(100) DEFAULT NULL,
  `browser` text DEFAULT NULL,
  `appname` varchar(255) DEFAULT NULL,
  `device` varchar(150) DEFAULT NULL,
  `tanggal` datetime DEFAULT current_timestamp(),
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_log`
--

INSERT INTO `user_log` (`id`, `nama`, `username`, `level`, `uid`, `action`, `ip_address`, `browser`, `appname`, `device`, `tanggal`, `timestamp`) VALUES
(1, 'admin', 'admin', 'admin', 2026, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:57:13', '2026-02-10 07:57:13'),
(2, 'petugas', 'petugas', 'petugas', 2025, NULL, NULL, NULL, NULL, NULL, '2026-02-10 14:57:13', '2026-02-10 07:57:13');

-- --------------------------------------------------------

--
-- Table structure for table `user_temp`
--

CREATE TABLE `user_temp` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` varchar(30) NOT NULL,
  `uid` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `user_temp`
--

INSERT INTO `user_temp` (`id`, `nama`, `username`, `password`, `level`, `uid`, `timestamp`) VALUES
(1, 'admin', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', 2026, '2026-01-30 00:55:59'),
(2, 'petugas', 'petugas', 'afb91ef692fd08c445e8cb1bab2ccf9c', 'petugas', 2025, '2026-01-30 00:55:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategori_temp`
--
ALTER TABLE `kategori_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemberitahuan`
--
ALTER TABLE `pemberitahuan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pemberitahuan_temp`
--
ALTER TABLE `pemberitahuan_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_barang_temp`
--
ALTER TABLE `tbl_barang_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_pinjam`
--
ALTER TABLE `tbl_pinjam`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_pinjam_temp`
--
ALTER TABLE `tbl_pinjam_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_request`
--
ALTER TABLE `tbl_request`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_request_temp`
--
ALTER TABLE `tbl_request_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_req_kembali`
--
ALTER TABLE `tbl_req_kembali`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_req_kembali_temp`
--
ALTER TABLE `tbl_req_kembali_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tbl_transaksi_temp`
--
ALTER TABLE `tbl_transaksi_temp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tracelog`
--
ALTER TABLE `tracelog`
  ADD PRIMARY KEY (`idtracelog`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_log`
--
ALTER TABLE `user_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_temp`
--
ALTER TABLE `user_temp`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `kategori_temp`
--
ALTER TABLE `kategori_temp`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pemberitahuan`
--
ALTER TABLE `pemberitahuan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pemberitahuan_temp`
--
ALTER TABLE `pemberitahuan_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_barang`
--
ALTER TABLE `tbl_barang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_barang_temp`
--
ALTER TABLE `tbl_barang_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tbl_pinjam`
--
ALTER TABLE `tbl_pinjam`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_pinjam_temp`
--
ALTER TABLE `tbl_pinjam_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_request`
--
ALTER TABLE `tbl_request`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_request_temp`
--
ALTER TABLE `tbl_request_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_req_kembali`
--
ALTER TABLE `tbl_req_kembali`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_req_kembali_temp`
--
ALTER TABLE `tbl_req_kembali_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_transaksi`
--
ALTER TABLE `tbl_transaksi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tbl_transaksi_temp`
--
ALTER TABLE `tbl_transaksi_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tracelog`
--
ALTER TABLE `tracelog`
  MODIFY `idtracelog` int(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_log`
--
ALTER TABLE `user_log`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_temp`
--
ALTER TABLE `user_temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
