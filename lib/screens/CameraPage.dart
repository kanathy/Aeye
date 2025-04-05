import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      cameras = await availableCameras();

      // 🔄 Get front camera
      final frontCamera = cameras!.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
      );

      controller = CameraController(frontCamera, ResolutionPreset.high);
      await controller!.initialize();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 🔳 Fullscreen Camera with flip
          Positioned.fill(
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(3.1416), // Mirror flip
              child: CameraPreview(controller!),
            ),
          ),

          // 🔘 Circle Camera Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // TODO: Add capture logic if needed
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
