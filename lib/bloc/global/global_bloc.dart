import 'dart:async';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import '../../util/logger.dart';

part 'global_state.dart';

class GlobalBloc {
  static GlobalBloc? _instance;
  static GlobalBloc get instance => _instance!;

  bool isDarkMode;

  final Logger _logger;

  GlobalState _state;
  GlobalState get state => _state;

  GlobalBloc._({required Logger logger})
      : _logger = logger,
        isDarkMode = true,
        _state = const GlobalState.initial();

  factory GlobalBloc({required Logger logger}) {
    if (_instance != null) {
      throw StateError('GlobalBloc already created!');
    }

    _instance = GlobalBloc._(logger: logger);
    return _instance!;
  }

  void reset() {
    _state = const GlobalState.initial();
    _logger.info('GlobalBloc.reset', 'state reset');
  }

  void updateFavorites(List<String>? favorites) {
    if (favorites == null) return;
    _state = _state.copyWith(favorites: favorites);

    _logger.info('GlobalBloc.updateFavorites', 'favorites updated');
  }

  void updateStations(List<String>? stations) {
    if (stations == null) return;
    _state = _state.copyWith(stations: stations);
  }

  void switchTheme() {
    isDarkMode = !isDarkMode;
  }
}
