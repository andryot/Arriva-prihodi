import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../services/local_storage_service.dart';
import '../../style/theme.dart';
import '../global/global_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final LocalStorageService _localStorageService;
  final GlobalBloc _globalBloc;
  SettingsBloc({
    required LocalStorageService localStorageService,
    required GlobalBloc globalBloc,
  })  : _localStorageService = localStorageService,
        _globalBloc = globalBloc,
        super(SettingsState(isDarkMode: globalBloc.isDarkMode)) {
    on<SwitchThemeEvent>(_onSwitchTheme);
  }

  FutureOr<void> _onSwitchTheme(
    SwitchThemeEvent event,
    Emitter<SettingsState> emit,
  ) {
    _globalBloc.switchTheme();
    _localStorageService
        .setThemeData(_globalBloc.isDarkMode ? apThemeDark : apThemeLight);
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
  }
}
