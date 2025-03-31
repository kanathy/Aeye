import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Color.fromARGB(255, 158, 158, 158)),
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE6D6F3), // Light lavender/purple
              Color(0xFFB0C7F1), // Soft bluish purple
              Color(0xFF6172F3), // Deeper blue
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Welcome to Eye Health App",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Replace with your actual content
      ),
    );
  }
}
