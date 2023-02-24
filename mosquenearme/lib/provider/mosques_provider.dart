import 'package:flutter/material.dart';
import 'package:mosquenearme/model/mosque.dart';

class MosquesProvider extends ChangeNotifier {
  List<Mosque> _mosques = [];
  List<Mosque> get mosques => _mosques;
  set mosques(List<Mosque> mosques) {
    _mosques = mosques;
    notifyListeners();
  }
}
