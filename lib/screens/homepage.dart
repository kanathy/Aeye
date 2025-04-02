import 'package:aeye/assets/ScreenTimeChart.dart';
import 'package:flutter/material.dart';

import 'package:aeye/screens/Device.dart';
import 'package:aeye/screens/DrivingMode.dart';
import 'package:fl_chart/fl_chart.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background Color
          Container(color: const Color.fromARGB(255, 206, 190, 174)),

          // 🔹 Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // 🔹 Profile and Name Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(
                        radius: 55, // 👈 Avatar radius
                        backgroundColor: Color(0xFFFDF6EC),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 52,
                        ), // 👈 Icon size
                      ),
                      Text(
                        "Prameh",
                        style: TextStyle(
                          fontSize: 22, // 👈 Font size for name
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  // Add this import at the top
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Screen Time",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("2h 45m", style: TextStyle(fontSize: 18)),
                  ),
                  const SizedBox(height: 16),
                  const ScreenTimeChart(),

                  const Spacer(), // Feature cards will still stay in the bottom half
                  // 🔹 Feature Cards Section
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: Center(
                      child: Wrap(
                        spacing: 25, // 👈 Horizontal space between cards
                        runSpacing: 25, // 👈 Vertical space between cards
                        children: [
                          FeatureCard(
                            title: "Device",
                            icon: Icons.devices,
                            width: 165,
                            height: 180,
                            iconSize: 34,
                            fontSize: 22,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DevicePage(),
                                ),
                              );
                            },
                          ),
                          FeatureCard(
                            title: "Driving Mode",
                            icon: Icons.directions_car,
                            width: 165,
                            height: 180,
                            iconSize: 34,
                            fontSize: 22,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DrivingModePage(),
                                ),
                              );
                            },
                          ),
                          FeatureCard(
                            title: "For Knee Users",
                            icon: Icons.accessibility_new,
                            width: 165,
                            height: 180,
                            iconSize: 34,
                            fontSize: 22,
                          ),
                          FeatureCard(
                            title: "Eye Check",
                            icon: Icons.remove_red_eye,
                            width: 165,
                            height: 180,
                            iconSize: 34,
                            fontSize: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 206, 190, 174),
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.black, size: 28),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.flash_on, color: Colors.black, size: 28),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.person, color: Colors.black, size: 28),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.dashboard,
                  color: Colors.black,
                  size: 28,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 FeatureCard Widget (Customizable Size & Style)
class FeatureCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final double width;
  final double height;
  final double iconSize;
  final double fontSize;
  final VoidCallback? onTap;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    this.width = 100,
    this.height = 100,
    this.iconSize = 30,
    this.fontSize = 13,
    this.onTap,
  });

  @override
  State<FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<FeatureCard> {
  bool _isTapped = false;

  void _handleTap() {
    setState(() {
      _isTapped = !_isTapped;
    });

    // Call the custom onTap function if provided
    if (widget.onTap != null) {
      widget.onTap!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: _isTapped ? const Color(0xFFBA965A) : Colors.black,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, size: widget.iconSize, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.fontSize,
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
