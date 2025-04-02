import 'package:flutter/material.dart';

class DrivingModePage extends StatelessWidget {
  const DrivingModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Driving Mode Page")),
      body: const Center(
        child: Text(
          "Welcome to the Driving Mode Page!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
