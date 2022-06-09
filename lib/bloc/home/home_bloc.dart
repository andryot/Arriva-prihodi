import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../models/ride.dart';
import '../../router/routes.dart';
import '../../screens/timetable.dart';
import '../../util/parser.dart';
import '../global/global_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<_HomeEvent, HomeState> {
  final GlobalBloc _globalBloc;

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  late final StreamSubscription _favoritesSubscription;

  final SuggestionsBoxController _fromSuggestionsBoxController =
      SuggestionsBoxController();

  final SuggestionsBoxController _destinationSuggestionsBoxController =
      SuggestionsBoxController();

  final FocusNode _fromFocusNode = FocusNode();
  final FocusNode _destinationFocusNode = FocusNode();

  get dateController => _dateController;
  get fromController => _fromController;
  get destinationController => _destinationController;

  get fromSuggestionsBoxController => _fromSuggestionsBoxController;
  get destinationSuggestionsBoxController =>
      _destinationSuggestionsBoxController;

  get fromFocusNode => _fromFocusNode;
  get destinationFocusNode => _destinationFocusNode;

  HomeBloc({required GlobalBloc globalBloc})
      : _globalBloc = globalBloc,
        super(HomeState.initial(globalBloc.state.favorites)) {
    _dateController.text = APParser.dateToString(state.selectedDate);

    _favoritesSubscription = _globalBloc.globalFavoritesStream.listen(
      (_) => add(const _UpdateFavorites()),
    );
    if (_globalBloc.state.isSaveLastSearch) {
      if (_globalBloc.state.lastFrom != null) {
        _fromController.text = _globalBloc.state.lastFrom!;
      }
      if (_globalBloc.state.lastTo != null) {
        _destinationController.text = _globalBloc.state.lastTo!;
      }
    }
    on<_DateChangedEvent>(_dateChanged);
    on<_SwapEvent>(_swap);
    on<_SearchEvent>(_search);
    on<_UpdateFavorites>(_updateFavorites);
    on<_RemoveFavoriteEvent>(_removeFavorite);
    on<_ReorderFavoritesEvent>(_reorderFavorites);
    on<_FromChangedEvent>(_fromChanged);
    on<_DestinationChangedEvent>(_destinationChanged);

    _fromController.addListener(() => add(const _FromChangedEvent()));
    _destinationController
        .addListener(() => add(const _DestinationChangedEvent()));
  }

  @override
  Future<void> close() async {
    await _favoritesSubscription.cancel();
    return super.close();
  }

  // HANDLERS
  FutureOr<void> _dateChanged(
      _DateChangedEvent event, Emitter<HomeState> emit) async {
    emit(
      state.copyWith(
        selectedDate: event.date,
      ),
    );
    _dateController.text = APParser.dateToString(state.selectedDate);
  }

  FutureOr<void> _swap(_SwapEvent event, Emitter<HomeState> emit) {
    final String from = _fromController.text;
    final String destination = _destinationController.text;

    _fromController.text = destination;
    _destinationController.text = from;
    if (_fromController.text != "" || _destinationController.text != "") {
      emit(state.copyWith(turns: state.turns + 0.5));
    }
  }

  FutureOr<void> _search(_SearchEvent event, Emitter<HomeState> emit) {
    final String? from = _globalBloc.validateStation(_fromController.text);
    final String? destination =
        _globalBloc.validateStation(_destinationController.text);
    if (from == null) {
      emit(state.copyWith(isFromError: true));
    } else {
      _fromController.text = from;
    }
    if (destination == null) {
      emit(state.copyWith(isDestinationError: true));
    } else {
      _destinationController.text = destination;
    }

    if (state.isFromError || state.isDestinationError) return null;
    _globalBloc.setLastSearch(from, destination);
    Navigator.pushNamed(
      event.context,
      APRoute.timetable,
      arguments: TimetableScreenArgs(
        from: _fromController.text,
        destination: _destinationController.text,
        date: state.selectedDate,
      ),
    );
  }

  // Public API
  void dateSelected(DateTime selectedDate) =>
      add(_DateChangedEvent(selectedDate));

  void swap() => add(const _SwapEvent());

  void search(context) => add(_SearchEvent(context));

  void removeFavorite(Ride ride) => add(_RemoveFavoriteEvent(ride));
  void reorderFavoriteRides(int oldIndex, int newIndex) =>
      add(_ReorderFavoritesEvent(oldIndex, newIndex));

  FutureOr<void> _updateFavorites(
      _UpdateFavorites event, Emitter<HomeState> emit) {
    emit(state.copyWith(favoriteRides: _globalBloc.state.favorites));
  }

  FutureOr<void> _removeFavorite(
      _RemoveFavoriteEvent event, Emitter<HomeState> emit) {
    _globalBloc.removeFavorite(event.ride);
  }

  FutureOr<void> _reorderFavorites(
      _ReorderFavoritesEvent event, Emitter<HomeState> emit) {
    _globalBloc.reorderFavorites(event.oldIndex, event.newIndex);
  }

  FutureOr<void> _fromChanged(
      _FromChangedEvent event, Emitter<HomeState> emit) {
    if (state.isFromError) emit(state.copyWith(isFromError: false));
  }

  FutureOr<void> _destinationChanged(
      _DestinationChangedEvent event, Emitter<HomeState> emit) {
    if (state.isDestinationError) {
      emit(state.copyWith(isDestinationError: false));
    }
  }
}
