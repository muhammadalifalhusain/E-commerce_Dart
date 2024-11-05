import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Color(0xFF5B4F07), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo_blankis.png', height: 150),
            SizedBox(height: 20),
            Text(
              'Selamat Datang di Blangkis (Blangkon Pakis)',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFF9B14F), 
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
