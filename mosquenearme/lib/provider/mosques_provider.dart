import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mosquenearme/model/mosque.dart';
import 'package:mosquenearme/service/all_providers_service.dart';
import 'package:mosquenearme/service/location_service.dart';

class MosquesProvider extends ChangeNotifier {
  List<Mosque> _mosques = [];
  List<Mosque> get mosques => _mosques;
  set mosques(List<Mosque> mosques) {
    _mosques = mosques;
    notifyListeners();
  }

  sortMosquesByDistance() {
    for (var element in _mosques) {
      LocationService.setDistanceFromCurrentLocation(element);
    }
    _mosques.sort((m1, m2) {
      double d1 = m1.distanceFromCurrentPos ?? 0;
      double d2 = m2.distanceFromCurrentPos ?? 0;
      return d1.compareTo(d2);
    });
    log("${_mosques.length}");
  }

  int _featuredMosque = 0;
  int get featuredMosque => _featuredMosque;
  set featuredMosque(int value) {
    _featuredMosque = value;
    //TODO: zoom to mosque position
    AllProvidersService.mapProvider?.zoomToPosition(
      _mosques[value].gps.latitude,
      _mosques[value].gps.longitude,
    );
    notifyListeners();
  }

  bool isFeatured(String id) {
    return _mosques[featuredMosque].id == id;
  }

  PageController controller = PageController(
    viewportFraction: 0.7,
  );
}
