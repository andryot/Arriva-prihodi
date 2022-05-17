part of 'global_bloc.dart';

class GlobalState {
  final List<Ride>? favorites;
  final List<String> stations;
  final Map<String, int> stationId;
  const GlobalState({
    required this.favorites,
    required this.stations,
    required this.stationId,
  });

  const GlobalState.initial()
      : favorites = null,
        stations = const [],
        stationId = const {};

  GlobalState copyWith({
    List<Ride>? favorites,
    List<String>? stations,
    Map<String, int>? stationId,
  }) {
    return GlobalState(
      favorites: favorites ?? this.favorites,
      stations: stations ?? this.stations,
      stationId: stationId ?? this.stationId,
    );
  }
}
