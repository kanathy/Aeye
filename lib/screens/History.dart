// File: history_page.dart
import 'package:flutter/material.dart';
import 'package:aeye/assets/BlinkRateIndicator.dart'; // Import the custom widget

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double eyeBlinkRate = 0.92; // example data

    return Scaffold(
      appBar: AppBar(
        title: const Text("Eye Blink History"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            BlinkRateIndicator(blinkRate: eyeBlinkRate),

            const SizedBox(height: 20),
            const Divider(),

            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Today’s Summary",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.timelapse),
              title: Text("Total Trips"),
              trailing: Text("10"),
            ),
            const ListTile(
              leading: Icon(Icons.visibility),
              title: Text("Avg Blinks/Minute"),
              trailing: Text("15"),
            ),
            const ListTile(
              leading: Icon(Icons.timer),
              title: Text("Driving Time"),
              trailing: Text("1h 30m"),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // navigate to graph page or implement functionality
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text("View Graph"),
            ),
          ],
        ),
      ),
    );
  }
}
