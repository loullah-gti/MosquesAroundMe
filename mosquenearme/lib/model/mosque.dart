import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mosquenearme/service/time_game/prayer_time_utils.dart';

class Mosque {
  static const String prayerCodeFajr = "fajr";
  static const String prayerCodeDouhr = "douhr";
  static const String prayerCodeAsr = "asr";
  static const String prayerCodeMaghreb = "maghreb";
  static const String prayerCodeIshaa = "ishaa";
  static const String prayerCodeJoumaa = "joumaa";
  GeoPoint gps;
  String id;
  String lib;
  Map<String, dynamic> prayers;
  Timestamp lastUpdate;
  double? distanceFromCurrentPos;
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
    List<APrayer> prayers = _getPrayerValues(this.prayers);
    if (now.weekday == 5) {
      prayers.removeWhere((element) => element.code == prayerCodeDouhr);
    } else {
      prayers.removeWhere((element) => element.code == prayerCodeJoumaa);
    }
    List<String> prayerTimes = prayers.map((e) => e.value).toList();
    String nextPrayerTime = getNextPrayerTimeStr(prayerTimes);
    int hoursLeft = getNextPrayerTimeHoursLeft(prayerTimes);
    int munitesLeft = getNextPrayerTimeMunitesLeft(prayerTimes);
    APrayer nextPrayer = prayers.firstWhere(
      (element) => element.value == nextPrayerTime,
    );
    return NextPrayerInfos(
        lib: getPrayerLibByCode(nextPrayer.code),
        time: nextPrayer.value,
        hoursLeft: hoursLeft,
        munitesLeft: munitesLeft);
  }

  String getNextPrayerLib() {
    return getNextPrayer().lib;
  }

  List<APrayer> _getPrayerValues(Map<String, dynamic> prayers) {
    List<APrayer> res = [];
    for (String key in prayers.keys) {
      List<String> parts = prayers[key].toString().split(":");
      res.add(APrayer(
          code: key,
          value: prayers[key],
          hour: int.parse(parts[0]),
          munites: int.parse(parts[1])));
    }
    return res;
  }
}

class NextPrayerInfos {
  final String lib;
  final String time;
  final int munitesLeft;
  final int hoursLeft;

  NextPrayerInfos({
    required this.lib,
    required this.time,
    required this.munitesLeft,
    required this.hoursLeft,
  });
  get status => hoursLeft == 0 && munitesLeft <= 35 ? 2 : 1;
}

class APrayer {
  String code;
  String value;
  int hour;
  int munites;

  APrayer({
    required this.code,
    required this.value,
    required this.hour,
    required this.munites,
  });
}
