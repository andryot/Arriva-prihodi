import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
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
  SplashBloc() : super(SplashState.initial()) {
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
    await Future.delayed(const Duration(seconds: 2));

    emit(state.copyWith(
      initialized: true,
      pushRoute: APRoute.home,
    ));
  }
}
