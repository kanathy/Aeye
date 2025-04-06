import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  late CameraController _controller;
  late List<CameraDescription> cameras;

  // Initialize the camera
  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    CameraDescription frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse:
          () =>
              cameras[0], // Default to back camera if no front camera is found
    );
    _controller = CameraController(frontCamera, ResolutionPreset.high);
    await _controller.initialize();
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Device"),
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
            DeviceOptionButton(
              icon: Icons.phone_android,
              title: 'Phone',
              description: 'Choose your phone for settings.',
              onTap: () {
                _showAngleOrDistanceDialog(context);
              },
            ),
            DeviceOptionButton(
              icon: Icons.laptop,
              title: 'Laptop',
              description: 'Choose your laptop for settings.',
              onTap: () {
                _showAngleOrDistanceDialog(context);
              },
            ),
            DeviceOptionButton(
              icon: Icons.tablet,
              title: 'Tablet',
              description: 'Choose your tablet for settings.',
              onTap: () {
                _showAngleOrDistanceDialog(context);
              },
            ),
            DeviceOptionButton(
              icon: Icons.desktop_windows,
              title: 'Desktop',
              description: 'Choose your desktop for settings.',
              onTap: () {
                _showAngleOrDistanceDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAngleOrDistanceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Option'),
          content: const Text('Please choose either Angle or Distance:'),
          actions: <Widget>[
            TextButton(
              child: const Text('Angle'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _showSelectionConfirmation(context, 'Angle');
              },
            ),
            TextButton(
              child: const Text('Distance'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _showSelectionConfirmation(context, 'Distance');
                _openCamera(); // Open the camera when "Distance" is selected
              },
            ),
          ],
        );
      },
    );
  }

  void _openCamera() {
    if (_controller.value.isInitialized) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPreviewPage(controller: _controller),
        ),
      );
    }
  }

  void _showSelectionConfirmation(BuildContext context, String selection) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You Selected'),
          content: Text('You selected: $selection'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the confirmation dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class CameraPreviewPage extends StatelessWidget {
  final CameraController controller;

  const CameraPreviewPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Camera Preview")),
      body: CameraPreview(controller),
    );
  }
}

class DeviceOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const DeviceOptionButton({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12.0),
      elevation: 5.0, // Slight elevation for the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Slightly smaller radius
      ),
      color: const Color.fromARGB(255, 135, 132, 132), // Card color
      child: ListTile(
        contentPadding: const EdgeInsets.all(20.0),
        leading: CircleAvatar(
          backgroundColor: Color.fromARGB(
            255,
            86,
            86,
            85,
          ), // Icon background color
          radius: 25.0, // Slightly smaller radius for the avatar
          child: Icon(
            icon,
            size: 25.0, // Icon size
            color: const Color.fromARGB(255, 12, 12, 12), // Icon color
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold, // Bold title
            color: Colors.black, // Dark text for contrast
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54, // Subtle text color
          ),
        ),
        onTap: onTap, // Trigger the onTap action
      ),
    );
  }
}
