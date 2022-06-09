part of 'global_bloc.dart';

class GlobalState {
  final List<Ride>? favorites;
  final List<String> stations;
  final Map<String, int> stationId;
  final bool automaticScroll;
  final bool isDarkMode;
  final bool isSaveLastSearch;

  final String? lastFrom;
  final String? lastTo;

  const GlobalState({
    required this.favorites,
    required this.stations,
    required this.stationId,
    required this.automaticScroll,
    required this.isDarkMode,
    required this.isSaveLastSearch,
    this.lastFrom,
    this.lastTo,
  });

  const GlobalState.initial()
      : favorites = null,
        stations = const [],
        stationId = const {},
        automaticScroll = true,
        isDarkMode = true,
        isSaveLastSearch = true,
        lastFrom = null,
        lastTo = null;

  GlobalState copyWith({
    List<Ride>? favorites,
    List<String>? stations,
    Map<String, int>? stationId,
    bool? automaticScroll,
    bool? isDarkMode,
    bool? isSaveLastSearch,
    String? lastFrom,
    String? lastTo,
  }) {
    return GlobalState(
      favorites: favorites ?? this.favorites,
      stations: stations ?? this.stations,
      stationId: stationId ?? this.stationId,
      automaticScroll: automaticScroll ?? this.automaticScroll,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isSaveLastSearch: isSaveLastSearch ?? this.isSaveLastSearch,
      lastFrom: lastFrom ?? this.lastFrom,
      lastTo: lastTo ?? this.lastTo,
    );
  }
}
