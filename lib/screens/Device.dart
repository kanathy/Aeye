import 'package:flutter/material.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Device Page")),
      body: const Center(
        child: Text(
          "Welcome to the Device Page!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
