import 'package:flutter/material.dart';
import 'nota_screen.dart';

class PaymentScreen extends StatefulWidget {
  final int totalHarga;

  PaymentScreen({required this.totalHarga});

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
        kembalian = 0; // Set kembalian ke 0 jika uang kurang
      });
    } else {
      // Jika uang cukup
      setState(() {
        kembalian = jumlahBayar - widget.totalHarga;
      });

      // Pindah ke NotaScreen hanya jika uang cukup
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotaScreen(
            totalHarga: widget.totalHarga,
            jumlahBayar: jumlahBayar,
            nama: _namaController.text,
            kembalian: kembalian,
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
        color: Color(0xFF5B4F07), // Background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total: Rp ${widget.totalHarga}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFF9B14F)), // Text color
            ),
            SizedBox(height: 20),
            TextField(
              controller: _namaController, // Field untuk nama
              decoration: InputDecoration(
                labelText: 'Nama',
                labelStyle: TextStyle(color: Color(0xFFF9B14F)), // Label color
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9B14F)), // Underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9B14F)), // Focused underline color
                ),
              ),
              style: TextStyle(color: Colors.white), // Input text color
            ),
            SizedBox(height: 10),
            TextField(
              controller: _jumlahBayarController,
              decoration: InputDecoration(
                labelText: 'Jumlah Pembayaran',
                labelStyle: TextStyle(color: Color(0xFFF9B14F)), // Label color
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9B14F)), // Underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFF9B14F)), // Focused underline color
                ),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white), // Input text color
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D0D0D)), // Optional button color
              onPressed: () {
                _hitungKembalian();
                // Tidak ada navigasi di sini, karena sudah ditangani di dalam _hitungKembalian
              },
              child: Text('Bayar', style: TextStyle(color: Color(0xFFF9B14F))), // Button text color
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
