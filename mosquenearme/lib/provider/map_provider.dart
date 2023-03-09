import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  GoogleMapController? _mapController;

  void onCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void zoomToPosition(double latitude, double longitude) async {
    LatLng position = LatLng(latitude, longitude);

    var googlePlex = CameraPosition(
      target: position,
      zoom: 15.0,
    );
    //_mapController.future.then((mapControl) {
    Future.delayed(Duration(milliseconds: 100), () async {
      if (_mapController != null &&
          WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
        try {
          await _mapController?.getVisibleRegion();
        } catch (e) {}

        try {
          _mapController
              ?.animateCamera(CameraUpdate.newCameraPosition(googlePlex))
              .then((value) => {notifyListeners()});
        } catch (e) {
          return null;
        }
        notifyListeners();
      }
      // });
    });
  }
}
