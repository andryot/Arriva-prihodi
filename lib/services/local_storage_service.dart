import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/ride.dart';
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
  static const String _favorites = 'favorites';
  static const String _automaticScroll = 'automatic_scroll';

  ThemeData getThemeData() {
    final bool? isDarkMode = sharedPreferences.getBool(_theme);

    if (isDarkMode == null) return apThemeDark;

    return isDarkMode == true ? apThemeDark : apThemeLight;
  }

  void setThemeData(ThemeData themeData) async {
    await sharedPreferences.setBool(_theme, themeData == apThemeDark);
  }

  List<Ride>? getFavorites() {
    final List<String>? favoritesString =
        sharedPreferences.getStringList(_favorites);

    if (favoritesString == null) return null;

    final List<Ride> favorites = [];

    for (final String rideString in favoritesString) {
      final Ride ride = Ride.fromJson(json.decode(rideString));
      favorites.add(ride);
    }
    return favorites;
  }

  Future<bool?> saveFavorites(List<Ride>? favorites) async {
    if (favorites == null) return null;
    final List<String> favoritesString = [];

    for (final Ride ride in favorites) {
      favoritesString.add(json.encode(ride.toJson()));
    }

    return await sharedPreferences.setStringList(_favorites, favoritesString);
  }

  void setAutomaticScroll(bool automaticScroll) async {
    await sharedPreferences.setBool(_automaticScroll, automaticScroll);
  }

  bool? getAutomaticScroll() {
    return sharedPreferences.getBool(_automaticScroll);
  }
}
