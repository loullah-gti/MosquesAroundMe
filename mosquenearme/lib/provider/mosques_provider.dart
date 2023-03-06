import 'package:flutter/material.dart';
import 'package:mosquenearme/model/mosque.dart';

class MosquesProvider extends ChangeNotifier {
  List<Mosque> _mosques = [];
  List<Mosque> get mosques => _mosques;
  set mosques(List<Mosque> mosques) {
    _mosques = mosques;
    notifyListeners();
  }

  int _featuredMosque = 0;
  int get featuredMosque => _featuredMosque;
  set featuredMosque(int value) {
    _featuredMosque = value;
    notifyListeners();
  }

  bool isFeatured(String id) {
    return _mosques[featuredMosque].id == id;
  }

  PageController controller = PageController(
    viewportFraction: 0.7,
  );
}
