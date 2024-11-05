import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class NotaScreen extends StatelessWidget {
  final int totalHarga;
  final int jumlahBayar;
  final int kembalian;
  final String nama; // Menambahkan nama pengguna

  NotaScreen({
    required this.totalHarga,
    required this.jumlahBayar,
    required this.kembalian,
    required this.nama, // Menambahkan nama sebagai parameter
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nota Pembayaran', style: TextStyle(color: Color(0xFFF9B14F))),
        backgroundColor: Color(0xFF5B4F07), // Warna latar belakang AppBar
      ),
      body: Center( // Mengatur isi halaman agar berada di tengah
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Menempatkan teks di tengah secara vertikal
            crossAxisAlignment: CrossAxisAlignment.center, // Menempatkan teks di tengah secara horizontal
            children: [
              Text(
                'Terima kasih sudah belanja di toko kami!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFF9B14F)),
                textAlign: TextAlign.center, 
              ),
              Text(
                'Nama: $nama',
                style: TextStyle(fontSize: 18, color: Color(0xFFF9B14F)), 
                textAlign: TextAlign.center, 
              ),
              SizedBox(height: 10),
              Text(
                'Total Pembelian: Rp $totalHarga',
                style: TextStyle(fontSize: 18, color: Color(0xFFF9B14F)),
                textAlign: TextAlign.center, 
              ),
              SizedBox(height: 10),
              Text(
                'Jumlah Pembayaran: Rp $jumlahBayar',
                style: TextStyle(fontSize: 18, color: Color(0xFFF9B14F)), 
                textAlign: TextAlign.center, 
              ),
              SizedBox(height: 10),
              Text(
                'Kembalian: Rp $kembalian',
                style: TextStyle(fontSize: 18, color: Color(0xFFF9B14F)), 
                textAlign: TextAlign.center, 
              ),
              SizedBox(height: 20),
              
              SizedBox(height: 20),
              ElevatedButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
