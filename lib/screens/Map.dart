import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class OSMMapScreen extends StatefulWidget {
  @override
  _OSMMapScreenState createState() => _OSMMapScreenState();
}

class _OSMMapScreenState extends State<OSMMapScreen> {
  LatLng? currentLocation;
  late final MapController _mapController;
  double _currentZoom = 15.0;

  // 🗺️ Example saved locations (Jaffna and Colombo)
  final List<LatLng> savedLocations = [
    LatLng(9.6615, 80.0255), // Jaffna
    LatLng(6.9271, 79.8612), // Colombo
  ];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied)
        return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
    });

    _mapController.move(currentLocation!, _currentZoom);
  }

  void _zoomIn() {
    setState(() {
      _currentZoom += 1;
      _mapController.move(_mapController.center, _currentZoom);
    });
  }

  void _zoomOut() {
    setState(() {
      _currentZoom -= 1;
      _mapController.move(_mapController.center, _currentZoom);
    });
  }

  void _recenterMap() {
    if (currentLocation != null) {
      _mapController.move(currentLocation!, _currentZoom);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Live Location Map')),
      body:
          currentLocation == null
              ? Center(child: CircularProgressIndicator())
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
                        userAgentPackageName: 'com.example.aeye',
                      ),

                      // 📍 Multiple Custom Markers
                      MarkerLayer(
                        markers:
                            savedLocations.map((point) {
                              return Marker(
                                width: 60,
                                height: 60,
                                point: point,
                                child: Image.asset(
                                  'assets/pin.png',
                                ), // custom icon
                              );
                            }).toList(),
                      ),

                      // 📍 Current Location Marker
                      MarkerLayer(
                        markers: [
                          Marker(
                            width: 60,
                            height: 60,
                            point: currentLocation!,
                            child: Icon(
                              Icons.my_location,
                              color: Colors.blue,
                              size: 40,
                            ),
                          ),
                        ],
                      ),

                      // 🛣️ Route between two points
                      PolylineLayer(
                        polylines: [
                          Polyline(
                            points: [savedLocations[0], savedLocations[1]],
                            strokeWidth: 4.0,
                            color: Colors.purple,
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Zoom & Recenter Buttons
                  Positioned(
                    bottom: 30,
                    right: 10,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          heroTag: 'zoomIn',
                          mini: true,
                          onPressed: _zoomIn,
                          child: Icon(Icons.zoom_in),
                        ),
                        SizedBox(height: 10),
                        FloatingActionButton(
                          heroTag: 'zoomOut',
                          mini: true,
                          onPressed: _zoomOut,
                          child: Icon(Icons.zoom_out),
                        ),
                        SizedBox(height: 10),
                        FloatingActionButton(
                          heroTag: 'recenter',
                          mini: true,
                          onPressed: _recenterMap,
                          child: Icon(Icons.my_location),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
