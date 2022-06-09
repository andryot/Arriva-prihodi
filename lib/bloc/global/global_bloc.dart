import 'dart:async';

import '../../models/ride.dart';
import '../../services/local_storage_service.dart';
import '../../util/logger.dart';

part 'global_state.dart';

class GlobalBloc {
  static GlobalBloc? _instance;
  static GlobalBloc get instance => _instance!;

  Stream<void> get globalFavoritesStream => _globalFavorites.stream;

  final Logger _logger;
  final LocalStorageService _localStorageService;

  final StreamController<void> _globalFavorites;

  GlobalState _state;
  GlobalState get state => _state;

  GlobalBloc._({
    required Logger logger,
    required LocalStorageService localStorageService,
  })  : _logger = logger,
        _localStorageService = localStorageService,
        _globalFavorites = StreamController<void>.broadcast(),
        _state = const GlobalState.initial();

  factory GlobalBloc({
    required Logger logger,
    required LocalStorageService localStorageService,
  }) {
    if (_instance != null) {
      throw StateError('GlobalBloc already created!');
    }

    _instance =
        GlobalBloc._(logger: logger, localStorageService: localStorageService);
    return _instance!;
  }

  void reset() {
    _state = const GlobalState.initial();
    _logger.info('GlobalBloc.reset', 'state reset');
  }

  void updateStations(List<String>? stations, Map<String, int>? stationId) {
    if (stations == null || stationId == null) return;
    _state = _state.copyWith(stations: stations, stationId: stationId);
  }

  void getFavorites() async {
    final List<Ride>? favorites = _localStorageService.getFavorites();
    if (favorites == null) return;

    _state = _state.copyWith(favorites: favorites);
    _logger.info('GlobalBloc.getFavorites', 'favorites retrieved');
  }

  Future<bool> saveFavorites() async {
    final bool? result =
        await _localStorageService.saveFavorites(_state.favorites);
    if (result == null) return false;
    _logger.info('GlobalBloc.saveFavorites', 'favorites saved');
    return result;
  }

  Future<void> removeFavorite(Ride? rideToRemove) async {
    if (rideToRemove == null) return;
    if (_state.favorites == null) return;

    for (Ride ride in _state.favorites!) {
      if (ride == rideToRemove) {
        _state.favorites!.remove(ride);
        break;
      }
    }
    _state = _state.copyWith(favorites: _state.favorites);
    _globalFavorites.add(null);
    await saveFavorites();
  }

  Future<void> addFavorite(Ride? rideToAdd) async {
    if (rideToAdd == null) return;

    if (_state.favorites == null) {
      _state = _state.copyWith(favorites: [rideToAdd]);
      await saveFavorites();
      _globalFavorites.add(null);
      return;
    }

    if (_state.favorites!.contains(rideToAdd)) {
      return;
    }
    _state.favorites!.add(rideToAdd);
    _state = _state.copyWith(favorites: _state.favorites);
    _globalFavorites.add(null);
    await saveFavorites();
  }

  bool isFavorite(Ride ride) {
    return _state.favorites != null && _state.favorites!.contains(ride);
  }

  void switchTheme() {
    _state = _state.copyWith(isDarkMode: !_state.isDarkMode);
  }

  void setIsDarkMode(bool isDarkMode) {
    _state = _state.copyWith(isDarkMode: isDarkMode);
  }

  void setSaveLastSearch(bool? isSaveLastSearch) {
    if (isSaveLastSearch == null) return;
    _state = _state.copyWith(isSaveLastSearch: isSaveLastSearch);
    _localStorageService.setSaveLastSearch(isSaveLastSearch);
  }

  void reorderFavorites(int oldIndex, int newIndex) {
    if (_state.favorites == null) return;
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Ride ride = _state.favorites!.removeAt(oldIndex);
    _state.favorites!.insert(newIndex, ride);

    _state = _state.copyWith(favorites: _state.favorites);
    _globalFavorites.add(null);
    saveFavorites();
  }

  void setAutomaticScroll(bool? automaticScroll) {
    if (automaticScroll == null) return;
    _state = _state.copyWith(automaticScroll: automaticScroll);
    _localStorageService.setAutomaticScroll(automaticScroll);
  }

  String? validateStation(String? station) {
    if (station == null) return null;
    for (String stationn in _state.stations) {
      if (stationn.toLowerCase() == station.toLowerCase()) return stationn;
    }
    return null;
  }

  void getOldFavorites() async {
    final List<Ride>? favorites = await _localStorageService.getOldFavorites();
    if (favorites == null) return;

    _localStorageService.saveFavorites(favorites);
    _state = _state.copyWith(favorites: favorites);
    _logger.info('GlobalBloc.getOldFavorites', 'old favorites retrieved');
  }

  void setLastSearch(String? from, String? to) {
    _state = _state.copyWith(lastFrom: from, lastTo: to);
    if (from != null) _localStorageService.setLastFrom(from);
    if (to != null) _localStorageService.setLastTo(to);
  }

  void loadLastSearch() async {
    final Map<String, String?> lastStations =
        await _localStorageService.getLastSearch();

    _state = _state.copyWith(
      lastFrom: lastStations['from'],
      lastTo: lastStations['to'],
    );
  }
}
