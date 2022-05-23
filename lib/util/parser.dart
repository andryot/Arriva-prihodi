import 'dart:io';

import 'package:intl/intl.dart';

class APParser {
  static String dateToString(DateTime dateTime) {
    String dayMonth = 'd.M';
    if (Platform.localeName == 'en_US') {
      dayMonth = 'M.d';
    }
    return DateFormat('$dayMonth.yyyy').format(dateTime);
  }

  static DateTime hourToDate(String hour) {
    return DateFormat.Hm('sl').parse(hour);
  }

  static bool isBefore(String hour) {
    final DateTime now =
        DateTime(1970, 1, 1, DateTime.now().hour, DateTime.now().minute);
    return now.isBefore(hourToDate(hour));
  }
}
