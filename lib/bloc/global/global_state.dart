part of 'global_bloc.dart';

@immutable
class GlobalState {
  final List<String> favorites;

  const GlobalState({
    required this.favorites,
  });

  const GlobalState.initial() : favorites = const [];

  GlobalState copyWith({
    List<String>? favorites,
  }) {
    return GlobalState(
      favorites: favorites ?? this.favorites,
    );
  }
}
