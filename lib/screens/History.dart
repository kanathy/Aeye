import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Driving History")),
      body: const Center(
        child: Text("Your previous driving sessions will appear here."),
      ),
    );
  }
}
