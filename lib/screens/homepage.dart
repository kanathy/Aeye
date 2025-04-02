import 'package:aeye/assets/ScreenTimeChart.dart';
import 'package:flutter/material.dart';
import 'package:aeye/screens/Device.dart';
import 'package:aeye/screens/DrivingMode.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Function to open the drawer
  void _openDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  // State to track the selected feature card index (0 to 3 for the four cards)
  int _selectedFeatureIndex = -1;

  // State to track the selected navigation bar index (0 to 3 for the four buttons)
  int _selectedNavIndex = -1;

  @override
  void initState() {
    super.initState();
    // Reset the selected indices when the page is initialized or revisited
    _selectedFeatureIndex = -1;
    _selectedNavIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Add the Drawer
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 206, 190, 174),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // 🔹 Background Color
          Container(color: const Color.fromARGB(255, 214, 195, 178)),

          // 🔹 Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // 🔹 Profile and Name Row
                  Row(
                    children: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          color: const Color.fromARGB(255, 33, 32, 32),
                          iconSize: 28,
                        ),
                      ),
                      const Spacer(),
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFFFDF6EC),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
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

                  const Spacer(),
                  // 🔹 Feature Cards Section
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: Center(
                      child: Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        children: [
                          FeatureCard(
                            title: "Device",
                            icon: Icons.devices,
                            index: 0,
                            selectedIndex: _selectedFeatureIndex,
                            onTap: () {
                              setState(() {
                                _selectedFeatureIndex = 0;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DevicePage(),
                                ),
                              ).then((_) {
                                setState(() {
                                  _selectedFeatureIndex = -1;
                                });
                              });
                            },
                          ),
                          FeatureCard(
                            title: "Driving Mode",
                            icon: Icons.directions_car,
                            index: 1,
                            selectedIndex: _selectedFeatureIndex,
                            onTap: () {
                              setState(() {
                                _selectedFeatureIndex = 1;
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DrivingModePage(),
                                ),
                              ).then((_) {
                                setState(() {
                                  _selectedFeatureIndex = -1;
                                });
                              });
                            },
                          ),
                          FeatureCard(
                            title: "For Knee Users",
                            icon: Icons.accessibility_new,
                            index: 2,
                            selectedIndex: _selectedFeatureIndex,
                            onTap: () {
                              setState(() {
                                _selectedFeatureIndex = 2;
                              });
                              // No navigation for this card yet, add if needed
                            },
                          ),
                          FeatureCard(
                            title: "Eye Check",
                            icon: Icons.remove_red_eye,
                            index: 3,
                            selectedIndex: _selectedFeatureIndex,
                            onTap: () {
                              setState(() {
                                _selectedFeatureIndex = 3;
                              });
                              // No navigation for this card yet, add if needed
                            },
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

      // 🔹 Bottom Navigation Bar with dynamic icon color
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(255, 214, 195, 178),
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: _selectedNavIndex == 0 ? const Color(0xFFB99435) : Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    _selectedNavIndex = 0; // Set index for home button
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.flash_on,
                  color: _selectedNavIndex == 1 ? const Color(0xFFB99435) : Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    _selectedNavIndex = 1; // Set index for flash button
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: _selectedNavIndex == 2 ? const Color(0xFFB99435) : Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    _selectedNavIndex = 2; // Set index for person button
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.dashboard,
                  color: _selectedNavIndex == 3 ? const Color(0xFFB99435) : Colors.black,
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    _selectedNavIndex = 3; // Set index for dashboard button
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 FeatureCard Widget
class FeatureCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final double width;
  final double height;
  final double iconSize;
  final double fontSize;
  final VoidCallback? onTap;
  final int index;
  final int selectedIndex;

  const FeatureCard({
    super.key,
    required this.title,
    required this.icon,
    this.width = 100,
    this.height = 100,
    this.iconSize = 30,
    this.fontSize = 13,
    this.onTap,
    required this.index,
    required this.selectedIndex,
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
          color: const Color.fromARGB(255, 44, 43, 43),
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
            Icon(
              widget.icon,
              size: 40,
              color: widget.index == widget.selectedIndex ? const Color(0xFFB99435) : Colors.white,
            ),
            const SizedBox(height: 8),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
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