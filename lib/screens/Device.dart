import 'package:flutter/material.dart';

class DevicePage extends StatelessWidget {
  const DevicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Driving Feature"),
        backgroundColor: Color.fromARGB(
          255,
          206,
          190,
          174,
        ), // Elegant AppBar color
      ),
      backgroundColor: Color.fromARGB(
        255,
        206,
        190,
        174,
      ), // Matching background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            FeatureButton(
              icon: Icons.camera_alt,
              title: 'Start Camera',
              description: 'Capture view while driving.',
            ),
            FeatureButton(
              icon: Icons.history,
              title: 'History',
              description: 'Review previously recorded trips.',
            ),
            FeatureButton(
              icon: Icons.notifications,
              title: 'Notifications',
              description: 'Customize alerts for road safety.',
            ),
            FeatureButton(
              icon: Icons.map,
              title: 'Map',
              description: 'Find the location.',
            ),
            FeatureButton(
              icon: Icons.health_and_safety,
              title: 'Health Care',
              description: 'Health Tips Section.',
            ),
            FeatureButton(
              icon: Icons.contact_phone,
              title: 'Emergency Contact',
              description: 'Access or add emergency numbers.',
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const FeatureButton({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      elevation: 5.0, // Slight elevation for the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Slightly smaller radius
      ),
      color: const Color.fromARGB(
        255,
        135,
        132,
        132,
      ), // White card for contrast
      child: ListTile(
        contentPadding: const EdgeInsets.all(20.0),
        leading: CircleAvatar(
          backgroundColor: Color.fromARGB(
            255,
            86,
            86,
            85,
          ), // Elegant background for icons
          radius: 25.0, // Slightly smaller radius for the avatar
          child: Icon(
            icon,
            size: 25.0, // Reduced icon size for a cleaner look
            color: const Color.fromARGB(255, 12, 12, 12),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // Bold title for better visibility
            color: Colors.black, // Dark text for high contrast
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54, // Subtle text color
          ),
        ),
        onTap: () {
          // Add the action to be performed when the button is clicked
        },
      ),
    );
  }
}
