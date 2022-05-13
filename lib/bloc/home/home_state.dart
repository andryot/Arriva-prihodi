part of 'home_bloc.dart';

@immutable
class HomeState {
  final bool? initialized;
  final DateTime selectedDate;
  const HomeState({
    required this.initialized,
    required this.selectedDate,
  });

  HomeState.initial()
      : initialized = null,
        selectedDate = DateTime.now();

  HomeState copyWith({
    bool? initialized,
    DateTime? selectedDate,
  }) {
    return HomeState(
      initialized: initialized ?? this.initialized,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
