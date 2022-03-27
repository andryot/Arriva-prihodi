import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/router.dart';
import 'router/routes.dart';
import 'util/logger.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      initialRoute: APRoute.home,
      onGenerateRoute: APRouter.onGenerateRoute,
    );
  }
}
