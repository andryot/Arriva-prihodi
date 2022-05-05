import 'package:bus_time_table/services/local_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'router/router.dart';
import 'router/routes.dart';
import 'util/logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  LocalStorageService(await SharedPreferences.getInstance());
  Logger();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("sl"),
        //const Locale("en"),
      ],
      title: 'Arriva prihodi',
      debugShowCheckedModeBanner: false,
      initialRoute: APRoute.initial,
      onGenerateRoute: APRouter.onGenerateRoute,
    );
  }
}
