part of 'global_bloc.dart';

@immutable
class GlobalState {
  final List<String> favorites;
  final List<String> stations;
  final Map<String, int> stationId;
  const GlobalState({
    required this.favorites,
    required this.stations,
    required this.stationId,
  });

  const GlobalState.initial()
      : favorites = const [],
        stations = const [],
        stationId = const {};

  GlobalState copyWith({
    List<String>? favorites,
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
