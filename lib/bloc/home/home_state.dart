part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool? initialized;
  final DateTime selectedDate;
  final List<Ride>? favoriteRides;
  const HomeState({
    required this.initialized,
    required this.selectedDate,
    required this.favoriteRides,
  });

  HomeState.initial(this.favoriteRides)
      : initialized = null,
        selectedDate = DateTime.now();

  HomeState copyWith({
    bool? initialized,
    DateTime? selectedDate,
    List<Ride>? favoriteRides,
  }) {
    return HomeState(
      initialized: initialized ?? this.initialized,
      selectedDate: selectedDate ?? this.selectedDate,
      favoriteRides: favoriteRides ?? this.favoriteRides,
    );
  }
}
