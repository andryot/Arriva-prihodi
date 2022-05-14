import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bus_time_table/bloc/global/global_bloc.dart';
import 'package:bus_time_table/models/ride.dart';
import 'package:bus_time_table/services/http_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../config/config.dart';
import '../server/routes.dart';
import '../util/either.dart';
import '../util/failure.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class BackendService {
  final GlobalBloc _globalBloc;
  final HttpService _httpService;
  static BackendService? _instance;
  static BackendService get instance => _instance!;

  const BackendService._(
      {required GlobalBloc globalBloc, required HttpService httpService})
      : _httpService = httpService,
        _globalBloc = globalBloc;

  factory BackendService({
    required GlobalBloc globalBloc,
    required HttpService httpService,
  }) {
    if (_instance != null) {
      throw StateError('BackendService already created');
    }

    _instance = BackendService._(
      globalBloc: globalBloc,
      httpService: httpService,
    );
    return _instance!;
  }

  Future<Either<Failure, List<Ride>>> getTimetable(
      String from, String destination, DateTime date) async {
    final String fromParsed = from.replaceAll(" ", '+');
    final String destinationParsed = destination.replaceAll(" ", '+');
    final String dateParsed = DateFormat('dd.MM.yyy').format(date);

    final Random rng = Random();
    final int randomNumber = 1000 + rng.nextInt(8999);

    final http.Response? response = await _httpService.get(
      [
        APServerRoute.timetable,
      ],
      queryParameters: <String, dynamic>{
        APServerRoute.queryParamDepartureRandomId + randomNumber.toString():
            from,
        APServerRoute.queryParamDepartureId:
            _globalBloc.state.stationId[fromParsed].toString(),
        APServerRoute.queryParamDeparture: from,
        APServerRoute.queryParamDestination: destination,
        APServerRoute.queryParamdestinationId:
            _globalBloc.state.stationId[destinationParsed].toString(),
        APServerRoute.queryParamDate: dateParsed,
      },
    );

    if (response == null) return error(const Failure());

    final dom.Document document = parser.parse(response.body);

    final List<String> startTimeList = [];
    final List<String> endTimeList = [];
    final List<String> travelTimeList = [];
    final List<String> busCompanyList = [];
    final List<String> kilometersList = [];
    final List<String> priceList = [];
    final List<String> laneList = [];

    document.getElementsByClassName('departure').forEach((dom.Element element) {
      startTimeList.add(element.getElementsByTagName('span').first.text);
    });

    document.getElementsByClassName('arrival').forEach((dom.Element element) {
      endTimeList.add(element.getElementsByTagName('span').first.text);
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

    // TODO kva je to???
    if (laneList.length == 1)
      for (int i = 0; i < endTimeList.length; i++) laneList.add("/");
    final List<Ride> rideList = [];
    for (int i = 0; i < endTimeList.length; i++) {
      rideList.add(
        Ride(
          from: from,
          destination: destination,
          duration: travelTimeList[i],
          startTime: startTimeList[i],
          endTime: endTimeList[i],
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
