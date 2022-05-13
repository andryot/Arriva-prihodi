class Ride {
  final String from;
  final String destination;
  final String time;
  final String? busCompany;
  final String? price;
  final String? kilometers;
  final String? lane;

  const Ride({
    required this.from,
    required this.destination,
    required this.time,
    this.busCompany,
    this.price,
    this.kilometers,
    this.lane,
  });
}
