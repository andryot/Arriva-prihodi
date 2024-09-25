part of 'splash_bloc.dart';

@immutable
class SplashState {
  final bool initialized;
  final String? pushRoute;

  final double deltaLogoSize;

  const SplashState({
    required this.initialized,
    required this.pushRoute,
    required this.deltaLogoSize,
  });

  const SplashState.initial()
      : initialized = false,
        pushRoute = null,
        deltaLogoSize = 0;

  SplashState copyWith({
    bool? initialized,
    String? pushRoute,
    double? deltaLogoSize,
  }) {
    return SplashState(
      initialized: initialized ?? this.initialized,
      pushRoute: pushRoute,
      deltaLogoSize: deltaLogoSize ?? this.deltaLogoSize,
    );
  }
}
