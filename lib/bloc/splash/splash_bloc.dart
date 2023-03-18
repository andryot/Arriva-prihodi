import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../models/station.dart';
import '../../router/routes.dart';
import '../../services/backend_service.dart';
import '../../services/local_storage_service.dart';
import '../../style/theme.dart';
import '../../util/either.dart';
import '../../util/failure.dart';
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
        super(const SplashState.initial()) {
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
    final bool isDarkMode = _localStorageService.getThemeData() == apThemeDark;
    _globalBloc.setIsDarkMode(isDarkMode);

    late final List<Station> stations;

    final Either<Failure, List<Station>> stationsOrFailure =
        await BackendService.instance.getStations();

    if (!stationsOrFailure.isError()) {
      stations = stationsOrFailure.value;
    } else {
      final List array = [];
      final String bytes = await rootBundle.loadString("assets/postaje.txt");

      stations = [];

      bytes.split("\n").forEach((ch) => array.add(ch.split(":")));
      array.removeLast();

      for (int i = 0; i < array.length; i++) {
        stations.add(
          Station(
            name: array[i][0].toString().replaceAll("+", " "),
            code: int.parse(array[i][1]),
          ),
        );
      }
    }

    final bool? automaticScroll = _localStorageService.getAutomaticScroll();
    final bool? saveLastSearch = _localStorageService.getSaveLastSearch();

    if (saveLastSearch == null) {
      _localStorageService.setSaveLastSearch(true);
      _globalBloc.setSaveLastSearch(true);
    } else {
      _globalBloc.setSaveLastSearch(saveLastSearch);
    }

    _globalBloc.setAutomaticScroll(automaticScroll);

    _globalBloc.updateStations(stations);
    // This is to not break old favorites added prior to BLoC rewrite
    // It should be false only the first time after update

    _globalBloc.getOldFavorites();
    _globalBloc.loadLastSearch();

    if (_globalBloc.state.favorites == null) {
      _globalBloc.getFavorites();
    }
  }
}
