import 'package:flutter/material.dart';

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

                  const Spacer(),

                  // 🔹 Feature Cards Section
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.42,
                    child: Center(
                      child: Wrap(
                        spacing: 25, // 👈 Horizontal space between cards
                        runSpacing: 25, // 👈 Vertical space between cards
                        children: const [
                          FeatureCard(
                            title: "Device",
                            icon: Icons.devices,
                            width: 165,
                            height: 180,
                            iconSize: 34,
                            fontSize: 13,
                          ),
                          FeatureCard(
                            title: "Driving Mode",
                            icon: Icons.directions_car,
                            width: 165,
                            height: 180,
                            iconSize: 34,
                            fontSize: 13,
                          ),
                          FeatureCard(
                            title: "For Knee Users",
                            icon: Icons.accessibility_new,
                            width: 165,
                            height: 180,
                            iconSize: 34,
                            fontSize: 13,
                          ),
                          FeatureCard(
                            title: "Eye Check",
                            icon: Icons.remove_red_eye,
                            width: 165,
                            height: 180,
                            iconSize: 34,
                            fontSize: 13,
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

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    this.width = 100,
    this.height = 100,
    this.iconSize = 30,
    this.fontSize = 13,
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
