import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bus_time_table/bloc/global/global_bloc.dart';
import 'package:bus_time_table/config.dart';
import 'package:bus_time_table/services/local_storage_service.dart';
import 'package:bus_time_table/style/theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../router/routes.dart';

part 'splash_event.dart';
part 'splash_state.dart';

const double _maxLogoDeltaSize = 40.0;
const double _speed = 0.6;
const double _sinArgMultiplier = 2 * pi * _speed * 10 / 1000;

class SplashBloc extends Bloc<_SplashEvent, SplashState> {
  late final Timer _timer;
  final LocalStorageService _localStorageService;
  final GlobalBloc _globalBloc;
  SplashBloc(
      {required LocalStorageService localStorageService,
      required GlobalBloc globalBloc})
      : _localStorageService = localStorageService,
        _globalBloc = globalBloc,
        super(SplashState.initial()) {
    on<_Initialize>(_onInitialize);
    on<_TimerTick>(_onTimerTick);

    _timer = Timer.periodic(
      const Duration(milliseconds: 10),
      (_) => add(const _TimerTick()),
    );

    add(const _Initialize());
  }

  @override
  Future<void> close() async {
    _timer.cancel();
    return super.close();
  }

  FutureOr<void> _onTimerTick(
    _TimerTick event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(
      deltaLogoSize:
          _maxLogoDeltaSize * 0.5 * (2 + sin(_sinArgMultiplier * _timer.tick)),
    ));
  }

  FutureOr<void> _onInitialize(
    _Initialize event,
    Emitter<SplashState> emit,
  ) async {
    await Future.wait(
      <Future>[
        Future.delayed(const Duration(seconds: 2)),
        init(),
      ],
    );

    emit(state.copyWith(
      initialized: true,
      pushRoute: APRoute.home,
    ));
  }

  Future<void> init() async {
    _globalBloc.isDarkMode = _localStorageService.getThemeData() == apThemeDark;

    /* bytes = await rootBundle.loadString("assets/postaje.txt");
    array.clear();
    bytes.split("\n").forEach((ch) => array.add(ch.split(":")));
    array.removeLast();
    map.clear();
    predictions.clear();

    for (int i = 0; i < array.length; i++) {
      map[array[i][0]] = int.parse(array[i][1]);
      predictions.add(array[i][0].toString().replaceAll("+", " "));
    }

    if (prefs.containsKey("favorites"))
      favorites.addAll(prefs.getStringList("favorites")!.toList()); */
  }
}
