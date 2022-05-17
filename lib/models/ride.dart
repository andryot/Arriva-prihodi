import 'query_parameters.dart';
import 'route_stop.dart';

class Ride {
  final String from;
  final String destination;
  final String startTime;
  final String endTime;

  final String? busCompany;
  final String? price;
  final String? distance;
  final String? lane;
  final String? duration;

  final QueryParameters? queryParameters;

  final List<RouteStop>? routeStops;

  const Ride({
    required this.from,
    required this.destination,
    required this.startTime,
    required this.endTime,
    this.queryParameters,
    this.busCompany,
    this.price,
    this.distance,
    this.lane,
    this.duration,
    this.routeStops,
  });

  Ride copyWith({
    String? from,
    String? destination,
    String? startTime,
    String? endTime,
    String? busCompany,
    String? price,
    String? distance,
    String? lane,
    String? duration,
    List<RouteStop>? routeStops,
    QueryParameters? queryParameters,
  }) {
    return Ride(
      from: from ?? this.from,
      destination: destination ?? this.destination,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      busCompany: busCompany ?? this.busCompany,
      price: price ?? this.price,
      distance: distance ?? this.distance,
      lane: lane ?? this.lane,
      duration: duration ?? this.duration,
      routeStops: routeStops ?? this.routeStops,
      queryParameters: queryParameters ?? this.queryParameters,
    );
  }
}
