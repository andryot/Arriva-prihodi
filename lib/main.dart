
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


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/second': (context) => SecondRoute(),      
                },
          );
        }
      }
      

