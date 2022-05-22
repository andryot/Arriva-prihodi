part of 'global_bloc.dart';

class GlobalState {
  final List<Ride>? favorites;
  final List<String> stations;
  final Map<String, int> stationId;
  final bool automaticScroll;
  final bool isDarkMode;
  const GlobalState({
    required this.favorites,
    required this.stations,
    required this.stationId,
    required this.automaticScroll,
    required this.isDarkMode,
  });

  const GlobalState.initial()
      : favorites = null,
        stations = const [],
        stationId = const {},
        automaticScroll = true,
        isDarkMode = true;

  GlobalState copyWith({
    List<Ride>? favorites,
    List<String>? stations,
    Map<String, int>? stationId,
    bool? automaticScroll,
    bool? isDarkMode,
  }) {
    return GlobalState(
      favorites: favorites ?? this.favorites,
      stations: stations ?? this.stations,
      stationId: stationId ?? this.stationId,
      automaticScroll: automaticScroll ?? this.automaticScroll,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
