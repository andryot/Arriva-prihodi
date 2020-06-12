import 'package:bus_time_table/blocs/theme.dart';
import 'package:bus_time_table/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;
//import 'package:html/parser.dart' as parser;
//import 'package:html/dom.dart' as dom;
//import 'package:path/path.dart';
//import 'dart:io';
//import 'dart:convert';
//import 'package:path_provider/path_provider.dart';
//import 'package:flutter/services.dart' show  rootBundle;
//import 'dart:async' show Future;
//import 'dart:math';
import 'package:flutter/widgets.dart';
import 'HomePage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.dark()),
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        darkTheme: ThemeData(
            primaryColor: Colors.black,
            primaryIconTheme: IconThemeData(color: Colors.white),
            brightness: Brightness.dark,
            primarySwatch: Colors.grey,
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.black),
        theme: ThemeData(
           primaryIconTheme: IconThemeData(color: Colors.black),
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            primaryColor: Colors.white,
            primaryColorLight: Colors.black,
            ),
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
      ),
    );
  }
}
