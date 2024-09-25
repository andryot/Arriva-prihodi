part of 'splash_bloc.dart';

@immutable
abstract class _SplashEvent {
  const _SplashEvent();
}

class _Initialize extends _SplashEvent {
  const _Initialize();
}

class _TimerTick extends _SplashEvent {
  const _TimerTick();
}
