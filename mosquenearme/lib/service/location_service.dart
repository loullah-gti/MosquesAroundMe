import 'dart:async';
import 'dart:math' show cos, sqrt, asin;

import 'package:geolocator/geolocator.dart';
import 'package:mosquenearme/model/mosque.dart';
import 'package:mosquenearme/service/all_providers_service.dart';

class LocationService {
  static Future<Position?> getCurrentLocation(
      {double desiredPrecision = 100}) async {
    try {
      await checkGpsEnabled();

      var stateGps = await checkGpsEnabled();
      if (stateGps) {
        Position p = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            timeLimit: Duration(seconds: 120));
        AllProvidersService.myPositionProvider?.currentPosition = p;
        return p.isMocked ? null : p;
      }

      return null;
    } catch (e, st) {
      return null;
    } finally {}
  }

  static Future<bool> checkGpsEnabled() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      LocationPermission permissionCheck = await Geolocator.checkPermission();
      if (!serviceEnabled) {
        await Geolocator.requestPermission();
      } else if (serviceEnabled &&
          (permissionCheck == LocationPermission.denied ||
              permissionCheck == LocationPermission.deniedForever)) {
        await Geolocator.requestPermission();
      }

      return serviceEnabled;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  static streamLocationUpdates() {
    late LocationSettings locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        intervalDuration: const Duration(seconds: 60));
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((p) {
      AllProvidersService.myPositionProvider?.currentPosition = p;
    });
  }

  static void setDistanceFromCurrentLocation(Mosque m) {
    if (AllProvidersService.myPositionProvider?.currentPosition != null) {
      m.distanceFromCurrentPos = calculateDistance(
          m.gps.latitude,
          m.gps.longitude,
          AllProvidersService.myPositionProvider?.currentPosition?.latitude,
          AllProvidersService.myPositionProvider?.currentPosition?.longitude);
    }
  }
}
