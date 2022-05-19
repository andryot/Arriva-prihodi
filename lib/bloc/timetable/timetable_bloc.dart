import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    on<_ChangeDateEvent>(_changeDate);
    on<_CalculateScrolltEvent>(_calculateScroll);

    add(const _InitializeEvent());
  }

  // PUBLIC API

  void showDetailsPanel(int index) => add(_ShowDetailsEvent(index));
  void favorite() => add(const _FavoriteEvent());
  void changeDate(DateTime date) => add(_ChangeDateEvent(date: date));
  void retryLoadingStations() => add(_ShowDetailsEvent(state.index!));
  void calculateScroll() => add(const _CalculateScrolltEvent());
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
        failure: const InitialFailure(),
        initialized: false,
      ));
      return;
    }
    if (failureOrRideList.value.isEmpty) {
      emit(state.copyWith(
        initialized: true,
        failure: const NoRidesFailure(),
        isLoading: false,
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: false,
      initialized: true,
      rideList: failureOrRideList.value,
      timeTableInitialized: true,
    ));
  }

  FutureOr<void> _showDetails(
    _ShowDetailsEvent event,
    Emitter<TimetableState> emit,
  ) async {
    // TODO handle failure
    if (state.rideList == null || state.rideList!.length <= event.index) return;
    emit(
      state.copyWith(
        selectedRide: state.rideList![event.index],
        index: event.index,
      ),
    );

    panelController.open();
    if (state.selectedRide!.routeStops != null) return;

    final Either<Failure, List<RouteStop>> failureOrRideStops =
        await _backendService
            .getRouteStops(state.rideList![event.index].queryParameters!);

    if (failureOrRideStops.isError()) {
      emit(state.copyWith(failure: const LoadStationsFailure()));
      return;
    }

    if (failureOrRideStops.hasValue()) {
      state.rideList![event.index] = state.rideList![event.index].copyWith(
        routeStops: failureOrRideStops.value,
      );
      emit(state.copyWith(
        selectedRide: state.rideList![event.index],
      ));
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

  FutureOr<void> _changeDate(
      _ChangeDateEvent event, Emitter<TimetableState> emit) async {
    final DateTime oldDate = state.date;
    emit(state.copyWith(
      timeTableLoading: true,
      date: event.date,
    ));

    final Either<Failure, List<Ride>> failureOrRideList =
        await _backendService.getTimetable(
      args.from,
      args.destination,
      event.date,
    );

    if (failureOrRideList.isError()) {
      emit(state.copyWith(
        failure: const RefreshFailure(),
        timeTableLoading: false,
        date: oldDate,
      ));
      return;
    }

    emit(state.copyWith(
      rideList: failureOrRideList.value,
      timeTableLoading: false,
      timeTableInitialized: true,
    ));
  }

  FutureOr<void> _calculateScroll(
      _CalculateScrolltEvent event, Emitter<TimetableState> emit) {
    final DateTime today = DateTime.now();
    if (state.isFirst != true ||
        state.rideList == null ||
        state.date
                .difference(DateTime(today.year, today.month, today.day))
                .inDays !=
            0) return null;
    emit(state.copyWith(isFirst: false));
    double scrollPosition = 0;
    //final double maxExtent = max(12 * event.size.height / 50, 200);
    final double listTileHeight = state.globalKey.currentContext!.size!.height;
    const double space = 30.0 + 10.0;

    for (Ride ride in state.rideList!) {
      scrollPosition += listTileHeight;
    }
    scrollPosition += space;
    scrollController.animateTo(
      scrollPosition,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOut,
    );
  }
}
