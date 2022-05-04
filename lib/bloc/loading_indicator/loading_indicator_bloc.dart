import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'loading_indicator_event.dart';
part 'loading_indicator_state.dart';

class LoadingIndicatorBloc
    extends Bloc<LoadingIndicatorEvent, LoadingIndicatorState> {
  LoadingIndicatorBloc() : super(LoadingIndicatorState.initial()) {
    _timer = Timer.periodic(
      const Duration(milliseconds: 250),
      (_) => add(const _TimerTick()),
    );

    on<_TimerTick>(_onTimerTick);
  }

  late final Timer _timer;

  @override
  Future<void> close() async {
    _timer.cancel();
    return super.close();
  }

  FutureOr<void> _onTimerTick(
    _TimerTick event,
    Emitter<LoadingIndicatorState> emit,
  ) async {
    final List<Color> colors = state.colors;
    final Color lastColor = colors.removeLast();
    colors.insert(0, lastColor);
    emit(LoadingIndicatorState(colors: colors));
  }
}
