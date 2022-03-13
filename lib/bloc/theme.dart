import 'package:flutter/material.dart';

class MyTheme with ChangeNotifier {
  bool _isDark = true;


  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDark {
    return _isDark;
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  Color starColor() {
    return _isDark ? Colors.white : Colors.black;
  }

  
}
