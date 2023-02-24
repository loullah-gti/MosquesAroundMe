import 'package:flutter/material.dart';

class SplashScreenContent extends StatelessWidget {
  const SplashScreenContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'logo',
            child: Container(
              height: 200,
              child: Image.asset("assets/icons/mosque-icon.png"),
            ),
          ),
          CircularProgressIndicator(
            color: Colors.green[300],
          ),
        ],
      ),
    );
  }
}
