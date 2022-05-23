part of 'loading_indicator_bloc.dart';

@immutable
abstract class LoadingIndicatorEvent {
  const LoadingIndicatorEvent();
}

class _TimerTick extends LoadingIndicatorEvent {
  const _TimerTick();
}
