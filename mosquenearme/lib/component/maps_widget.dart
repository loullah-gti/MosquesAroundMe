import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({super.key});

  @override
  State<MapsWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MapsWidget> {
  static const CameraPosition _center = CameraPosition(
    target: LatLng(18.118353045164966, -15.97564971763264),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(initialCameraPosition: _center);
  }
}
