import 'package:flutter/material.dart';
import 'package:mosquenearme/component/maps_widget.dart';
import 'package:mosquenearme/page/mosques_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapsWidget(),
          MosquesList(),
        ],
      ),
    );
  }
}
