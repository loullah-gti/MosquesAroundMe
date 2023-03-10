import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mosquenearme/firebase_options.dart';
import 'package:mosquenearme/page/main_page.dart';
import 'package:mosquenearme/page/splash_screen.dart';
import 'package:mosquenearme/provider/list_providers.dart';
import 'package:mosquenearme/provider/map_provider.dart';
import 'package:mosquenearme/provider/mosques_provider.dart';
import 'package:mosquenearme/provider/my_position_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: allAppProviders,
      child: MaterialApp(
        home: SplashScreen(),
        locale: const Locale("ar"),
      ),
    );
  }
}
