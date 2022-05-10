import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bus_time_table/bloc/global/global_bloc.dart';
import 'package:bus_time_table/services/local_storage_service.dart';
import 'package:meta/meta.dart';

import '../../config.dart';

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
    _localStorageService.setThemeData(currentTheme.themeData);
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
    _globalBloc.switchTheme();
  }
}
