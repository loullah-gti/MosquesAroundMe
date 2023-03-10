import 'package:mosquenearme/provider/map_provider.dart';
import 'package:mosquenearme/provider/my_position_provider.dart';
import 'package:provider/provider.dart';
import 'package:mosquenearme/provider/mosques_provider.dart';

class AllProvidersService {
  static MosquesProvider? _mosquesProvider;
  static MosquesProvider? get mosquesProvider => _mosquesProvider;
  static MyPositionProvider? _myPositionProvider;
  static MyPositionProvider? get myPositionProvider => _myPositionProvider;
  static MapProvider? _mapProvider;
  static MapProvider? get mapProvider => _mapProvider;

  static initProviders(context) {
    _mosquesProvider = Provider.of<MosquesProvider>(context);
    _myPositionProvider = Provider.of<MyPositionProvider>(context);
    _mapProvider = Provider.of<MapProvider>(context);
  }
}
