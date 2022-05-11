//import 'dart:io';
import 'package:bus_time_table/screens/settings.dart';
import 'package:bus_time_table/services/local_storage_service.dart';
import 'package:bus_time_table/widgets/AP_Date_Field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'data_fetch.dart';
import 'favorites.dart';
import 'predictions.dart';
import 'routes.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
  void onLoad(BuildContext context) {
    //init(); //callback when layout build done
  }
}

DateTime date = DateTime.now();
var map = new Map<String, int>();

List<String> departures = [];

List<String> arrivals = [];

List<String> travelTime = [];
List<String> busCompany = [];
List<String> kilometers = [];
List<String> price = [];
List<String> lane = [];
List<String> favorites = [];

List<String> predictions = [];

Color bgdColor = Colors.black;

var width;
var height;

String destination = "";
String departure = "";

String routesDestination = "";
String routesDeparture = "";

String bytes = "";
var array = [];

bool errorArrival = true;
bool errorDeparture = true;
double pixelsVertical = 0.0;
double favoritesPosition = 0;

class HomeState extends State<HomePage> {
  TextEditingController destinationController = new TextEditingController();
  GlobalKey paddingKey = new GlobalKey();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback(position);
    //init().whenComplete(() => setState(() {}));
  }

  position(_) {
    favoritesPosition = _getPaddingPosition();
  }

  Widget build(BuildContext context) {
    var _blackFocusNode = new FocusNode();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    pixelsVertical = height * MediaQuery.of(context).devicePixelRatio;
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
                  builder: (context) => SettingsScreen(
                    localStorageService: LocalStorageService.instance,
                  ),
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
                  APDateField(date: date),
                  Padding(padding: EdgeInsets.all(10)),
                  Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height: pixelsVertical > 1750
                              ? height *
                                  (pixelsVertical > 2500 ? 0.02 : 0.023) *
                                  MediaQuery.of(context).devicePixelRatio
                              : height *
                                  (pixelsVertical > 900 ? 0.034 : 0.042) *
                                  MediaQuery.of(context).devicePixelRatio,
                          //height: height > 650 ? height * 0.023 * MediaQuery.of(context).devicePixelRatio: height * 0.034 *MediaQuery.of(context).devicePixelRatio, // MediaQuery.of(context).size.height < 750 ? 55 : 60,,
                          width: width * 0.4,
                          child: RaisedButton(
                            onPressed: () => [
                              errorArrival == false && errorDeparture == false
                                  ? [
                                      print(departure),
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
                                                    new CupertinoPageRoute<
                                                        bool>(
                                                  fullscreenDialog: true,
                                                  builder: (context) =>
                                                      SecondRoute(),
                                                ))
                                              ]),
                                    ]
                                  : [
                                      print(departure),
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
                              style: TextStyle(
                                  fontSize: pixelsVertical < 1920 ? 23 : 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            color: Colors.blue[500],
                            textColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(13.0),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 5,
                        child: Container(
                          height: pixelsVertical > 1750
                              ? height *
                                  (pixelsVertical > 2500 ? 0.02 : 0.023) *
                                  MediaQuery.of(context).devicePixelRatio
                              : height *
                                  (pixelsVertical > 900 ? 0.034 : 0.042) *
                                  MediaQuery.of(context).devicePixelRatio,
                          //height: height > 650? height *0.023 *MediaQuery.of(context).devicePixelRatio: height *0.034 *MediaQuery.of(context).devicePixelRatio,
                          child: FloatingActionButton(
                            backgroundColor: Colors.blue[500],
                            child: Icon(
                              Icons.swap_vert,
                              size: pixelsVertical < 1920 ? 30 : 35,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              var pom = departure;
                              departureTextController.text = destination;
                              destinationTextController.text = pom;
                              departure = destination;
                              destination = pom;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Text(
                    "Priljubljene relacije: ",
                    style: TextStyle(
                      color: Colors
                          .yellow[700], //Theme.of(context).primaryColorLight,
                      fontSize: pixelsVertical < 1920 ? 18 : 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    key: paddingKey,
                    padding: EdgeInsets.all(5),
                  ),
                  Container(
                    //height: pixelsVertical > 1920 ? (height  > 600 ? 0.3 : 0.27) * height : height * 0.3,
                    height: (height - favoritesPosition) - 15,
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

  double _getPaddingPosition() {
    final RenderBox? renderBoxRed =
        paddingKey.currentContext!.findRenderObject() as RenderBox;
    return renderBoxRed!.localToGlobal(Offset.zero).dy;
  }

  Future<bool> _onBackPressed() async {
    return await showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
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
            ) ==
            Object
        ? true
        : false;
  }
}
