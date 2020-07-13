import 'package:bus_time_table/config.dart';
import 'package:bus_time_table/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'HomePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() { 
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());  
  }

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
  void onLoad(BuildContext context) {}
  
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        primaryIconTheme: IconThemeData(color: Colors.white),
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColorLight: Colors.white,
      ),
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.black),
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        primaryColorLight: Colors.black,
      ),
      themeMode: currentTheme.currentTheme(),
      supportedLocales: [
        const Locale("sl"),
        //const Locale("en"),
      ],
      title: 'Arriva prihodi',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/second': (context) => SecondRoute(),
      },
    );
  }
}
