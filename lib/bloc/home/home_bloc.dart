import 'dart:async';

import 'package:bloc/bloc.dart';
import '../../util/parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<_HomeEvent, HomeState> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

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

  HomeBloc() : super(HomeState.initial()) {
    _dateController.text = APParser.dateToString(state.selectedDate);

    on<_DateChangedEvent>(_dateChanged);
    on<_SwapEvent>(_swap);
    on<_SearchEvent>(_search);
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
  }

  FutureOr<void> _search(_SearchEvent event, Emitter<HomeState> emit) {}

  // Public API
  void dateSelected(DateTime selectedDate) =>
      add(_DateChangedEvent(selectedDate));

  void swap() => add(_SwapEvent());

  void search() => add(_SearchEvent());
}
