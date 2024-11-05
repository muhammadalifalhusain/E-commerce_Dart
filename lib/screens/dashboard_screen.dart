import 'package:blangkis_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'payment_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> produkList = [
    {
      "nama": "Blangkon Motif Kumitir",
      "harga": 50000,
      "keterangan": "Blangkon Motif Kumitir adalah aksesori tradisional yang terbuat dari bahan berkualitas tinggi dengan desain motif kumitir yang khas. Cocok untuk berbagai acara formal dan santai, blangkon ini akan memberikan sentuhan elegan pada penampilan Anda.",
      "image": "assets/produk1.jpg",
    },
    {
      "nama": "Blangkon Mataram",
      "harga": 99000,
      "keterangan": "Blangkon Mataram hadir dengan iket modang prodo yang klasik. Terbuat dari bahan yang nyaman dan tahan lama, blangkon ini akan menjadi pilihan tepat untuk melengkapi pakaian adat Anda.",
      "image": "assets/produk2.jpg",
    },
    {
      "nama": "Blangkon Motif Kemiter",
      "harga": 100000,
      "keterangan": "Blangkon Motif Kemiter adalah pilihan yang ideal bagi Anda yang menginginkan gaya yang unik dan berbeda. Dengan kombinasi warna yang menarik, blangkon ini cocok untuk acara-acara spesial.",
      "image": "assets/produk3.jpg",
    },
    {
      "nama": "Blangkon Mataram Premium",
      "harga": 256000,
      "keterangan": "Blangkon Mataram Premium adalah produk terbaik kami yang terbuat dari bahan premium dengan motif poleng kawitran. Blangkon ini dirancang untuk memberikan kenyamanan dan keanggunan dalam setiap kesempatan.",
      "image": "assets/produk4.jpg",
    },
  ];

  int totalHarga = 0;

  void _tambahKeKeranjang(int harga) {
    setState(() {
      totalHarga += harga;
    });
  }

  void _showKeterangan(BuildContext context, String keterangan, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          title: Text('Keterangan Produk', style: TextStyle(color: Color(0xFFF9B14F))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image, width: 100, height: 100), // memanggil gambar produk
              SizedBox(height: 10),
              Text(keterangan, style: TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Tutup', style: TextStyle(color: Color(0xFFF9B14F))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //popup menu sesuai ketentuan pak ajib

  void handleMenuOption(String value) {
    switch (value) {
      case 'Call Center':
        _bukaTelepon(context);
        break;
      case 'SMS Center':
        _bukaSms(context);
        break;
      case 'Lokasi/Maps':
        _openGoogleMaps(); 
        break;
      case 'Update User & Password':
        _updateUserAndPassword();
        break;
      case 'Logout':
        logout(context);
        break;
      default:
        break;
    }
  }

  void _updateUserAndPassword() async {
  // Controllers untuk input username dan password baru
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Global key untuk form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Mendapatkan data dari SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  String? currentUsername = prefs.getString('username');
  String? currentPassword = prefs.getString('password');

  // menampil data sharedpreference lama kedalam field
  _usernameController.text = currentUsername ?? '';
  _passwordController.text = currentPassword ?? '';

  // State nggo ngontrol passwoed
  bool _isPasswordVisible = true;

  // dialog update user dan pass
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Update User & Password'),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(labelText: 'Username Baru'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap isi data'; // Menampilkan notifkasi jika inputan = 0
                      }
                      return null; 
                    },
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password Baru',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !_isPasswordVisible, // hide atau show pass
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harap isi data'; 
                      }
                      return null; // Tidak ada kesalahan
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Simpan'),
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Menyimpan username dan password baru
                    await prefs.setString('username', _usernameController.text);
                    await prefs.setString('password', _passwordController.text);
                    Navigator.of(context).pop(); 
                    // Redirect ke halaman login
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  }
                },
              ),
              TextButton(
                child: Text('Batal'),
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
              ),
            ],
          );
        },
      );
    },
  );
}

  void _openGoogleMaps() async {
    const String googleMapsUrl = 'https://maps.app.goo.gl/YCXT4wbUkkGMBLqQ8'; // URL Google Maps
    final Uri url = Uri.parse(googleMapsUrl); // Membuat objek Uri dari URL

    //  canLaunchUrl untuk memeriksa apakah URL bisa diakses
    if (await canLaunch(url.toString())) {
      await launch(url.toString()); // Menggunakan launch untuk membuka URL
    } else {
      throw 'Could not launch $googleMapsUrl';
    }
  }

  void _bukaSms(BuildContext context) async {
  final String phoneNumber = '+62882006822481';
  var status = await Permission.sms.status;

  if (status.isGranted) {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak dapat membuka aplikasi SMS')),
      );
    }
  } else {
    // Jika izin belum diberikan, minta izin
    await Permission.sms.request();
    if (await Permission.sms.isGranted) {
      final Uri smsUri = Uri(
        scheme: 'sms',
        path: phoneNumber,
      );
      if (await canLaunchUrl(smsUri)) {
        await launchUrl(smsUri);
      }
    }
  }
}

  void _bukaTelepon(BuildContext context) async {
  final String phoneNumber = '+62882006826730';
  var status = await Permission.phone.status;

  if (status.isGranted) {
    final Uri telUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak dapat membuka aplikasi telepon')),
      );
    }
  } else {
    // Minta izin jika belum diberikan
    var result = await Permission.phone.request();

    if (result.isGranted) {
      final Uri telUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunchUrl(telUri)) {
        await launchUrl(telUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tidak dapat membuka aplikasi telepon')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Izin telepon ditolak')),
      );
    }
  }
}

  void logout(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => LoginScreen()),
    (Route<dynamic> route) => false,
  );
}

  void _proceedToPayment(BuildContext context) {
    if (totalHarga > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentScreen(totalHarga: totalHarga),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tidak ada pesanan di keranjang!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Produk', style: TextStyle(color: Color(0xFFF9B14F))),
        backgroundColor: Color(0xFF5B4F07),
        actions: [
          PopupMenuButton<String>(
            onSelected: handleMenuOption,
            itemBuilder: (BuildContext context) {
              return {
                'Call Center',
                'SMS Center',
                'Lokasi/Maps',
                'Update User & Password',
                'Logout'
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF5B4F07),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
          ),
          itemCount: produkList.length,
          itemBuilder: (context, index) {
            final produk = produkList[index];
            return Card(
              color: Color(0xFF0D0D0D),
              child: InkWell(
                onTap: () => _tambahKeKeranjang(produk["harga"]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () => _tambahKeKeranjang(produk["harga"]),
                      child: Image.asset(produk["image"], width: 100, height: 100),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () => _showKeterangan(context, produk["keterangan"], produk["image"]),
                      child: Text(
                        produk["nama"],
                        style: TextStyle(color: Color(0xFFF9B14F), fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text("Rp ${produk["harga"]}", style: TextStyle(color: Colors.white, fontSize: 16)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0D0D0D)),
          onPressed: () => _proceedToPayment(context),
          child: Text(
            "Lanjut ke Pembayaran - Total: Rp $totalHarga",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
