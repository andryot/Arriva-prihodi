import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../style/theme.dart';

class LocalStorageService {
  final SharedPreferences sharedPreferences;
  static LocalStorageService? _instance;
  static LocalStorageService get instance => _instance!;

  LocalStorageService._({required this.sharedPreferences});

  factory LocalStorageService(SharedPreferences _sharedPreferences) {
    if (_instance != null) {
      throw StateError('LocalStorageService already created');
    }

    _instance = LocalStorageService._(sharedPreferences: _sharedPreferences);
    return _instance!;
  }

  static const String _theme = 'theme';

  ThemeData getThemeData() {
    final bool? isDarkMode = sharedPreferences.getBool(_theme);

    if (isDarkMode == null) return apThemeDark;

    return isDarkMode == true ? apThemeDark : apThemeLight;
  }

  void setThemeData(ThemeData themeData) async {
    await sharedPreferences.setBool(_theme, themeData == apThemeDark);
  }
}
