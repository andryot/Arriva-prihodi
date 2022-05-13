part of 'home_bloc.dart';

@immutable
abstract class _HomeEvent {
  const _HomeEvent();
}

class _DateChangedEvent extends _HomeEvent {
  final DateTime date;
  const _DateChangedEvent(this.date);
}

class _SwapEvent extends _HomeEvent {
  const _SwapEvent();
}

class _SearchEvent extends _HomeEvent {
  const _SearchEvent();
}
