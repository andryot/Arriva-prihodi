part of 'global_bloc.dart';

@immutable
class GlobalState {
  final List<String> favorites;
  final List<String> stations;

  const GlobalState({
    required this.favorites,
    required this.stations,
  });

  const GlobalState.initial()
      : favorites = const [],
        stations = const [];

  GlobalState copyWith({
    List<String>? favorites,
    List<String>? stations,
  }) {
    return GlobalState(
      favorites: favorites ?? this.favorites,
      stations: stations ?? this.stations,
    );
  }
}
