import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../bloc/global/global_bloc.dart';
import '../models/query_parameters.dart';
import '../models/ride.dart';
import '../models/route_stop.dart';
import '../server/routes.dart';
import '../util/either.dart';
import '../util/failure.dart';
import 'http_service.dart';

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
    String from,
    String destination,
    DateTime date,
  ) async {
    final String fromParsed = from.replaceAll(" ", '+');
    final String destinationParsed = destination.replaceAll(" ", '+');
    final String dateParsed = DateFormat('dd.MM.yyy').format(date);

    final Random rng = Random();
    final int randomNumber = 1000 + rng.nextInt(8999);

    final http.Response? response = await _httpService.get(
      [APServerRoute.timetable],
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

    if (response == null) {
      return error(const BackendFailure());
    } else if (response.statusCode == HttpStatus.requestTimeout) {
      return error(const ArrivaApiFailure());
    }

    final dom.Document document = parser.parse(response.body);

    final List<String> startTimeList = [];
    final List<String> endTimeList = [];
    final List<String> travelTimeList = [];
    final List<String> busCompanyList = [];
    final List<String> distanceList = [];
    final List<String> priceList = [];
    final List<String> laneList = [];
    final List<QueryParameters?> queryParametersList = [];

    document.getElementsByClassName('departure').forEach((dom.Element element) {
      startTimeList.add(element.getElementsByTagName('span').first.text);
    });

    document.getElementsByClassName('duration').forEach((dom.Element element) {
      if (element.children.isNotEmpty) {
        element
            .getElementsByClassName('travel-duration')
            .forEach((dom.Element element2) {
          travelTimeList.add(element2.getElementsByTagName('span').first.text);
        });
        element
            .getElementsByClassName('prevoznik')
            .forEach((dom.Element element2) {
          busCompanyList.add(element2.getElementsByTagName('span').last.text);
        });

        final List<dom.Element> elements =
            element.getElementsByClassName('peron');

        if (elements.isEmpty) {
          laneList.add("/");
        } else {
          laneList.add(elements[0].getElementsByTagName("span")[1].innerHtml);
        }
      }
    });

    document.getElementsByClassName('arrival').forEach((dom.Element element) {
      endTimeList.add(element.getElementsByTagName('span').first.text);
    });

    document
        .getElementsByClassName('collapse display-path')
        .forEach((dom.Element element) {
      if (element.attributes['data-args'] == null) {
        queryParametersList.add(null);
      } else {
        queryParametersList.add(
          QueryParameters.fromJson(json.decode(
            element.attributes['data-args']!,
          )),
        );
      }
    });

    document.getElementsByClassName('length').forEach((dom.Element element) {
      distanceList.add(element.text);
    });

    // REMOVE "Kilometri"
    if (distanceList.isNotEmpty) distanceList.removeAt(0);

    document.getElementsByClassName('price').forEach((dom.Element element) {
      priceList.add(element.text.replaceAll("EUR", "€").replaceAll(".", ","));
    });
    // REMOVE "Cena"
    if (priceList.isNotEmpty) priceList.removeAt(0);

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
          distance: distanceList[i],
          lane: laneList[i],
          queryParameters: queryParametersList[i],
        ),
      );
    }

    return value(rideList);
  }

  Future<Either<Failure, List<RouteStop>>> getRouteStops(
    QueryParameters parameters,
  ) async {
    final http.Response? response = await _httpService.get(
      [
        APServerRoute.wpAdmin,
        APServerRoute.adminAjax,
      ],
      queryParameters: parameters.toJson(),
    );

    if (response == null) return error(const BackendFailure());

    final dom.Document document = parser.parse(response.body);

    final List<RouteStop> routeStopList = [];

    final List<dom.Element> elementList = document.getElementsByTagName('span');
    final List<dom.Element> filteredElementList = [];

    for (int i = 0; i < elementList.length; i++) {
      if (elementList[i].innerHtml.isNotEmpty) {
        filteredElementList.add(elementList[i]);
      }
    }

    for (int i = 0; i < filteredElementList.length; i += 2) {
      routeStopList.add(RouteStop(
          time: filteredElementList[i].innerHtml,
          station: filteredElementList[i + 1].innerHtml));
    }

    return value(routeStopList);
  }
}
