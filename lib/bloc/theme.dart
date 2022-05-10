import 'package:bus_time_table/style/theme.dart';
import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;
  ThemeData _themeData = apThemeDark;

  ThemeData get themeData {
    return _themeData;
  }

  ThemeMode get themeMode {
    return _themeMode;
  }

  set themeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
  }

  set themeData(ThemeData themeData) {
    _themeData = themeData;
  }

  void switchTheme() {
    _themeData = _themeData == apThemeDark ? apThemeLight : apThemeDark;
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  Color starColor() {
    return _themeData == apThemeDark ? Colors.white : Colors.black;
  }
}
