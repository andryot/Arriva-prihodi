import 'query_parameters.dart';
import 'route_stop.dart';

class Ride {
  final String from;
  final String destination;
  final String? startTime;
  final String? endTime;

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
    this.startTime,
    this.endTime,
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

  Ride.fromJson(Map<String, dynamic> json)
      : from = json[RideJsonKey.from].toString(),
        destination = json[RideJsonKey.destination],
        startTime = json[RideJsonKey.startTime],
        endTime = json[RideJsonKey.endTime],
        busCompany = json[RideJsonKey.busCompany],
        price = json[RideJsonKey.price],
        distance = json[RideJsonKey.distance],
        lane = json[RideJsonKey.lane],
        duration = json[RideJsonKey.duration],
        routeStops = json[RideJsonKey.routeStops] == null
            ? null
            : (json[RideJsonKey.routeStops])
                .map<RouteStop>((e) => RouteStop.fromJson(e))
                .toList(),
        queryParameters = json[RideJsonKey.queryParameters] == null
            ? null
            : QueryParameters.fromJson(json[RideJsonKey.queryParameters]);

  Map<String, Object?> toJson() {
    return <String, Object?>{
      RideJsonKey.from: from.toString(),
      RideJsonKey.destination: destination.toString(),
      if (startTime != null) RideJsonKey.startTime: startTime.toString(),
      if (endTime != null) RideJsonKey.endTime: endTime.toString(),
      if (busCompany != null) RideJsonKey.busCompany: busCompany.toString(),
      if (price != null) RideJsonKey.price: price.toString(),
      if (distance != null) RideJsonKey.distance: distance.toString(),
      if (lane != null) RideJsonKey.lane: lane.toString(),
      if (duration != null) RideJsonKey.duration: duration.toString(),
    };
  }

  @override
  bool operator ==(Object other) {
    return other is Ride &&
        from == other.from &&
        destination == other.destination;
  }

  @override
  int get hashCode => (from + destination).hashCode;
}

abstract class RideJsonKey {
  static const String from = 'from';
  static const String destination = 'destination';
  static const String startTime = 'startTime';
  static const String endTime = 'endTime';
  static const String busCompany = 'busCompany';
  static const String price = 'price';
  static const String distance = 'distance';
  static const String lane = 'lane';
  static const String duration = 'duration';
  static const String routeStops = 'routeStops';
  static const String queryParameters = 'queryParameters';
}
