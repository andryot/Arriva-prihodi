class RouteStop {
  final String time;
  final String station;
  const RouteStop({
    required this.time,
    required this.station,
  });

  RouteStop.fromJson(Map<String, dynamic> json)
      : time = json[RideJsonKey.time],
        station = json[RideJsonKey.station];

  Map<String, Object?> toJson() {
    return <String, Object?>{
      RideJsonKey.time: time,
      RideJsonKey.station: station,
    };
  }
}

abstract class RideJsonKey {
  static const String time = 'time';
  static const String station = 'station';
}
