import 'package:intl/intl.dart';
import 'package:mosquenearme/model/mosque.dart';

DateTime getNextPrayerTime(List<String> openingHours) {
  final now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(now);

  final midnight = DateTime(now.year, now.month, now.day);
  // Sort the opening hours in ascending order
  final sortedOpeningHours = openingHours
      .map((hour) => DateTime.parse('$formatted $hour'))
      .toList()
    ..sort();

  // Find the next opening hour
  return sortedOpeningHours.firstWhere((hour) => hour.isAfter(now),
      orElse: () =>
          sortedOpeningHours.firstWhere((hour) => hour.isAfter(midnight)));
}

String getNextPrayerTimeStr(List<String> openingHours) {
  DateTime nextOpeningHour = getNextPrayerTime(openingHours);

  return "${nextOpeningHour.hour.toString().padLeft(2, '0')}:${nextOpeningHour.minute.toString().padLeft(2, '0')}";
}

int getNextPrayerTimeHoursLeft(List<String> openingHours) {
  final now = DateTime.now();
  DateTime nextOpeningHour = getNextPrayerTime(openingHours);

  return nextOpeningHour.difference(now).inHours;
}

int getNextPrayerTimeMunitesLeft(List<String> openingHours) {
  final now = DateTime.now();
  DateTime nextOpeningHour = getNextPrayerTime(openingHours);

  return nextOpeningHour.difference(now).inMinutes;
}

String getTimeLeftStr(int hoursLeft, int munitesLeft) {
  if (hoursLeft == 0 && munitesLeft == 0) {
    return "الآن";
  }
  String res = "باقي: ";
  if (hoursLeft == 2) {
    res += "ساعتان و ";
  } else if (hoursLeft == 0) {
    res += "";
  } else if (hoursLeft < 2 || hoursLeft > 10) {
    res += "$hoursLeft ساعة و";
  } else if (hoursLeft > 2 && hoursLeft <= 10) {
    res += "$hoursLeft ساعات و";
  }

  if (munitesLeft == 2) {
    res += "دقيقتان";
  } else if (munitesLeft < 2 || munitesLeft > 10) {
    res += "$munitesLeft دقيقة";
  } else {
    res += "$munitesLeft دقائق";
  }
  return res;
}

String getPrayerLibByCode(String code) {
  switch (code) {
    case Mosque.prayerCodeFajr:
      return "الفجر";
    case Mosque.prayerCodeDouhr:
      return "الظهر";
    case Mosque.prayerCodeAsr:
      return "العصر";
    case Mosque.prayerCodeMaghreb:
      return "المغرب";
    case Mosque.prayerCodeIshaa:
      return "العشاء";
    case Mosque.prayerCodeJoumaa:
      return "الجمعة";
  }
  return "";
}
