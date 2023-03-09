import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosquenearme/provider/mosques_provider.dart';
import 'package:mosquenearme/service/all_providers_service.dart';
import 'package:mosquenearme/service/mosque_service.dart';
import 'package:provider/provider.dart';

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
    MosquesProvider mosquesProvider = Provider.of(context);
    return GoogleMap(
      initialCameraPosition: _center,
      mapType: MapType.satellite,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: MosqueService.getMarkers(mosquesProvider.mosques),
      onMapCreated: AllProvidersService.mapProvider?.onCreated,
    );
  }
}
