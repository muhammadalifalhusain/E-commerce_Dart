import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blangkis App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(color: Colors.grey[900]),
        buttonTheme: ButtonThemeData(buttonColor: Colors.white),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
