import 'package:flutter/material.dart';
import 'package:aeye/screens/cameraPage.dart'; // update path based on your project

class DrivingModePage extends StatelessWidget {
  const DrivingModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 214, 195, 178),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 214, 195, 178),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Driving Mode",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            FeatureOption(
              title: "Start Camera",
              icon: Icons.videocam,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraPage()),
                );
              },
            ),

            const SizedBox(height: 30),
            FeatureOption(
              title: "History",
              icon: Icons.history,
              onTap: () {
                // TODO: Navigate to history or show history
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("History tapped")));
              },
            ),

            const SizedBox(height: 30),
            FeatureOption(
              title: "Notification",
              icon: Icons.notification_add,
              onTap: () {
                // TODO: Navigate to history or show history
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Notification tapped")),
                );
              },
            ),

            const SizedBox(height: 30),
            FeatureOption(
              title: "Emergency Contact",
              icon: Icons.contact_emergency,
              onTap: () {
                // TODO: Navigate to history or show history
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Emergency Contacht tapped")),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Reusable Widget for Driving Mode Options
class FeatureOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const FeatureOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
