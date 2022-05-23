part of 'timetable_bloc.dart';

@immutable
abstract class _TimetableEvent {
  const _TimetableEvent();
}

class _InitializeEvent extends _TimetableEvent {
  const _InitializeEvent();
}

class _ShowDetailsEvent extends _TimetableEvent {
  final int index;
  const _ShowDetailsEvent(this.index);
}

class _FavoriteEvent extends _TimetableEvent {
  const _FavoriteEvent();
}

class _ChangeDateEvent extends _TimetableEvent {
  final DateTime date;
  const _ChangeDateEvent({required this.date});
}

class _CalculateScrollEvent extends _TimetableEvent {
  final Size size;
  final double paddingTop;
  const _CalculateScrollEvent({required this.size, required this.paddingTop});
}
