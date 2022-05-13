part of 'timetable_bloc.dart';

@immutable
abstract class _TimetableEvent {
  const _TimetableEvent();
}

class _InitializeEvent extends _TimetableEvent {
  const _InitializeEvent();
}
