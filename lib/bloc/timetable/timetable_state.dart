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

  final Ride? selectedRide;

  const TimetableState({
    required this.isLoading,
    required this.initialized,
    required this.from,
    required this.destination,
    required this.date,
    required this.rideList,
    required this.failure,
    required this.selectedRide,
  });

  const TimetableState.initial({
    required this.from,
    required this.destination,
    required this.date,
  })  : isLoading = null,
        initialized = false,
        rideList = null,
        failure = null,
        selectedRide = null;

  TimetableState copyWith({
    bool? isLoading,
    bool? initialized,
    String? from,
    String? destination,
    DateTime? date,
    List<Ride>? rideList,
    Failure? failure,
    Ride? selectedRide,
    bool? overrideRide,
  }) {
    return TimetableState(
      isLoading: isLoading ?? this.isLoading,
      initialized: initialized ?? this.initialized,
      from: from ?? this.from,
      destination: destination ?? this.destination,
      date: date ?? this.date,
      rideList: rideList ?? this.rideList,
      failure: failure,
      selectedRide: overrideRide == true
          ? selectedRide
          : selectedRide ?? this.selectedRide,
    );
  }
}
