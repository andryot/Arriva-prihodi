part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool? initialized;
  final DateTime selectedDate;
  final List<Ride>? favoriteRides;
  final bool isFromError;
  final bool isDestinationError;
  final double turns;
  const HomeState({
    required this.initialized,
    required this.selectedDate,
    required this.favoriteRides,
    required this.isFromError,
    required this.isDestinationError,
    required this.turns,
  });

  HomeState.initial(this.favoriteRides)
      : initialized = null,
        selectedDate = DateTime.now(),
        isFromError = false,
        isDestinationError = false,
        turns = 0.0;

  HomeState copyWith({
    bool? initialized,
    DateTime? selectedDate,
    List<Ride>? favoriteRides,
    bool? isFromError,
    bool? isDestinationError,
    double? turns,
  }) {
    return HomeState(
      initialized: initialized ?? this.initialized,
      selectedDate: selectedDate ?? this.selectedDate,
      favoriteRides: favoriteRides ?? this.favoriteRides,
      isFromError: isFromError ?? this.isFromError,
      isDestinationError: isDestinationError ?? this.isDestinationError,
      turns: turns ?? this.turns,
    );
  }
}
