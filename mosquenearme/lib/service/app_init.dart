import 'package:mosquenearme/service/location_service.dart';
import 'package:mosquenearme/service/maps_service.dart';
import 'package:mosquenearme/service/mosque_service.dart';

class AppInitializer {
  static Future init() async {
    await MapsService.initMarkerIcon();
    await MosqueService.getMosques();
    LocationService.streamLocationUpdates();
  }
}
