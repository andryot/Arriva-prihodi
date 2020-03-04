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

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
  void onLoad(BuildContext context) {
    init(); //callback when layout build done
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

Color bgd_color = Colors.black;
var width;

String destination = "";
String departure = "";

String bytes;
var array = [];

class HomeState extends State<HomePage> {
  TextEditingController destinationController = new TextEditingController();

  @override
  void initState() => widget.onLoad(context);

  Widget build(BuildContext context) {
    var _blackFocusNode = new FocusNode();
    width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff000000),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              icon: Icon(Icons.settings),
              color: Colors.white,
              iconSize: 30,
            ),
            //alignment: Alignment.topRight,),
          ],
        ),
        backgroundColor: Color(0xff000000),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 75),
                    height: 40.0,
                    child: RaisedButton(
                      onPressed: () => [
                        FocusScope.of(context).requestFocus(new FocusNode()),
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => AniRoute(),
                              fullscreenDialog: true,
                              transitionsBuilder: (c, anim, a2, child) =>
                                  FadeTransition(opacity: anim, child: child),
                              transitionDuration: Duration(milliseconds: 400),
                            )),
                        fetch(departure, destination, date).whenComplete(() => [
                              Navigator.pop(context),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SecondRoute()))
                            ]),
                      ],
                      child: Text("Išči"),
                      color: Color(0xff00adb5),
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(13.0),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10)),
                  Container(
                    // width: 200,
                    height: 200,
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
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            //title: new Text('Are you sure?'),
            content: new Text('Želiš zapustiti aplikacijo?'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(
                  "NE",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 0),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text(
                  "JA",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
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
    return Column(children: <Widget>[
      DateTimeField(
        resetIcon: Icon(
          Icons.clear,
          color: Colors.black,
          size: 30,
        ),
        //textAlign: TextAlign.center,
        maxLines: 2,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15, top: 20),
          border: UnderlineInputBorder(
            borderRadius: new BorderRadius.circular(17.0),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: new Icon(
            Icons.date_range,
            color: Colors.black,
          ),

          /*suffixIcon: Icon(
            Icons.clear,
            color: Colors.black,
            ),
            */
        ),
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
                data: ThemeData.dark(),
                child: child,
              );
            },
            firstDate: DateTime(1900),
            initialDate: currentValue ?? DateTime.now(),
            lastDate: DateTime(2100),
          );
        },
      ),
      //Padding(padding: EdgeInsets.all(10)),
    ]);
  }
}

void init() async {
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
}

//Set<String> set = Set.from(tabela);
//  set.forEach((element) => print(element.trim().contains(":")));
/* for(int i = 0; i < departures.length; i++){
    print("Odhod: " + departures[i] + " Prihod: " + arrivals[i]);
  }
  */
/*for(var i = 0; i < departures.length; i++){
        list.add(new Text(departures[i]));
    }
  */
/*
                  _keyboardIsVisible()
                      ? Text(
                          "Keyboard is visible",
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(color: Colors.blue),
                        )
                      : RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Keyboard is ",
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(color: Colors.blue),
                            ),
                            TextSpan(
                              text: "not ",
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(color: Colors.red),
                            ),
                            TextSpan(
                              text: "visible",
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(color: Colors.blue),
                            )

                          ]),
                        ),
                        */
