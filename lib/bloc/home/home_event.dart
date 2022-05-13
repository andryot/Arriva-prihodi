part of 'home_bloc.dart';

@immutable
abstract class _HomeEvent {
  const _HomeEvent();
}

class _DateChangedEvent extends _HomeEvent {
  final DateTime date;
  const _DateChangedEvent(this.date);
}
