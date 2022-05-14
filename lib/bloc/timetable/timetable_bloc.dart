import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bus_time_table/config/config.dart';
import 'package:bus_time_table/server/routes.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../models/ride.dart';
import '../../screens/timetable.dart';
import '../../services/backend_service.dart';
import '../../util/either.dart';
import '../../util/failure.dart';
import '../global/global_bloc.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<_TimetableEvent, TimetableState> {
  final TimetableScreenArgs args;
  final GlobalBloc _globalBloc;
  final BackendService _backendService;
  TimetableBloc({
    required this.args,
    required GlobalBloc globalBloc,
    required BackendService backendService,
  })  : _globalBloc = globalBloc,
        _backendService = backendService,
        super(TimetableState.initial(
          from: args.from,
          destination: args.destination,
          date: args.date,
        )) {
    on<_InitializeEvent>(_initialize);

    add(_InitializeEvent());
  }

  FutureOr<void> _initialize(
      _InitializeEvent event, Emitter<TimetableState> emit) async {
    emit(state.copyWith(isLoading: true));

    final Either<Failure, List<Ride>> failureOrRideList = await _backendService
        .getTimetable(args.from, args.destination, state.date);

    if (failureOrRideList.isError()) {
      emit(state.copyWith(
        isLoading: false,
        failure: failureOrRideList.error,
        initialized: false,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: false,
      initialized: true,
      rideList: failureOrRideList.value,
    ));
  }
}
