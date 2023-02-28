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

  NextPrayerInfos getNextPrayer() {
    DateTime now = DateTime.now();
    return NextPrayerInfos(
        lib: "العصر", time: this.prayers["asr"], status: 1, munitesLeft: 5);
  }

  String getNextPrayerLib() {
    DateTime now = DateTime.now();
    return this.prayers["asr"];
  }
}

class NextPrayerInfos {
  final String lib;
  final String time;
  final int munitesLeft;
  final int status;

  NextPrayerInfos(
      {required this.lib,
      required this.time,
      required this.status,
      required this.munitesLeft});
}
