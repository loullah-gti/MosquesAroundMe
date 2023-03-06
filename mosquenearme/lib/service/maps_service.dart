import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosquenearme/service/imageTools.dart';

class MapsService {
  static late BitmapDescriptor mosqueMarker;
  static late BitmapDescriptor mosqueMarkerHuge;
  static Future initMarkerIcon() async {
    mosqueMarker = BitmapDescriptor.fromBytes(
        await ImageTools.getBytesFromAsset('assets/icons/mosque-icon.png', 40));
    mosqueMarkerHuge = BitmapDescriptor.fromBytes(
        await ImageTools.getBytesFromAsset(
            'assets/icons/mosque-icon.png', 120));
  }
}
