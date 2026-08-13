/*
SQLyog Community v13.1.7 (64 bit)
MySQL - 10.4.32-MariaDB : Database - db_pinjam_barang
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_pinjam_barang` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `db_pinjam_barang`;

/*Table structure for table `bck_user` */

DROP TABLE IF EXISTS `bck_user`;

CREATE TABLE `bck_user` (
  `id` int(11) NOT NULL DEFAULT 0,
  `nama` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `username` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `level` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `uid` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `bck_user` */

insert  into `bck_user`(`id`,`nama`,`username`,`password`,`level`,`uid`,`timestamp`) values 
(1,'admin','admin','21232f297a57a5a743894a0e4a801fc3','admin',2026,'2026-01-30 07:55:59'),
(2,'petugas','petugas','afb91ef692fd08c445e8cb1bab2ccf9c','petugas',2025,'2026-01-30 07:55:59');

/*Table structure for table `kategori` */

DROP TABLE IF EXISTS `kategori`;

CREATE TABLE `kategori` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `kategori` varchar(200) NOT NULL,
  `desc1` varchar(200) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `kategori` */

insert  into `kategori`(`id`,`kategori`,`desc1`,`timestamp`) values 
(1,'Pembersih Lantai','Khusus Pembersih Lantai','2026-02-01 20:26:14'),
(2,'Pembersih Kaca','Khusus Pembersih Kaca','2026-01-31 19:46:39'),
(3,'Pembersih Plafon','Khusus plafon','2026-02-03 12:58:11'),
(5,'Pembersih Toilet','Khusus Toilet','2026-02-03 14:25:38');

/*Table structure for table `kategori_temp` */

DROP TABLE IF EXISTS `kategori_temp`;

CREATE TABLE `kategori_temp` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `kategori` varchar(200) NOT NULL,
  `desc1` varchar(200) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `kategori_temp` */

insert  into `kategori_temp`(`id`,`kategori`,`desc1`,`timestamp`) values 
(1,'Pembersih Lantai','Khusus Pembersih Lantai','2026-02-01 20:26:14'),
(2,'Pembersih Kaca','Khusus Pembersih Kaca','2026-01-31 19:46:39'),
(3,'Pembersih Plafon','Khusus plafon','2026-02-03 12:58:11'),
(5,'Pembersih Toilet','Khusus Toilet','2026-02-03 14:25:38'),
(6,'Pembersih Taman','Untuk Memangkas Daun Taman','2026-02-09 20:47:14');

/*Table structure for table `pemberitahuan` */

DROP TABLE IF EXISTS `pemberitahuan`;

CREATE TABLE `pemberitahuan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `konten` varchar(1000) NOT NULL,
  `status` enum('terima','tolak') NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `pemberitahuan` */

/*Table structure for table `pemberitahuan_temp` */

DROP TABLE IF EXISTS `pemberitahuan_temp`;

CREATE TABLE `pemberitahuan_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `konten` varchar(1000) NOT NULL,
  `status` enum('terima','tolak') NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `pemberitahuan_temp` */

/*Table structure for table `tbl_barang` */

DROP TABLE IF EXISTS `tbl_barang`;

CREATE TABLE `tbl_barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(100) NOT NULL,
  `gambar_barang` varchar(100) NOT NULL,
  `stok_barang` int(10) NOT NULL,
  `kategori_id` int(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_barang` */

insert  into `tbl_barang`(`id`,`nama_barang`,`gambar_barang`,`stok_barang`,`kategori_id`,`timestamp`) values 
(1,'Sapu irenk','sapu_ijuk1.png',3,1,'2026-02-09 12:33:05'),
(2,'Pel Kain','df47cbc6505d756f9575e1c957532aec1.jpeg',3,1,'2026-02-09 12:11:34'),
(3,'Pel Putar','alat-pel-lantai-yang-bagus-1024x695.jpg',3,1,'2026-02-09 12:11:47'),
(4,'Wiper','wiper-karet-alat-bersih-kaca-jendela-glass-mobil-wiper-cleaner-rubber.jpg',8,2,'2026-02-09 12:33:08'),
(5,'Wiper teleskopik','images.png',4,2,'2026-02-09 13:04:59'),
(6,'Cling - cairan pembersih kaca','mr_muscle.jpg',5,2,'2026-02-09 12:32:35'),
(7,'Sekop sampah','sekop.jpg',8,1,'2026-02-09 13:05:07'),
(8,'Sapu plafon','sapuplafon.jpg',3,3,'2026-02-09 12:32:54'),
(9,'Sikat Toilet','sikat-toilet-sikat-kloset-toilet-pembersih-wc-unik-sikat-kamar-mandi-panjang-sfeg_600.jpeg',5,5,'2026-02-09 12:33:02');

/*Table structure for table `tbl_barang_temp` */

DROP TABLE IF EXISTS `tbl_barang_temp`;

CREATE TABLE `tbl_barang_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(100) NOT NULL,
  `gambar_barang` varchar(100) NOT NULL,
  `stok_barang` int(10) NOT NULL,
  `kategori_id` int(20) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_barang_temp` */

insert  into `tbl_barang_temp`(`id`,`nama_barang`,`gambar_barang`,`stok_barang`,`kategori_id`,`timestamp`) values 
(1,'Sapu irenk','sapu_ijuk1.png',3,1,'2026-02-09 12:33:05'),
(2,'Pel Kain','df47cbc6505d756f9575e1c957532aec1.jpeg',3,1,'2026-02-09 12:11:34'),
(3,'Pel Putar','alat-pel-lantai-yang-bagus-1024x695.jpg',3,1,'2026-02-09 12:11:47'),
(4,'Wiper','wiper-karet-alat-bersih-kaca-jendela-glass-mobil-wiper-cleaner-rubber.jpg',8,2,'2026-02-09 12:33:08'),
(5,'Wiper teleskopik','images.png',4,2,'2026-02-09 13:04:59'),
(6,'Cling - cairan pembersih kaca','mr_muscle.jpg',5,2,'2026-02-09 12:32:35'),
(7,'Sekop sampah','sekop.jpg',8,1,'2026-02-09 13:05:07'),
(8,'Sapu plafon','sapuplafon.jpg',3,3,'2026-02-09 12:32:54'),
(9,'Sikat Toilet','sikat-toilet-sikat-kloset-toilet-pembersih-wc-unik-sikat-kamar-mandi-panjang-sfeg_600.jpeg',5,5,'2026-02-09 12:33:02');

/*Table structure for table `tbl_pinjam` */

DROP TABLE IF EXISTS `tbl_pinjam`;

CREATE TABLE `tbl_pinjam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(100) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(50) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_pinjam` */

/*Table structure for table `tbl_pinjam_temp` */

DROP TABLE IF EXISTS `tbl_pinjam_temp`;

CREATE TABLE `tbl_pinjam_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(100) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(50) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_pinjam_temp` */

/*Table structure for table `tbl_req_kembali` */

DROP TABLE IF EXISTS `tbl_req_kembali`;

CREATE TABLE `tbl_req_kembali` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kembali` date DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_req_kembali` */

/*Table structure for table `tbl_req_kembali_temp` */

DROP TABLE IF EXISTS `tbl_req_kembali_temp`;

CREATE TABLE `tbl_req_kembali_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kembali` date DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_req_kembali_temp` */

/*Table structure for table `tbl_request` */

DROP TABLE IF EXISTS `tbl_request`;

CREATE TABLE `tbl_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_request` */

/*Table structure for table `tbl_request_temp` */

DROP TABLE IF EXISTS `tbl_request_temp`;

CREATE TABLE `tbl_request_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_barang` varchar(50) NOT NULL,
  `peminjam` varchar(50) NOT NULL,
  `level` varchar(50) NOT NULL,
  `jml_barang` int(11) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_request_temp` */

/*Table structure for table `tbl_transaksi` */

DROP TABLE IF EXISTS `tbl_transaksi`;

CREATE TABLE `tbl_transaksi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_transaksi` */

/*Table structure for table `tbl_transaksi_temp` */

DROP TABLE IF EXISTS `tbl_transaksi_temp`;

CREATE TABLE `tbl_transaksi_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
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
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `tbl_transaksi_temp` */

/*Table structure for table `tracelog` */

DROP TABLE IF EXISTS `tracelog`;

CREATE TABLE `tracelog` (
  `idtracelog` int(20) NOT NULL AUTO_INCREMENT,
  `appname` varchar(200) NOT NULL,
  `log` text NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`idtracelog`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `tracelog` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` varchar(30) NOT NULL,
  `uid` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`nama`,`username`,`password`,`level`,`uid`,`timestamp`) values 
(1,'admin','admin','21232f297a57a5a743894a0e4a801fc3','admin',2026,'2026-01-30 07:55:59'),
(2,'petugas','petugas','afb91ef692fd08c445e8cb1bab2ccf9c','petugas',2025,'2026-01-30 07:55:59');

/*Table structure for table `user_log` */

DROP TABLE IF EXISTS `user_log`;

CREATE TABLE `user_log` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
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
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_log` */

insert  into `user_log`(`id`,`nama`,`username`,`level`,`uid`,`action`,`ip_address`,`browser`,`appname`,`device`,`tanggal`,`timestamp`) values 
(1,'admin','admin','admin',2026,NULL,NULL,NULL,NULL,NULL,'2026-02-10 14:57:13','2026-02-10 14:57:13'),
(2,'petugas','petugas','petugas',2025,NULL,NULL,NULL,NULL,NULL,'2026-02-10 14:57:13','2026-02-10 14:57:13');

/*Table structure for table `user_temp` */

DROP TABLE IF EXISTS `user_temp`;

CREATE TABLE `user_temp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `level` varchar(30) NOT NULL,
  `uid` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

/*Data for the table `user_temp` */

insert  into `user_temp`(`id`,`nama`,`username`,`password`,`level`,`uid`,`timestamp`) values 
(1,'admin','admin','21232f297a57a5a743894a0e4a801fc3','admin',2026,'2026-01-30 07:55:59'),
(2,'petugas','petugas','afb91ef692fd08c445e8cb1bab2ccf9c','petugas',2025,'2026-01-30 07:55:59');

/* Trigger structure for table `kategori` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `kategori_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `kategori_ai` AFTER INSERT ON `kategori` FOR EACH ROW 
BEGIN
INSERT INTO kategori_temp (id,kategori,desc1,timestamp)
VALUES (NEW.id,NEW.kategori,NEW.desc1,NEW.timestamp)
ON DUPLICATE KEY UPDATE kategori=NEW.kategori,desc1=NEW.desc1,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `kategori` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `kategori_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `kategori_au` AFTER UPDATE ON `kategori` FOR EACH ROW 
BEGIN
INSERT INTO kategori_temp (id,kategori,desc1,timestamp)
VALUES (NEW.id,NEW.kategori,NEW.desc1,NEW.timestamp)
ON DUPLICATE KEY UPDATE kategori=NEW.kategori,desc1=NEW.desc1,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `pemberitahuan` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `pemberitahuan_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `pemberitahuan_ai` AFTER INSERT ON `pemberitahuan` FOR EACH ROW 
BEGIN
INSERT INTO pemberitahuan_temp (id,username,konten,status,timestamp)
VALUES (NEW.id,NEW.username,NEW.konten,NEW.status,NEW.timestamp)
ON DUPLICATE KEY UPDATE username=NEW.username,konten=NEW.konten,status=NEW.status,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `pemberitahuan` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `pemberitahuan_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `pemberitahuan_au` AFTER UPDATE ON `pemberitahuan` FOR EACH ROW 
BEGIN
INSERT INTO pemberitahuan_temp (id,username,konten,status,timestamp)
VALUES (NEW.id,NEW.username,NEW.konten,NEW.status,NEW.timestamp)
ON DUPLICATE KEY UPDATE username=NEW.username,konten=NEW.konten,status=NEW.status,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_barang` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_barang_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_barang_ai` AFTER INSERT ON `tbl_barang` FOR EACH ROW 
BEGIN
INSERT INTO tbl_barang_temp (id,nama_barang,gambar_barang,stok_barang,kategori_id,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.gambar_barang,NEW.stok_barang,NEW.kategori_id,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,gambar_barang=NEW.gambar_barang,stok_barang=NEW.stok_barang,kategori_id=NEW.kategori_id,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_barang` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_barang_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_barang_au` AFTER UPDATE ON `tbl_barang` FOR EACH ROW 
BEGIN
INSERT INTO tbl_barang_temp (id,nama_barang,gambar_barang,stok_barang,kategori_id,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.gambar_barang,NEW.stok_barang,NEW.kategori_id,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,gambar_barang=NEW.gambar_barang,stok_barang=NEW.stok_barang,kategori_id=NEW.kategori_id,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_pinjam` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_pinjam_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_pinjam_ai` AFTER INSERT ON `tbl_pinjam` FOR EACH ROW 
BEGIN
INSERT INTO tbl_pinjam_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_pinjam` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_pinjam_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_pinjam_au` AFTER UPDATE ON `tbl_pinjam` FOR EACH ROW 
BEGIN
INSERT INTO tbl_pinjam_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_req_kembali` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_req_kembali_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_req_kembali_ai` AFTER INSERT ON `tbl_req_kembali` FOR EACH ROW 
BEGIN
INSERT INTO tbl_req_kembali_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,kembali=NEW.kembali,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_req_kembali` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_req_kembali_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_req_kembali_au` AFTER UPDATE ON `tbl_req_kembali` FOR EACH ROW 
BEGIN
INSERT INTO tbl_req_kembali_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,kembali=NEW.kembali,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_request` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_request_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_request_ai` AFTER INSERT ON `tbl_request` FOR EACH ROW 
BEGIN
INSERT INTO tbl_request_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_request` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_request_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_request_au` AFTER UPDATE ON `tbl_request` FOR EACH ROW 
BEGIN
INSERT INTO tbl_request_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_transaksi` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_transaksi_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_transaksi_ai` AFTER INSERT ON `tbl_transaksi` FOR EACH ROW 
BEGIN
INSERT INTO tbl_transaksi_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,kembali,tgl_appr,status_appr,keterangan,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.kembali,NEW.tgl_appr,NEW.status_appr,NEW.keterangan,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,kembali=NEW.kembali,tgl_appr=NEW.tgl_appr,status_appr=NEW.status_appr,keterangan=NEW.keterangan,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `tbl_transaksi` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tbl_transaksi_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `tbl_transaksi_au` AFTER UPDATE ON `tbl_transaksi` FOR EACH ROW 
BEGIN
INSERT INTO tbl_transaksi_temp (id,nama_barang,peminjam,level,jml_barang,tgl_pinjam,tgl_kembali,kembali,tgl_appr,status_appr,keterangan,timestamp)
VALUES (NEW.id,NEW.nama_barang,NEW.peminjam,NEW.level,NEW.jml_barang,NEW.tgl_pinjam,NEW.tgl_kembali,NEW.kembali,NEW.tgl_appr,NEW.status_appr,NEW.keterangan,NEW.timestamp)
ON DUPLICATE KEY UPDATE nama_barang=NEW.nama_barang,peminjam=NEW.peminjam,level=NEW.level,jml_barang=NEW.jml_barang,tgl_pinjam=NEW.tgl_pinjam,tgl_kembali=NEW.tgl_kembali,kembali=NEW.kembali,tgl_appr=NEW.tgl_appr,status_appr=NEW.status_appr,keterangan=NEW.keterangan,timestamp=NEW.timestamp;
END */$$


DELIMITER ;

/* Trigger structure for table `user` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `user_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `user_ai` AFTER INSERT ON `user` FOR EACH ROW 
BEGIN
    INSERT INTO user_temp
        (nama, username, password, level, uid, timestamp)
    VALUES
        (NEW.nama, NEW.username, NEW.password, NEW.level, NEW.uid, NEW.timestamp);
END */$$


DELIMITER ;

/* Trigger structure for table `user` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `user_log_ai` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `user_log_ai` AFTER INSERT ON `user` FOR EACH ROW BEGIN
INSERT INTO user_log (nama,username,level,uid,action,ip_address,browser,appname,device,tanggal)
VALUES (NEW.nama,NEW.username,NEW.level,NEW.uid,NULL,NULL,NULL,NULL,NULL,NOW());
END */$$


DELIMITER ;

/* Trigger structure for table `user` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `user_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `user_au` AFTER UPDATE ON `user` FOR EACH ROW 
BEGIN
    UPDATE user_temp
    SET
        nama      = NEW.nama,
        username  = NEW.username,
        password  = NEW.password,
        level     = NEW.level,
        uid       = NEW.uid,
        timestamp = NEW.timestamp
    WHERE uid = OLD.uid;
END */$$


DELIMITER ;

/* Trigger structure for table `user` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `user_log_au` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `user_log_au` AFTER UPDATE ON `user` FOR EACH ROW BEGIN
UPDATE user_log SET nama=NEW.nama,username=NEW.username,level=NEW.level,uid=NEW.uid WHERE uid=OLD.uid;
END */$$


DELIMITER ;

/* Procedure structure for procedure `desc_all` */

/*!50003 DROP PROCEDURE IF EXISTS  `desc_all` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `desc_all`()
BEGIN
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
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
