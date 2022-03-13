import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/router.dart';
import 'router/routes.dart';
import 'util/logger.dart';
//import 'package:device_preview/device_preview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Logger();
  runApp(MyApp()
      //DevicePreview(builder: (context) => MyApp())
      );
}

class MyApp extends StatelessWidget {
  /* void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  } */

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      /* darkTheme: ThemeData(
        primaryColor: Colors.black,
        primaryIconTheme: IconThemeData(color: Colors.white),
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColorLight: Colors.white,
      ), */
      /* theme: APTheme,
        primaryIconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        primaryColorLight: Colors.black,
      ), */
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
