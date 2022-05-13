import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../models/ride.dart';
import '../../screens/timetable.dart';
import '../../util/either.dart';
import '../../util/failure.dart';
import '../global/global_bloc.dart';

part 'timetable_event.dart';
part 'timetable_state.dart';

class TimetableBloc extends Bloc<_TimetableEvent, TimetableState> {
  final TimetableScreenArgs args;
  final GlobalBloc _globalBloc;
  TimetableBloc({
    required this.args,
    required GlobalBloc globalBloc,
  })  : _globalBloc = globalBloc,
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

    final Either<Failure, List<Ride>> failureOrRideList = await fetchData();

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

  Future<Either<Failure, List<Ride>>> fetchData() async {
    final String from = state.from.replaceAll(" ", "+");
    final String destination = state.destination.replaceAll(" ", "+");
    final String date = DateFormat('dd.MM.yyy').format(state.date);

    final Random rng = Random();
    final int randomNumber = 1000 + rng.nextInt(8999);

    final String url = "https://arriva.si/en/timetable/?departure-" +
        randomNumber.toString() +
        from +
        "&departure_id=" +
        _globalBloc.state.stationId[from].toString() +
        "&departure=" +
        from +
        "&destination=" +
        destination +
        "&destination_id=" +
        _globalBloc.state.stationId[destination].toString() +
        "&trip_date=" +
        date;

    final http.Response response;
    try {
      response = await http
          .get(Uri(host: url))
          .timeout(Duration(seconds: 15), onTimeout: () => throw Exception());
    } catch (e) {
      return error(const Failure());
    }

    dom.Document document = parser.parse(response.body);

    final List<String> fromList = [];
    final List<String> destinationList = [];
    final List<String> travelTimeList = [];
    final List<String> busCompanyList = [];
    final List<String> kilometersList = [];
    final List<String> priceList = [];
    final List<String> laneList = [];

    document.getElementsByClassName('departure').forEach((dom.Element element) {
      fromList.add(element.getElementsByTagName('span').first.text);
    });

    document.getElementsByClassName('arrival').forEach((dom.Element element) {
      destinationList.add(element.getElementsByTagName('span').first.text);
    });

    document
        .getElementsByClassName('travel-duration')
        .forEach((dom.Element element) {
      travelTimeList.add(element.getElementsByTagName('span').first.text);
    });

    document.getElementsByClassName('prevoznik').forEach((dom.Element element) {
      busCompanyList.add(element.getElementsByTagName('span').last.text);
    });

    document.getElementsByClassName('length').forEach((dom.Element element) {
      kilometersList.add(element.text);
    });
    if (kilometersList.length > 0) kilometersList.removeAt(0);

    priceList.clear();
    document.getElementsByClassName('price').forEach((dom.Element element) {
      priceList.add(element.text.replaceAll("EUR", "€").replaceAll(".", ","));
    });

    if (priceList.length > 0) priceList.removeAt(0);

    int counter = 0;

    document.getElementsByClassName('duration').forEach((dom.Element element) {
      element.getElementsByClassName('peron').forEach((dom.Element element2) {
        laneList.add(element2.getElementsByTagName("span").last.text);
      });

      if (laneList.length == counter && counter != 2) laneList.add("/");

      counter++;
    });

    if (laneList.length > 0) laneList.removeAt(0);

    if (laneList.length == 1)
      for (int i = 0; i < fromList.length; i++) laneList.add("/");
    final List<Ride> rideList = [];
    for (int i = 0; i < rideList.length; i++) {
      rideList.add(
        Ride(
          from: fromList[i],
          destination: destinationList[i],
          time: travelTimeList[i],
          busCompany: busCompanyList[i],
          price: priceList[i],
          kilometers: kilometersList[i],
          lane: laneList[i],
        ),
      );
    }

    return value(rideList);
  }
}
