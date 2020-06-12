import 'HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:intl/intl.dart';

Future<void> fetch(String depar, String dest, DateTime date1) async {
  WidgetsFlutterBinding.ensureInitialized();

  String departure = depar.replaceAll(" ", "+");
  String destination = dest.replaceAll(" ", "+");
  String date = DateFormat('dd.MM.yyy').format(date1);

  var rng = new Random();
  int next = 1000 + rng.nextInt(8999);

  String url = "https://arriva.si/en/timetable/?departure-" +
      next.toString() +
      departure +
      "&departure_id=" +
      map[departure].toString() +
      "&departure=" +
      departure +
      "&destination=" +
      destination +
      "&destination_id=" +
      map[destination].toString() +
      "&trip_date=" +
      date;

  http.Response response = await http.get(url);

  dom.Document document = parser.parse(response.body);

  departures.clear();

  document.getElementsByClassName('departure').forEach((dom.Element element) {
    departures.add(element.getElementsByTagName('span').first.text);
  });

  arrivals.clear();
  document.getElementsByClassName('arrival').forEach((dom.Element element) {
    arrivals.add(element.getElementsByTagName('span').first.text);
  });

  travelTime.clear();
  document
      .getElementsByClassName('travel-duration')
      .forEach((dom.Element element) {
    travelTime.add(element.getElementsByTagName('span').first.text);
  });

  busCompany.clear();
  document.getElementsByClassName('prevoznik').forEach((dom.Element element) {
    busCompany.add(element.getElementsByTagName('span').last.text);
  });

  kilometers.clear();
  document.getElementsByClassName('length').forEach((dom.Element element) {
    kilometers.add(element.text);
  });
  if (kilometers.length > 0) kilometers.removeAt(0);

  price.clear();
  document.getElementsByClassName('price').forEach((dom.Element element) {
    price.add(element.text.replaceAll("EUR", "€").replaceAll(".", ","));
  });
  if (price.length > 0) price.removeAt(0);

  lane.clear();
  var counter = 0;

  document.getElementsByClassName('duration').forEach((dom.Element element) {
    element.getElementsByClassName('peron').forEach((dom.Element element2) {
      lane.add(element2.getElementsByTagName("span").last.text);
    });

    if (lane.length == counter && counter != 2) {
      lane.add("/");
    }
    counter++;
  });

  if (lane.length > 0) lane.removeAt(0);

  if (lane.length == 1) {
    for (int i = 0; i < departures.length; i++) lane.add("/");
  }
}
