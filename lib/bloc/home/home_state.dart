part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool? initialized;
  final DateTime selectedDate;
  final List<Ride>? favoriteRides;
  final bool isFromError;
  final bool isDestinationError;
  const HomeState({
    required this.initialized,
    required this.selectedDate,
    required this.favoriteRides,
    required this.isFromError,
    required this.isDestinationError,
  });

  HomeState.initial(this.favoriteRides)
      : initialized = null,
        selectedDate = DateTime.now(),
        isFromError = false,
        isDestinationError = false;

  HomeState copyWith({
    bool? initialized,
    DateTime? selectedDate,
    List<Ride>? favoriteRides,
    bool? isFromError,
    bool? isDestinationError,
  }) {
    return HomeState(
      initialized: initialized ?? this.initialized,
      selectedDate: selectedDate ?? this.selectedDate,
      favoriteRides: favoriteRides ?? this.favoriteRides,
      isFromError: isFromError ?? this.isFromError,
      isDestinationError: isDestinationError ?? this.isDestinationError,
    );
  }
}
