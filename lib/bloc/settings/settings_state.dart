part of 'settings_bloc.dart';

@immutable
class SettingsState {
  final bool isDarkMode;
  final bool isAutomaticScroll;

  final bool isSaveLastSearch;

  const SettingsState({
    required this.isDarkMode,
    required this.isAutomaticScroll,
    required this.isSaveLastSearch,
  });

  SettingsState copyWith({
    bool? isDarkMode,
    bool? isAutomaticScroll,
    bool? isSaveLastSearch,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isAutomaticScroll: isAutomaticScroll ?? this.isAutomaticScroll,
      isSaveLastSearch: isSaveLastSearch ?? this.isSaveLastSearch,
    );
  }
}
