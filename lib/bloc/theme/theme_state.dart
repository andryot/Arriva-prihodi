part of 'theme_cubit.dart';

@immutable
class ThemeState {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  const ThemeState.initial() : themeMode = ThemeMode.dark;

  ThemeState copyWith({ThemeMode? themeMode}) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
