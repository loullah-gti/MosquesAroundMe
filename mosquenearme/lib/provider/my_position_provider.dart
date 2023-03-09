import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mosquenearme/service/all_providers_service.dart';

class MyPositionProvider extends ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  set currentPosition(Position? p) {
    _currentPosition = p;
    AllProvidersService.mosquesProvider?.sortMosquesByDistance();
    notifyListeners();
  }
}
