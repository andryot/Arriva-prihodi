//import 'dart:io';
import 'package:bus_time_table/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'predictions.dart';
import 'data_fetch.dart';
import 'routes.dart';
import 'favorites.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
  void onLoad(BuildContext context) {
    //init(); //callback when layout build done
  }
}

DateTime date = DateTime.now();
var map = new Map<String, int>();

List<String> departures = new List<String>();

List<String> arrivals = new List<String>();

List<String> travelTime = new List<String>();
List<String> busCompany = new List<String>();
List<String> kilometers = new List<String>();
List<String> price = new List<String>();
List<String> lane = new List<String>();
List<String> favorites = new List<String>();

List<String> predictions = new List<String>();

Color bgdColor = Colors.black;
var width;
var height;

String destination = "";
String departure = "";

String routesDestination = "";

String routesDeparture = "";

String bytes;
var array = [];

class HomeState extends State<HomePage> {
  TextEditingController destinationController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    init().whenComplete(() => setState(() {}));
    // widget.onLoad(context);
  }

  Widget build(BuildContext context) {
    var _blackFocusNode = new FocusNode();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(new CupertinoPageRoute<bool>(
                  builder: (context) => SettingsPage(),
                ));
              },
              icon: Icon(Icons.settings),
              iconSize: 30,
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_blackFocusNode);
          },
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Container(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(0)),
                  InputFormDeparture(),
                  Padding(padding: EdgeInsets.all(10)),
                  InputFormArrival(),
                  Padding(padding: EdgeInsets.all(10)),
                  BasicDateField(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.25),
                    height: height * 0.06,
                    child: RaisedButton(
                      onPressed: () => [
                        errorArrival == false && errorDeparture == false
                            ? [
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode()),
                                routesDeparture = departure,
                                routesDestination = destination,
                                Navigator.of(context)
                                    .push(new CupertinoPageRoute<bool>(
                                  fullscreenDialog: true,
                                  builder: (context) => AniRoute(),
                                )),
                                fetch(departure, destination, date)
                                    .whenComplete(() => [
                                          Navigator.pop(context),
                                          Navigator.of(context).push(
                                              new CupertinoPageRoute<bool>(
                                            fullscreenDialog: true,
                                            builder: (context) => SecondRoute(),
                                          ))
                                        ]),
                              ]
                            : [
                                colorDeparture = Colors.red,
                                Fluttertoast.showToast(
                                  msg: "Napaka pri izbiri postaj!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                ),
                              ]
                      ],
                      child: Text(
                        "Išči",
                        style: TextStyle(fontSize: 30),
                      ),
                      color: Color(0xff00adb5),
                      textColor: Theme.of(context).primaryColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                  //Divider(color: Colors.white, ),
                  Padding(padding: EdgeInsets.all(20)),
                  Text(
                    "    Priljubljene relacije: ",
                    style: TextStyle(
                      color: Colors
                          .orange[800], //Theme.of(context).primaryColorLight,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    height: height * 0.52,
                    child: FavoritesSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showCupertinoDialog(
          context: context,
          builder: (context) => Theme(
            data: ThemeData.dark(),
            child: CupertinoAlertDialog(
              title: new Text(
                'Želite zapreti aplikacijo?',
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "Prekliči",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                CupertinoButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    "Zapri",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          /*elevation: 1,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),*/
        ) ??
        false;
  }
}
/*
  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

*/

class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd.MM.yyyy");
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.08,
      child: DateTimeField(
        resetIcon: Icon(
          Icons.clear,
          color: Colors.black,
          size: 30,
        ),
        
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(width*0.04),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(17)),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: new Icon(
            Icons.date_range,
            color: Colors.black,
          ),
        ),
        style: TextStyle(fontSize: 20, color: Colors.black),
        format: format,
        initialValue: date,
        onChanged: (DateTime dat) {
          date = dat;
        },
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            context: context,
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: Theme.of(context),
                child: child,
              );
            },
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
        },
      ),
    );
  }
}

Future<void> init() async {
  bytes = await rootBundle.loadString("assets/postaje.txt");
  array.clear();
  bytes.split("\n").forEach((ch) => array.add(ch.split(":")));
  array.removeLast();
  map.clear();
  predictions.clear();
  for (int i = 0; i < array.length; i++) {
    map[array[i][0]] = int.parse(array[i][1]);
    predictions.add(array[i][0].toString().replaceAll("+", " "));
  }

  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("favorites"))
    favorites.addAll(prefs.getStringList("favorites"));
}
