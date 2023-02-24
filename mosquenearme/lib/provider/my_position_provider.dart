import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MyPositionProvider extends ChangeNotifier {
  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;
  set currentPosition(Position? p) {
    _currentPosition = p;
    notifyListeners();
  }
}
