import 'package:flutter/material.dart';

class EmergencyContactPage extends StatelessWidget {
  const EmergencyContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Emergency Contact")),
      body: const Center(child: Text("Add or manage emergency contacts.")),
    );
  }
}
