part of 'timetable_bloc.dart';

@immutable
class TimetableState {
  final bool? isLoading;
  final bool initialized;

  final String from;
  final String destination;
  final DateTime date;

  final List<Ride>? rideList;

  final Failure? failure;
  const TimetableState({
    required this.isLoading,
    required this.initialized,
    required this.from,
    required this.destination,
    required this.date,
    required this.rideList,
    required this.failure,
  });

  const TimetableState.initial({
    required this.from,
    required this.destination,
    required this.date,
  })  : isLoading = null,
        initialized = false,
        rideList = null,
        failure = null;

  TimetableState copyWith({
    bool? isLoading,
    bool? initialized,
    String? from,
    String? destination,
    DateTime? date,
    List<Ride>? rideList,
    Failure? failure,
  }) {
    return TimetableState(
      isLoading: isLoading ?? this.isLoading,
      initialized: initialized ?? this.initialized,
      from: from ?? this.from,
      destination: destination ?? this.destination,
      date: date ?? this.date,
      rideList: rideList ?? this.rideList,
      failure: failure,
    );
  }
}
