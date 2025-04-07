// Add these imports at the top
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class OSMMapScreen extends StatefulWidget {
  const OSMMapScreen({super.key});

  @override
  State<OSMMapScreen> createState() => _OSMMapScreenState();
}

class _OSMMapScreenState extends State<OSMMapScreen> {
  LatLng? currentLocation;
  late final MapController _mapController;
  double _currentZoom = 15.0;
  LatLng? destination;
  List<LatLng> routePoints = [];
  Stream<Position>? positionStream;
  double heading = 0;
  final Distance distance = Distance();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> suggestions = [];

  String selectedVehicle = 'Car';

  final Map<String, double> vehicleSpeeds = {
    'Walk': 5,
    'Motorbike': 40,
    'Three Wheeler': 35,
    'Car': 50,
    'Van': 45,
    'Bus': 30,
  };

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      await Geolocator.openLocationSettings();
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever)
      return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentLocation = LatLng(position.latitude, position.longitude);
    _mapController.move(currentLocation!, _currentZoom);
    setState(() {});
  }

  void _startTracking() {
    positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 10,
      ),
    );

    positionStream!.listen((Position position) {
      final newLocation = LatLng(position.latitude, position.longitude);
      final dist = distance.as(LengthUnit.Meter, newLocation, destination!);

      if (dist < 20) {
        _stopTracking();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You have reached your destination!')),
        );
      }

      setState(() {
        currentLocation = newLocation;
        heading = position.heading;
      });
      _mapController.move(currentLocation!, _currentZoom);
    });
  }

  void _stopTracking() {
    positionStream = null;
    heading = 0;
    setState(() {});
  }

  Future<void> _getRoute(LatLng start, LatLng end) async {
    final url = Uri.parse(
      'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson',
    );

    final res = await http.get(url);
    if (res.statusCode == 200) {
      final coords =
          jsonDecode(res.body)['routes'][0]['geometry']['coordinates'] as List;
      routePoints = coords.map((c) => LatLng(c[1], c[0])).toList();
      setState(() {});
    }
  }

  Future<void> _getSuggestions(String query) async {
    if (query.length < 2) {
      setState(() => suggestions = []);
      return;
    }

    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5',
    );

    final response = await http.get(
      url,
      headers: {'User-Agent': 'FlutterMapApp/1.0 (your-email@example.com)'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        suggestions = List<Map<String, dynamic>>.from(data);
      });
    }
  }

  String _estimateTime() {
    if (currentLocation == null || destination == null) return "--";
    final km = distance.as(
      LengthUnit.Kilometer,
      currentLocation!,
      destination!,
    );
    final speed = vehicleSpeeds[selectedVehicle] ?? 40;
    final totalMin = (km / speed * 60).round();
    return "${totalMin ~/ 60}h ${totalMin % 60}m";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          currentLocation == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: currentLocation,
                      zoom: _currentZoom,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                        userAgentPackageName: 'com.example.app',
                      ),
                      if (routePoints.isNotEmpty)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: routePoints,
                              strokeWidth: 4.0,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 20,
                            height: 20,
                            point: currentLocation!,
                            child: Transform.rotate(
                              angle: heading * pi / 180,
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          if (destination != null)
                            Marker(
                              width: 60,
                              height: 60,
                              point: destination!,
                              child: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  // 🔍 Search Bar + Suggestions
                  Positioned(
                    top: 40,
                    left: 15,
                    right: 15,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(color: Colors.black26, blurRadius: 5),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: _getSuggestions,
                            decoration: const InputDecoration(
                              hintText: "Search location",
                              border: InputBorder.none,
                              icon: Icon(Icons.search),
                            ),
                          ),
                        ),
                        if (suggestions.isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: suggestions.length,
                              itemBuilder: (context, index) {
                                final place = suggestions[index];
                                return ListTile(
                                  title: Text(place['display_name']),
                                  onTap: () async {
                                    final lat = double.parse(place['lat']);
                                    final lon = double.parse(place['lon']);
                                    destination = LatLng(lat, lon);
                                    _searchController.text =
                                        place['display_name'];
                                    suggestions.clear();
                                    await _getRoute(
                                      currentLocation!,
                                      destination!,
                                    );
                                    _mapController.move(destination!, 14);
                                    setState(() {});
                                  },
                                );
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  // 🧭 Controls and Bottom Sheet
                  if (destination != null)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.directions, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  "Directions",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton.icon(
                                  onPressed: _startTracking,
                                  icon: const Icon(Icons.play_arrow),
                                  label: const Text("Start"),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _stopTracking,
                                  icon: const Icon(Icons.stop),
                                  label: const Text("Stop"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text('Estimated time: ${_estimateTime()}'),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
    );
  }
}
