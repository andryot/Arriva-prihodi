part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final bool isDarkMode;
  final bool isAutomaticScroll;

  const SettingsState(
      {required this.isDarkMode, required this.isAutomaticScroll});

  SettingsState copyWith({
    bool? isDarkMode,
    bool? isAutomaticScroll,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isAutomaticScroll: isAutomaticScroll ?? this.isAutomaticScroll,
    );
  }
}
