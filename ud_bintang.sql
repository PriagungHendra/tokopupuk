-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 06, 2020 at 12:56 PM
-- Server version: 10.1.31-MariaDB
-- PHP Version: 7.2.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ud_bintang`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `no_reff` varchar(30) NOT NULL,
  `nama_reff` varchar(30) NOT NULL,
  `keterangan_reff` text NOT NULL,
  `id_admin` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`no_reff`, `nama_reff`, `keterangan_reff`, `id_admin`) VALUES
('111', 'Kas', 'Kas toko pupuk', '1'),
('113', 'Persediaan', 'Persedian toko pupuk', '1'),
('122', 'Peralatan', 'Perlatan toko pupuk', '1'),
('300', 'Modal', 'Modal', '1'),
('312', 'Prive', 'Pengambilan Pribadi', '1'),
('411', 'Penjualan', 'Penjualan', '1'),
('511', 'Beban Gaji', 'Beban Gaji', '1');

-- --------------------------------------------------------

--
-- Table structure for table `barang`
--

CREATE TABLE `barang` (
  `id_barang` varchar(10) NOT NULL,
  `nama_barang` varchar(30) NOT NULL,
  `harga_barang` int(10) NOT NULL,
  `harga_beli` int(10) NOT NULL,
  `tgl_masuk_barang` varchar(30) NOT NULL,
  `stok_barang` int(5) NOT NULL,
  `gambar` varchar(200) NOT NULL,
  `keterangan` text NOT NULL,
  `id_kategori_barang` varchar(10) NOT NULL,
  `id_suplier` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `id_cus` int(11) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `alamat` text NOT NULL,
  `kode_pos` varchar(6) NOT NULL,
  `no_hp` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id_cus`, `nama`, `alamat`, `kode_pos`, `no_hp`, `email`, `username`, `password`) VALUES
(10, 'Fahrizal', 'Banyuwangi', '68463', '08782728929', 'jiwanrizal5@gmail.com', 'jiwan', '12345'),
(11, 'Ega Kustian', 'Jember', '68463', '1234321', 'jiwanrizal5@gmail.com', 'Ega', '12345');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_saldo`
--

CREATE TABLE `jenis_saldo` (
  `id_jenis` int(11) NOT NULL,
  `nama_saldo` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `jenis_saldo`
--

INSERT INTO `jenis_saldo` (`id_jenis`, `nama_saldo`) VALUES
(1, 'Debit'),
(2, 'Kredit');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_barang`
--

CREATE TABLE `kategori_barang` (
  `id_kategori` varchar(10) NOT NULL,
  `nama_kategori_brg` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `kategori_barang`
--

INSERT INTO `kategori_barang` (`id_kategori`, `nama_kategori_brg`) VALUES
('KG0001', 'Pupuk Urea'),
('KG0002', 'Pupuk Kompos');

-- --------------------------------------------------------

--
-- Table structure for table `konfirmasi_pemesanan`
--

CREATE TABLE `konfirmasi_pemesanan` (
  `id_konfirmasi` int(11) NOT NULL,
  `id_cus` varchar(5) NOT NULL,
  `tanggal_checkout` varchar(30) NOT NULL,
  `total_bayar` int(10) NOT NULL,
  `status_pembayaran` varchar(30) NOT NULL,
  `bukti_transfer` varchar(200) NOT NULL,
  `alamat_pengiriman` text NOT NULL,
  `bank` varchar(20) NOT NULL,
  `jurnal` varchar(10) NOT NULL,
  `id_trans` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `konfirmasi_pemesanan`
--

INSERT INTO `konfirmasi_pemesanan` (`id_konfirmasi`, `id_cus`, `tanggal_checkout`, `total_bayar`, `status_pembayaran`, `bukti_transfer`, `alamat_pengiriman`, `bank`, `jurnal`, `id_trans`) VALUES
(27, '10', 'Kamis, 6 Agustus 2020', 90000, 'Sudah Bayar', '0918194620X310.jpg', 'Jember', 'BRI', 'Ya', 'f7649e5e98d99e0356613e32b283a4');

-- --------------------------------------------------------

--
-- Table structure for table `pembelian_barang`
--

CREATE TABLE `pembelian_barang` (
  `id_pembelian` int(11) NOT NULL,
  `id_barang` varchar(10) NOT NULL,
  `tanggal_pembelian` varchar(30) NOT NULL,
  `jumlah_pembayaran` int(10) NOT NULL,
  `id_suplier` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `pemesanan`
--

CREATE TABLE `pemesanan` (
  `id_pemesanan` int(11) NOT NULL,
  `id_cus` varchar(5) NOT NULL,
  `id_barang` varchar(10) NOT NULL,
  `jumlah_barang` int(10) NOT NULL,
  `sub_total` int(10) NOT NULL,
  `tgl_pemesanan` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL,
  `id_trans` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pemesanan`
--

INSERT INTO `pemesanan` (`id_pemesanan`, `id_cus`, `id_barang`, `jumlah_barang`, `sub_total`, `tgl_pemesanan`, `status`, `id_trans`) VALUES
(70, '10', 'AP0006', 2, 50000, 'Kamis, 6 Agustus 2020', 'Proses Kirim', 'f7649e5e98d99e0356613e32b283a4'),
(71, '10', 'AP0004', 2, 40000, 'Kamis, 6 Agustus 2020', 'Proses Kirim', 'f7649e5e98d99e0356613e32b283a4');

-- --------------------------------------------------------

--
-- Table structure for table `suplier`
--

CREATE TABLE `suplier` (
  `id_suplier` int(11) NOT NULL,
  `nama_suplier` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `suplier`
--

INSERT INTO `suplier` (`id_suplier`, `nama_suplier`) VALUES
(2, 'CV.Merdeka'),
(3, 'PT Pupuk');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL,
  `id_admin` varchar(5) NOT NULL,
  `no_reff` varchar(30) NOT NULL,
  `tgl_input` varchar(30) NOT NULL,
  `tgl_transaksi` varchar(50) NOT NULL,
  `jenis_saldo` int(11) NOT NULL,
  `saldo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `id_admin`, `no_reff`, `tgl_input`, `tgl_transaksi`, `jenis_saldo`, `saldo`) VALUES
(29, '', '111', '06-08-2020 12:05:30', '2020-08-06', 1, 4800000),
(30, '', '113', '06-08-2020 12:06:55', '2020-08-06', 1, 5000000),
(31, '', '122', '06-08-2020 12:07:37', '2020-08-06', 1, 1250000),
(32, '', '411', '06-08-2020 12:08:06', '2020-08-06', 2, 5800000),
(33, '', '511', '06-08-2020 12:08:46', '2020-08-06', 1, 500000),
(34, '', '300', '06-08-2020 12:09:48', '2020-08-06', 2, 5000000),
(35, '', '312', '06-08-2020 12:13:22', '2020-08-06', 1, 1000000);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`no_reff`);

--
-- Indexes for table `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`id_barang`),
  ADD KEY `fk1` (`id_kategori_barang`),
  ADD KEY `fk2` (`id_suplier`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id_cus`);

--
-- Indexes for table `jenis_saldo`
--
ALTER TABLE `jenis_saldo`
  ADD PRIMARY KEY (`id_jenis`);

--
-- Indexes for table `kategori_barang`
--
ALTER TABLE `kategori_barang`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `konfirmasi_pemesanan`
--
ALTER TABLE `konfirmasi_pemesanan`
  ADD PRIMARY KEY (`id_konfirmasi`),
  ADD KEY `fk1` (`id_cus`) USING BTREE;

--
-- Indexes for table `pembelian_barang`
--
ALTER TABLE `pembelian_barang`
  ADD PRIMARY KEY (`id_pembelian`);

--
-- Indexes for table `pemesanan`
--
ALTER TABLE `pemesanan`
  ADD PRIMARY KEY (`id_pemesanan`);

--
-- Indexes for table `suplier`
--
ALTER TABLE `suplier`
  ADD PRIMARY KEY (`id_suplier`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id_transaksi`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `id_cus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `jenis_saldo`
--
ALTER TABLE `jenis_saldo`
  MODIFY `id_jenis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `konfirmasi_pemesanan`
--
ALTER TABLE `konfirmasi_pemesanan`
  MODIFY `id_konfirmasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `pembelian_barang`
--
ALTER TABLE `pembelian_barang`
  MODIFY `id_pembelian` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pemesanan`
--
ALTER TABLE `pemesanan`
  MODIFY `id_pemesanan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `suplier`
--
ALTER TABLE `suplier`
  MODIFY `id_suplier` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
