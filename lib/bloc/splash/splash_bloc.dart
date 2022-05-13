import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../router/routes.dart';
import '../../services/local_storage_service.dart';
import '../../style/theme.dart';
import '../global/global_bloc.dart';

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
        Future.delayed(const Duration(seconds: 1)),
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

    final String bytes = await rootBundle.loadString("assets/postaje.txt");

    final List array = [];
    final List<String> stations = [];
    final Map<String, int> stationId = HashMap();

    bytes.split("\n").forEach((ch) => array.add(ch.split(":")));
    array.removeLast();

    for (int i = 0; i < array.length; i++) {
      stationId[array[i][0]] = int.parse(array[i][1]);
      stations.add(array[i][0].toString().replaceAll("+", " "));
    }

    _globalBloc.updateStations(stations, stationId);

    /*if (prefs.containsKey("favorites"))
      favorites.addAll(prefs.getStringList("favorites")!.toList()); */
  }
}
