import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode {
    return _themeMode;
  }

  void switchTheme() {
    _themeMode =
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  Color starColor() {
    return _themeMode == ThemeMode.dark ? Colors.white : Colors.black;
  }
}
