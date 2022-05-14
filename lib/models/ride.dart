class Ride {
  final String from;
  final String destination;
  final String startTime;
  final String endTime;

  final String? busCompany;
  final String? price;
  final String? kilometers;
  final String? lane;
  final String? duration;

  const Ride({
    required this.from,
    required this.destination,
    required this.startTime,
    required this.endTime,
    this.busCompany,
    this.price,
    this.kilometers,
    this.lane,
    this.duration,
  });
}
