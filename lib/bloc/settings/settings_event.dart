part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {
  const SettingsEvent();
}

class SwitchThemeEvent extends SettingsEvent {}

class SwitchAutomaticScrollEvent extends SettingsEvent {
  final bool isAutomaticScroll;
  const SwitchAutomaticScrollEvent({required this.isAutomaticScroll});
}

class SwitchSaveLastSearchEvent extends SettingsEvent {
  final bool isSaveLastSearch;
  const SwitchSaveLastSearchEvent({required this.isSaveLastSearch});
}
