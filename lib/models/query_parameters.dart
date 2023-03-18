class QueryParameters {
  static String action = 'get_DepartureStationList';
  final String spodSif;
  final String regIsif;
  final String rprSif;
  final String rprNaz;
  final String ovrSif;
  final String rodIodh;
  final String rodIpri;
  final String rodCas;
  final String rodPer;
  final String rodKm;
  final String rodOpo;
  final String vzclCen;
  final String vvlnZl;
  final String rodZapz;
  final String rodZapk;

  /// Constructs new `QueryParameters` object.
  const QueryParameters({
    required this.spodSif,
    required this.regIsif,
    required this.rprSif,
    required this.rprNaz,
    required this.ovrSif,
    required this.rodIodh,
    required this.rodIpri,
    required this.rodCas,
    required this.rodPer,
    required this.rodKm,
    required this.rodOpo,
    required this.vzclCen,
    required this.vvlnZl,
    required this.rodZapz,
    required this.rodZapk,
  });

  QueryParameters.fromJson(Map<String, dynamic> json)
      : spodSif = json[QueryParametersJsonKey.spodSif].toString(),
        regIsif = json[QueryParametersJsonKey.regIsif].toString(),
        rprSif = json[QueryParametersJsonKey.rprSif].toString(),
        rprNaz = json[QueryParametersJsonKey.rprNaz].toString(),
        ovrSif = json[QueryParametersJsonKey.ovrSif].toString(),
        rodIodh = json[QueryParametersJsonKey.rodIodh].toString(),
        rodIpri = json[QueryParametersJsonKey.rodIpri].toString(),
        rodCas = json[QueryParametersJsonKey.rodCas].toString(),
        rodPer = json[QueryParametersJsonKey.rodPer].toString(),
        rodKm = json[QueryParametersJsonKey.rodKm].toString(),
        rodOpo = json[QueryParametersJsonKey.rodOpo].toString(),
        vzclCen = json[QueryParametersJsonKey.vzclCen].toString(),
        vvlnZl = json[QueryParametersJsonKey.vvlnZl].toString(),
        rodZapz = json[QueryParametersJsonKey.rodZapz].toString(),
        rodZapk = json[QueryParametersJsonKey.rodZapk].toString();

  /// Converts this object into json representation.

  Map<String, Object?> toJson() {
    return <String, Object?>{
      QueryParametersJsonKey.action: action.toString(),
      QueryParametersJsonKey.spodSif: spodSif.toString(),
      QueryParametersJsonKey.regIsif: regIsif.toString(),
      QueryParametersJsonKey.rprSif: rprSif.toString(),
      QueryParametersJsonKey.rprNaz: rprNaz.toString(),
      QueryParametersJsonKey.ovrSif: ovrSif.toString(),
      QueryParametersJsonKey.rodIodh: rodIodh.toString(),
      QueryParametersJsonKey.rodIpri: rodIpri.toString(),
      QueryParametersJsonKey.rodCas: rodCas.toString(),
      QueryParametersJsonKey.rodPer: rodPer.toString(),
      QueryParametersJsonKey.rodKm: rodKm.toString(),
      QueryParametersJsonKey.rodOpo: rodOpo.toString(),
      QueryParametersJsonKey.vzclCen: vzclCen.toString(),
      QueryParametersJsonKey.vvlnZl: vvlnZl.toString(),
      QueryParametersJsonKey.rodZapz: rodZapz.toString(),
      QueryParametersJsonKey.rodZapk: rodZapk.toString(),
    };
  }

  /// Returns new instance of `QueryParameters` with modified fields.
  QueryParameters copyWith({
    String? spodSif,
    String? regIsif,
    String? rprSif,
    String? rprNaz,
    String? ovrSif,
    String? rodIodh,
    String? rodIpri,
    String? rodCas,
    String? rodPer,
    String? rodKm,
    String? rodOpo,
    String? vzclCen,
    String? vvlnZl,
    String? rodZapz,
    String? rodZapk,
  }) {
    return QueryParameters(
      spodSif: spodSif ?? this.spodSif,
      regIsif: regIsif ?? this.regIsif,
      rprSif: rprSif ?? this.rprSif,
      rprNaz: rprNaz ?? this.rprNaz,
      ovrSif: ovrSif ?? this.ovrSif,
      rodIodh: rodIodh ?? this.rodIodh,
      rodIpri: rodIpri ?? this.rodIpri,
      rodCas: rodCas ?? this.rodCas,
      rodPer: rodPer ?? this.rodPer,
      rodKm: rodKm ?? this.rodKm,
      rodOpo: rodOpo ?? this.rodOpo,
      vzclCen: vzclCen ?? this.vzclCen,
      vvlnZl: vvlnZl ?? this.vvlnZl,
      rodZapz: rodZapz ?? this.rodZapz,
      rodZapk: rodZapk ?? this.rodZapk,
    );
  }
}

/// Keys used in `QueryParameters` json representations.
abstract class QueryParametersJsonKey {
  static const String action = 'action';

  static const String spodSif = 'SPOD_SIF';
  static const String regIsif = 'REG_ISIF';
  static const String rprSif = 'RPR_SIF';
  static const String rprNaz = 'RPR_NAZ';
  static const String ovrSif = 'OVR_SIF';
  static const String rodIodh = 'ROD_IODH';
  static const String rodIpri = 'ROD_IPRI';
  static const String rodCas = 'ROD_CAS';
  static const String rodPer = 'ROD_PER';
  static const String rodKm = 'ROD_KM';
  static const String rodOpo = 'ROD_OPO';
  static const String vzclCen = 'VZCL_CEN';
  static const String vvlnZl = 'VVLN_ZL';
  static const String rodZapz = 'ROD_ZAPZ';
  static const String rodZapk = 'ROD_ZAPK';
}
