import 'package:flutter/material.dart';
import 'screens/RegisterPage.dart'; // Import your screen here
import 'screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(), // This is your custom screen
    );
  }
}
