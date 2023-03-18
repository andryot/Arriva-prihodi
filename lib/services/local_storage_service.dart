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

  factory LocalStorageService(SharedPreferences sharedPreferences) {
    if (_instance != null) {
      throw StateError('LocalStorageService already created');
    }

    _instance = LocalStorageService._(sharedPreferences: sharedPreferences);
    return _instance!;
  }

  static const String _theme = 'theme';
  static const String _favorites = 'favorites_new';
  static const String _favoritesOld = 'favorites';
  static const String _saveLastSearch = 'save_last_search';
  static const String _lastFrom = 'last_from';
  static const String _lastTo = 'last_to';

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

  Future<List<Ride>?> getOldFavorites() async {
    final List<String>? favoritesString =
        sharedPreferences.getStringList(_favoritesOld);

    if (favoritesString == null) return null;

    final List<Ride> favorites = [];

    for (final String rideString in favoritesString) {
      final List<String> rideStringList = rideString.split('+');
      if (rideStringList.length != 2) continue;
      final Ride ride = Ride.fromJson({
        RideJsonKey.from: rideStringList[0],
        RideJsonKey.destination: rideStringList[1]
      });
      favorites.add(ride);
    }
    await sharedPreferences.remove(_favoritesOld);
    return favorites;
  }

  void setAutomaticScroll(bool automaticScroll) async {
    await sharedPreferences.setBool(_automaticScroll, automaticScroll);
  }

  bool? getAutomaticScroll() {
    return sharedPreferences.getBool(_automaticScroll);
  }

  void setSaveLastSearch(bool saveLastSearch) async {
    await sharedPreferences.setBool(_saveLastSearch, saveLastSearch);
  }

  bool? getSaveLastSearch() {
    return sharedPreferences.getBool(_saveLastSearch);
  }

  Future<Map<String, String?>> getLastSearch() async {
    final String? from = sharedPreferences.getString(_lastFrom);
    final String? to = sharedPreferences.getString(_lastTo);
    return {
      'from': from,
      'to': to,
    };
  }

  void setLastFrom(String from) async {
    await sharedPreferences.setString(_lastFrom, from);
  }

  void setLastTo(String to) async {
    await sharedPreferences.setString(_lastTo, to);
  }
}
