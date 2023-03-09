import 'package:mosquenearme/provider/map_provider.dart';
import 'package:mosquenearme/provider/mosques_provider.dart';
import 'package:mosquenearme/provider/my_position_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> allAppProviders = [
  ChangeNotifierProvider(create: (_) => MosquesProvider()),
  ChangeNotifierProvider(create: (_) => MyPositionProvider()),
  ChangeNotifierProvider(create: (_) => MapProvider()),
];
