import 'package:flutter/material.dart';
import 'nota_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int totalHarga;
  final List<Map<String, dynamic>> keranjang; // Tambahkan parameter keranjang

  PaymentScreen({required this.totalHarga, required this.keranjang}); // Terima parameter keranjang

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _jumlahBayarController = TextEditingController();
  final _namaController = TextEditingController(); 
  int kembalian = 0;

  void _hitungKembalian() {
    int jumlahBayar = int.tryParse(_jumlahBayarController.text) ?? 0;

    if (jumlahBayar < widget.totalHarga) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maaf, uang Anda kurang!',
            style: TextStyle(color: Color(0xFFF9B14F)),
          ),
          backgroundColor: Color.fromARGB(255, 54, 54, 54),
        ),
      );
      setState(() {
        kembalian = 0;
      });
    } else {
      setState(() {
        kembalian = jumlahBayar - widget.totalHarga;
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotaScreen(
            totalHarga: widget.totalHarga,
            jumlahBayar: jumlahBayar,
            nama: _namaController.text,
            kembalian: kembalian,
            keranjang: widget.keranjang,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran', style: TextStyle(color: Color(0xFFF9B14F))),
        backgroundColor: Color(0xFF5B4F07),
      ),
      body: Container(
        color: Color(0xFF5B4F07),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Menampilkan daftar produk yang dibeli di atas
            Text(
              'Produk yang Dibeli:',
              style: TextStyle(color: Color(0xFFF9B14F), fontSize: 16),
            ),
            SizedBox(height: 10),
            ...widget.keranjang.map((item) {
              return ListTile(
                title: Text('${item['nama']} x${item['jumlah']}'),
                subtitle: Text('Rp ${item['harga']}'),
                textColor: Color(0xFFF9B14F),
              );
            }).toList(),
            SizedBox(height: 20),

            // Menampilkan total harga produk
            Text(
              'Total: Rp ${widget.totalHarga}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFF9B14F)),
            ),
            SizedBox(height: 20),

            // Nama pengguna
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                labelText: 'Nama',
                labelStyle: TextStyle(color: Color(0xFFF9B14F)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9B14F)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9B14F)),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),

            // Jumlah bayar
            TextField(
              controller: _jumlahBayarController,
              decoration: InputDecoration(
                labelText: 'Jumlah Pembayaran',
                labelStyle: TextStyle(color: Color(0xFFF9B14F)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9B14F)),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9B14F)),
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Tombol bayar
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D0D0D)),
              onPressed: _hitungKembalian,
              child: Text('Bayar', style: TextStyle(color: Color(0xFFF9B14F))),
            ),
          ],
        ),
      ),
    );
  }
}
