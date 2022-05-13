import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bus_time_table/util/parser.dart';
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

  // Public API
  void dateSelected(DateTime selectedDate) {
    add(_DateChangedEvent(selectedDate));
  }
}
