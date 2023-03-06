import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mosquenearme/model/mosque.dart';
import 'package:mosquenearme/service/all_providers_service.dart';
import 'package:mosquenearme/service/maps_service.dart';

class MosqueService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Set<Marker> getMarkers(List<Mosque> mosques) {
    Set<Marker> markers = {};
    for (Mosque m in mosques) {
      LatLng p = LatLng(m.gps.latitude, m.gps.longitude);
      Marker marker = Marker(
        markerId: MarkerId(m.id),
        position: p,
        icon: AllProvidersService.mosquesProvider?.isFeatured(m.id) ?? false
            ? MapsService.mosqueMarkerHuge
            : MapsService.mosqueMarker,
        onTap: () {
          int i = AllProvidersService.mosquesProvider?.mosques.indexOf(m) ?? 0;
          AllProvidersService.mosquesProvider?.featuredMosque = i;
          AllProvidersService.mosquesProvider?.controller.animateToPage(i,
              duration: const Duration(seconds: 1), curve: Curves.easeIn);
        },
      );
      markers.add(marker);
    }
    return markers;
  }

  static Future getMosques() async {
    try {
      CollectionReference<Mosque> ref = firestore
          .collection("mosques")
          .withConverter(
              fromFirestore: (snapshot, _) => Mosque.fromJson(snapshot.data()!),
              toFirestore: (mosque, _) => mosque.toJson());
      QuerySnapshot<Mosque> sn = await ref.get();
      List<Mosque> list = sn.docs
          .map((e) => Mosque(
              id: e.id,
              gps: e.get("gps"),
              lastUpdate: e.get("lastUpdate"),
              lib: e.get("lib"),
              prayers: e.get("prayers")))
          .toList();
      AllProvidersService.mosquesProvider?.mosques = list;
    } catch (ex) {
      log(ex.toString());
    }
  }
}
