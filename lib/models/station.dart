class Station {
  final String name;
  final int code;

  Station({
    required this.name,
    required this.code,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      name: json['POS_NAZ'] as String,
      code: json['JPOS_IJPP'] as int,
    );
  }
}
