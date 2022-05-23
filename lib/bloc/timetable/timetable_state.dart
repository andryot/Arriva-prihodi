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
  final int? index;

  final bool? isFavorite;

  final bool? timeTableLoading;
  final bool timeTableInitialized;

  final GlobalKey globalKey;
  final bool isFirst;

  final int nextRide;

  const TimetableState({
    required this.isLoading,
    required this.initialized,
    required this.from,
    required this.destination,
    required this.date,
    required this.rideList,
    required this.failure,
    required this.selectedRide,
    required this.isFavorite,
    required this.timeTableLoading,
    required this.timeTableInitialized,
    required this.index,
    required this.globalKey,
    required this.isFirst,
    required this.nextRide,
  });

  TimetableState.initial({
    required this.from,
    required this.destination,
    required this.date,
  })  : isLoading = null,
        initialized = false,
        rideList = null,
        failure = null,
        selectedRide = null,
        isFavorite = null,
        timeTableLoading = null,
        timeTableInitialized = false,
        index = null,
        globalKey = GlobalKey(),
        isFirst = true,
        nextRide = 0;

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
    bool? isFavorite,
    bool? timeTableLoading,
    bool? timeTableInitialized,
    int? index,
    GlobalKey? globalKey,
    bool? isFirst,
    int? nextRide,
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
      isFavorite: isFavorite ?? this.isFavorite,
      timeTableLoading: timeTableLoading ?? this.timeTableLoading,
      timeTableInitialized: timeTableInitialized ?? this.timeTableInitialized,
      index: index ?? this.index,
      globalKey: globalKey ?? this.globalKey,
      isFirst: isFirst ?? this.isFirst,
      nextRide: nextRide ?? this.nextRide,
    );
  }
}
