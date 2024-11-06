import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class NotaScreen extends StatelessWidget {
  final int totalHarga;
  final int jumlahBayar;
  final int kembalian;
  final String nama; // Menambahkan nama pengguna
  final List<Map<String, dynamic>> keranjang; // Menambahkan keranjang produk

  NotaScreen({
    required this.totalHarga,
    required this.jumlahBayar,
    required this.kembalian,
    required this.nama, // Menambahkan nama sebagai parameter
    required this.keranjang, // Menambahkan keranjang sebagai parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nota Pembayaran', style: TextStyle(color: Color(0xFFF9B14F))),
        backgroundColor: Color(0xFF5B4F07), // Warna latar belakang AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Menempatkan teks di atas secara vertikal
          crossAxisAlignment: CrossAxisAlignment.start, // Menempatkan teks di kiri secara horizontal
          children: [
            // Menampilkan teks sambutan
            Align(
              alignment: Alignment.center, // Memastikan teks berada di tengah
              child: Text(
                'Terima kasih sudah belanja di toko kami!',
                style: TextStyle(
                  fontSize: 20,  // Ukuran font sedikit lebih besar
                  fontWeight: FontWeight.w700,  // Menambahkan ketebalan pada teks
                  color: Color(0xFFF9B14F),
                ),
                textAlign: TextAlign.center,  // Teks berada di tengah
              ),
            ),
            SizedBox(height: 40),  // Menambah jarak lebih banyak dengan teks berikutnya
            Text(
              'Nama: $nama',
              style: TextStyle(fontSize: 18, color: Color(0xFFF9B14F)),
            ),
            SizedBox(height: 10),
            Text(
              'Total Pembelian: Rp $totalHarga',
              style: TextStyle(fontSize: 18, color: Color(0xFFF9B14F)),
            ),
            SizedBox(height: 10),
            Text(
              'Jumlah Pembayaran: Rp $jumlahBayar',
              style: TextStyle(fontSize: 18, color: Color(0xFFF9B14F)),
            ),
            SizedBox(height: 10),
            Text(
              'Kembalian: Rp $kembalian',
              style: TextStyle(fontSize: 18, color: Color(0xFFF9B14F)),
            ),
            SizedBox(height: 20),

            // Menampilkan daftar produk yang dibeli
            Text(
              'Produk yang Dibeli:',
              style: TextStyle(fontSize: 16, color: Color(0xFFF9B14F)),
            ),
            SizedBox(height: 10),
            ...keranjang.map((item) {
              return ListTile(
                title: Text('${item['nama']} x${item['jumlah']}'),
                subtitle: Text('Rp ${item['harga']}'),
                textColor: Color(0xFFF9B14F),
              );
            }).toList(),

            SizedBox(height: 20),

            // Tombol kembali ke dashboard
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Kembali ke Dashboard', style: TextStyle(color: Color(0xFFF9B14F))),
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF5B4F07)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
