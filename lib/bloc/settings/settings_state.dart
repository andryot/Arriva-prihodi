part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final bool isDarkMode;

  const SettingsState({required this.isDarkMode});

  SettingsState copyWith({bool? isDarkMode}) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
