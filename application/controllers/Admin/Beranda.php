<?php
defined('BASEPATH') or exit('No direct script access allowed');

class Beranda extends CI_Controller
{
	function __construct()
	{
		parent::__construct();
		$this->load->model('Owner_models/MO_transaksi');
		$this->load->model('M_transaksi');
		$this->load->model('M_faq');
		$this->load->helper(array('url'));
		if ($this->session->userdata('status') != "admin") {
			echo "<script>
                alert('Anda harus login terlebih dahulu');
                window.location.href = '" . base_url('Admin/Login') . "';
            </script>"; //Url tujuan
		}
	}

	public function index()
	{
		$id_admin = $this->session->userdata('iduseradmin');
		$this->db->select('SUM(saldo) as total');
		$this->db->where('no_reff', '111');
		$data['adm'] = $this->db->get('transaksi')->row();

		$data['total'] = $this->M_transaksi->totalPemasukan();
		$data['pemesanan'] = $this->db->query("SELECT * FROM pemesanan")->num_rows();
		$data['customer'] = $this->db->query("SELECT * FROM customer ")->num_rows();
		$data['admin'] = $this->db->query("SELECT * FROM admin")->num_rows();

		$this->db->select('SUM(harga_beli*stok_barang) as total');
		$data['pengeluaran'] = $this->db->get('barang')->row();

		$data['trans'] = $this->db->get('konfirmasi_pemesanan')->result();
		// $data['pesan'] = $this->M_transaksi->tampil_pesan2();


		$this->db->select('COUNT(id_konfirmasi) as total');
		$this->db->where('status_pembayaran', 'Belum Dikonfirmasi');
		$data['pemesanan'] = $this->db->get('konfirmasi_pemesanan')->row();

		$this->db->join('pemesanan', 'pemesanan.id_trans=konfirmasi_pemesanan.id_trans');
		$this->db->join('customer', 'pemesanan.id_cus=customer.id_cus');
		$this->db->group_by('konfirmasi_pemesanan.id_trans');
		$this->db->where('status_pembayaran', 'Belum Dikonfirmasi');
		$data['pesan2'] = $this->db->get('konfirmasi_pemesanan')->result();

		$this->load->view('element/Header', $data);
		$this->load->view('Admin/Beranda', $data);
		$this->load->view('element/Footer');
	}

	public function detailtransaksi()
	{
		$idpesan = $this->uri->segment(4);
		$data['pesan'] = $this->M_transaksi->tampil_pesan12($idpesan);

		$this->db->join('customer', 'customer.id_cus=konfirmasi_pemesanan.id_cus');
		$this->db->where('id_trans', $idpesan);
		$data['pesan2'] = $this->db->get('konfirmasi_pemesanan')->row();

		$this->db->join('barang', 'barang.id_barang=pemesanan.id_barang');
		$this->db->where('id_trans', $idpesan);
		$data['pesanan'] = $this->db->get('pemesanan')->result();

		$this->load->view('element/Header', $data);
		$this->load->view('Admin/v_detailtransaksi', $data);
		$this->load->view('element/Footer');
	}


	public function cari()
	{
		$kodepesan = $this->input->post('cari');
		$cek = $this->db->query("SELECT * FROM pesan JOIN pengiriman ON pesan.pengiriman_id_kirim=pengiriman.id_kirim JOIN kostumer ON pesan.id_kostumer_id=kostumer.id_kostumer WHERE id_pesan='$kodepesan' ORDER BY id_pesan DESC")->num_rows();
		if ($cek >= 1) {
			$data['total'] = $this->MO_transaksi->totalPemasukan();
			$data['order'] = $this->db->query("SELECT * FROM pesan")->num_rows();
			$data['user'] = $this->db->query("SELECT * FROM kostumer")->num_rows();
			$data['pegawai'] = $this->db->query("SELECT * FROM user")->num_rows();
			$data['pesan'] = $this->MO_transaksi->tampil_pesanid($kodepesan);
			$this->load->view('element/Header', $data);
			$this->load->view('Owner_view/VO_beranda', $data);
			$this->load->view('element/Footer');
		} else {
			echo "<script>
                alert('Kode pesan tidak ditemukan!');
                window.location.href = '" . base_url('Owner_controller/Beranda') . "';
            </script>"; //Url tujuan
		}
	}

	public function datapengiriman()
	{
		$idkirim = $this->uri->segment(4);
		$data['kirim'] = $this->MO_transaksi->tampil_pengiriman($idkirim);
		$this->load->view('Owner_view/VO_datapengiriman', $data);
	}
	public function datapesanan()
	{
		$idkirim = $this->uri->segment(4);
		$data['kirim'] = $this->MO_transaksi->tampil_pengiriman($idkirim);
		$this->load->view('Owner_view/VO_datapesanan', $data);
	}

	public function status()
	{
		$idpesan = $this->uri->segment(4);
		$status = 'Sudah Bayar';
		$statuspesan = 'Proses Kirim';
		$this->M_transaksi->updatestatus($idpesan, $status);
		$this->M_transaksi->updatestatus2($idpesan, $statuspesan);
		$this->M_transaksi->updatestok($idpesan);
		redirect('Admin/Beranda');
	}
	public function statusterkirim()
	{
		$idpesan = $this->uri->segment(4);
		$statuspesan = 'Terkirim';
		$this->M_transaksi->updatestatus2($idpesan, $statuspesan);
		redirect('Admin/Beranda');
	}
	public function detail_transaksi()
	{
		$data['status'] = $this->input->post("status");
		$idkirim = $this->uri->segment(4);
		$iduser = $this->input->post("iduser");
		$data['kodepos'] = $this->input->post("kode_pos");
		$data['idpesan'] = $this->input->post('idpesan');
		$idpesan2 = $this->input->post('idpesan');
		$data['inv'] = $this->MO_transaksi->invoice($idpesan2, $iduser);
		$data['inv2'] = $this->MO_transaksi->tampil_pengiriman($idkirim);
		$data['pengiriman'] = $this->input->post('harga_kirim');
		$data['total2'] = $this->input->post('total_pesan');
		$this->load->view('V_invoice', $data);
	}

	public function faq()
	{
		$data['hfaq'] = $this->M_faq->tampil_faq();
		$this->load->view('element/Header');
		$this->load->view('Owner_view/faq', $data);
		$this->load->view('element/Footer');
	}

	public function tambahstok()
	{
		$id_produk = $this->input->post('id_produk');
		$tambahstok = $this->input->post('tambahstok');

		$cek = $this->db->query("SELECT * FROM produk WHERE id_produk='$id_produk'")->num_rows();
		if ($cek >= 1) {
			$this->db->query("UPDATE `produk` SET `stok`=stok+'$tambahstok' WHERE id_produk='$id_produk'");
			echo "<script>
                alert('Stok berhasil ditambahkan');
                window.location.href = '" . base_url('Owner_controller/O_produk') . "';
            </script>";
		} else {
			echo "<script>
                alert('Id produk tidak ditemukan!');
                window.location.href = '" . base_url('Owner_controller/O_produk') . "';
            </script>";
		}
	}
}
