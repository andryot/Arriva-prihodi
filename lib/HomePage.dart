//import 'dart:io';
import 'package:bus_time_table/config.dart';
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
     WidgetsBinding.instance.addPostFrameCallback(position);
    init().whenComplete(() => setState(() {}));
  }

  position (_){
favoritesPosition = _getPaddingPosition();
  }

  Widget build(BuildContext context) {
    var _blackFocusNode = new FocusNode();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    print(pixelsVertical);
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
                  Padding(padding: EdgeInsets.all(10)),
                  Stack(
                    fit: StackFit.passthrough,
                    children: <Widget>[
                      Center(
                        child: Container(
                          height:  pixelsVertical > 1750 ?  height * 0.023 * MediaQuery.of(context).devicePixelRatio : height * (pixelsVertical > 900 ? 0.034 : 0.042) * MediaQuery.of(context).devicePixelRatio,
                          //height: height > 650 ? height * 0.023 * MediaQuery.of(context).devicePixelRatio: height * 0.034 *MediaQuery.of(context).devicePixelRatio, // MediaQuery.of(context).size.height < 750 ? 55 : 60,,
                          width: width * 0.4,
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
                                                    new CupertinoPageRoute<
                                                        bool>(
                                                  fullscreenDialog: true,
                                                  builder: (context) =>
                                                      SecondRoute(),
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
                          height:  pixelsVertical > 1750 ?  height * 0.023 * MediaQuery.of(context).devicePixelRatio : height * (pixelsVertical > 900 ? 0.034 : 0.042) * MediaQuery.of(context).devicePixelRatio,
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
                      fontSize:
                          pixelsVertical < 1920 ? 18 : 20,
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

  double _getPaddingPosition(){
    final RenderBox renderBoxRed = paddingKey.currentContext.findRenderObject();
    print(renderBoxRed.localToGlobal(Offset.zero).dy);
    
    return renderBoxRed.localToGlobal(Offset.zero).dy;
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
        ) ??
        false;
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd.MM.yyyy");
  @override
  Widget build(BuildContext context) {
    return Container(
      height:  pixelsVertical > 1750 ?  height * (height  > 600 ? 0.028 : 0.024) * MediaQuery.of(context).devicePixelRatio : height * (pixelsVertical > 900 ? 0.042 : 0.05) * MediaQuery.of(context).devicePixelRatio,
      //height: height > 650 ? height * 0.027 * MediaQuery.of(context).devicePixelRatio : height * 0.042 * MediaQuery.of(context).devicePixelRatio,
      child: DateTimeField(
        resetIcon: Icon(
          Icons.clear,
          color: Colors.black,
          size: 30,
        ),
        expands: true,
        maxLines: null,
        minLines: null,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(17)),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: new Icon(
            Icons.date_range,
            size: 30,
            color: Colors.black,
          ),
        ),
        style: TextStyle(fontSize: height < 750 ? 18 : 20, color: Colors.black),
        format: format,
        initialValue: date,
        onChanged: (DateTime dat) {
          date = dat;
        },
        onShowPicker: (context, currentValue) {
          return showDatePicker(
            helpText: "Izberi datum odhoda",
            context: context,
            builder: (BuildContext context, Widget child) {
              return Theme(
                data: Theme.of(context),
                child: child,
              );
            },
            firstDate: DateTime(2020),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2030),
          );
        },
      ),
    );
  }
}

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey("Theme") && await prefs.get("Theme") == "white")
    currentTheme.switchTheme();
  else
    await prefs.setString("Theme", "dark");

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

  if (prefs.containsKey("favorites"))
    favorites.addAll(prefs.getStringList("favorites"));
}
