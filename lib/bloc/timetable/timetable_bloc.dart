import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../models/ride.dart';
import '../../models/route_stop.dart';
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
  final PanelController panelController = PanelController();
  final ScrollController scrollController = ScrollController();
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
    on<_ShowDetailsEvent>(_showDetails);
    on<_FavoriteEvent>(_favorite);

    add(const _InitializeEvent());
  }

  // PUBLIC API

  void showDetailsPanel(int index) => add(_ShowDetailsEvent(index));
  void favorite() => add(const _FavoriteEvent());
  // HANDLERS

  FutureOr<void> _initialize(
      _InitializeEvent event, Emitter<TimetableState> emit) async {
    final Ride tmpRide = Ride(
      from: args.from,
      destination: args.destination,
    );
    emit(state.copyWith(
      isLoading: true,
      selectedRide: tmpRide,
      isFavorite: _globalBloc.isFavorite(tmpRide),
    ));

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

  FutureOr<void> _showDetails(
    _ShowDetailsEvent event,
    Emitter<TimetableState> emit,
  ) async {
    // TODO handle failure
    if (state.rideList == null || state.rideList!.length <= event.index) return;
    emit(state.copyWith(selectedRide: state.rideList![event.index]));

    panelController.open();
    if (state.selectedRide!.routeStops != null) return;

    final Either<Failure, List<RouteStop>> failureOrRideStops =
        await _backendService
            .getRouteStops(state.rideList![event.index].queryParameters!);

    if (failureOrRideStops.hasValue()) {
      state.rideList![event.index] = state.rideList![event.index].copyWith(
        routeStops: failureOrRideStops.value,
      );
      emit(state.copyWith(selectedRide: state.rideList![event.index]));
    }
  }

  FutureOr<void> _favorite(
      _FavoriteEvent event, Emitter<TimetableState> emit) async {
    emit(state.copyWith(
        isFavorite: state.isFavorite == null ? true : !state.isFavorite!));

    if (state.isFavorite == null) {
      return;
    } else if (state.isFavorite == true) {
      await _globalBloc.addFavorite(state.selectedRide);
    } else {
      await _globalBloc.removeFavorite(state.selectedRide);
    }
  }
}
