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
}
