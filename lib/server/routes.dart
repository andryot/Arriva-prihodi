/// Holds route definitions.
abstract class APServerRoute {
  static const String timetable = 'vozni-redi';
  static const String wpAdmin = 'wp-admin';
  static const String adminAjax = 'admin-ajax.php';

  static const String queryParamDepartureRandomId = 'departure-';

  static const String queryParamDepartureId = 'departure_id';
  static const String queryParamDeparture = 'departure';

  static const String queryParamDestination = 'destination';
  static const String queryParamdestinationId = 'destination_id';

  static const String queryParamDate = 'trip_date';

  static const String queryParamAction = 'action';
  static const String queryParamSpodSif = 'SPOD_SIF';
  static const String queryParamRegIsif = 'REG_ISIF';
  static const String queryParamRprSif = 'RPR_SIF';
  static const String queryParamRprNaz = 'RPR_NAZ';
  static const String queryParamSPODSif = 'SPOD_SIF';
  static const String queryParamOvrSif = 'OVR_SIF';
  static const String queryParamRodIodh = 'ROD_IODH';
  static const String queryParamRodIpri = 'ROD_IPRI';
  static const String queryParamRodCas = 'ROD_CAS';
  static const String queryParamRodPer = 'ROD_PER';
  static const String queryParamRodKm = 'ROD_KM';
  static const String queryParamRodOpo = 'ROD_OPO';
  static const String queryParamVzclCen = 'VZCL_CEN';
  static const String queryParamVvlnZl = 'VVLN_ZL';
  static const String queryParamRodZapz = 'ROD_ZAPZ';
  static const String queryParamRodZapk = 'ROD_ZAPK';
}
