part of 'loading_indicator_bloc.dart';

@immutable
class LoadingIndicatorState {
  final List<Color> colors;
  const LoadingIndicatorState({required this.colors});

  LoadingIndicatorState.initial()
      : colors = [
          const CupertinoDynamicColor.withBrightness(
              color: Color.fromRGBO(0, 24, 152, 0.1),
              darkColor: Color.fromRGBO(0, 167, 220, 0.1)),
          const CupertinoDynamicColor.withBrightness(
              color: Color.fromRGBO(0, 24, 152, 0.25),
              darkColor: Color.fromRGBO(0, 167, 220, 0.25)),
          const CupertinoDynamicColor.withBrightness(
              color: Color.fromRGBO(0, 24, 152, 0.4),
              darkColor: Color.fromRGBO(0, 167, 220, 0.4)),
          const CupertinoDynamicColor.withBrightness(
              color: Color.fromRGBO(0, 24, 152, 0.55),
              darkColor: Color.fromRGBO(0, 167, 220, 0.55)),
          const CupertinoDynamicColor.withBrightness(
              color: Color.fromRGBO(0, 24, 152, 0.7),
              darkColor: Color.fromRGBO(0, 167, 220, 0.7)),
          const CupertinoDynamicColor.withBrightness(
              color: Color.fromRGBO(0, 24, 152, 0.85),
              darkColor: Color.fromRGBO(0, 167, 220, 0.85)),
          const CupertinoDynamicColor.withBrightness(
              color: Color.fromRGBO(0, 24, 152, 1),
              darkColor: Color.fromRGBO(0, 167, 220, 1)),
          const CupertinoDynamicColor.withBrightness(
              color: Color.fromRGBO(0, 24, 152, 0.1),
              darkColor: Color.fromRGBO(0, 167, 220, 0.1))
        ];
}
