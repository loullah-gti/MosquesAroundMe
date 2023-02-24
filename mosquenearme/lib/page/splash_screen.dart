import 'package:flutter/material.dart';
import 'package:mosquenearme/component/splashscreen_content.dart';
import 'package:mosquenearme/page/main_page.dart';
import 'package:mosquenearme/service/all_providers_service.dart';
import 'package:mosquenearme/service/app_init.dart';
import 'package:mosquenearme/service/location_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? animation;

  bool courseExists = false;

  @override
  void initState() {
    super.initState();
    // initRemoteConfigs();
    animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(animationController!);

    animationController?.forward();

    animationController?.addListener(() {
      setState(() {});
    });
    startCountdown();
  }

  @override
  void dispose() {
    animation?.removeListener(() {});
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AllProvidersService.initProviders(context);
    return Scaffold(
      backgroundColor: animation?.value,
      body: Stack(
        children: const [
          SplashScreenContent(),
        ],
      ),
    );
  }

  startCountdown() {
    Future.delayed(Duration(seconds: 1), () async {
      try {
        await AppInitializer.init();
        await LocationService.getCurrentLocation();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => MainPage()));
      } catch (e, st) {
        print(e);
      }
    });
  }
}
