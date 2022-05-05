part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool? initialized;

  const HomeState({
    required this.initialized,
  });

  const HomeState.initial() : initialized = null;

  HomeState copyWith({
    bool? initialized,
  }) {
    return HomeState(
      initialized: initialized ?? this.initialized,
    );
  }
}
