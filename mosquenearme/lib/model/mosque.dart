import 'package:cloud_firestore/cloud_firestore.dart';

class Mosque {
  GeoPoint gps;
  String id;
  String lib;
  Map<String, dynamic> prayers;
  Timestamp lastUpdate;
  Mosque(
      {required this.id,
      required this.gps,
      required this.lastUpdate,
      required this.lib,
      required this.prayers});

  Mosque.fromJson(Map<String, Object?> json)
      : this(
          gps: json['gps']! as GeoPoint,
          id: json['id']! as String,
          lib: json['lib']! as String,
          prayers: json['prayers']! as Map<String, String>,
          lastUpdate: json['lastUpdate']! as Timestamp,
        );

  Map<String, Object?> toJson() {
    return {
      'gps': gps,
      'id': id,
      'lib': lib,
      'prayers': prayers,
      'lastUpdate': lastUpdate,
    };
  }
}
