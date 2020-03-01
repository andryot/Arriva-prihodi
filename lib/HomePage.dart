//import 'dart:io';
import 'package:bus_time_table/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:flutter/services.dart' show rootBundle;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'predictions.dart';

//import 'package:path/path.dart';
import 'routes.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'datePicker.dart';

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

List<String> predictions = new List<String>();
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
        appBar: AppBar(backgroundColor: Color(0xff000000)),
        drawer: Drawer(
          child: Container(
            color: Color(0xff171B1B),
            child: ListView(
              children: <Widget>[
                DrawerHeader(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Arriva prihodi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.white)),
                ),
                ListTile(
                  title: Text(
                    'Iskalnik voznih redov',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Nastavitve',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                ),
              ],
            ),
          ),
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
                  Padding(padding: EdgeInsets.all(3)),
                  InputFormDeparture(),
                  /*TextFormField(
                  autofocus: false,
                  onChanged: (text) {departure = text;},
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: UnderlineInputBorder( 
                        borderRadius: new BorderRadius.circular(17.0),
                        ),
                    hintText: 'Departure',
                  ),
                ),
                */
                  Padding(padding: EdgeInsets.all(10)),
                  InputFormArrival(),
                  /*TextFormField(
                  autofocus: false,
                    onChanged: (text) {destination = text;},
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder( 
                        borderRadius: new BorderRadius.circular(17.0),
                      ),
                      hintText: 'Destination',
                    ),
                  ),
                  */
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
                            ])
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
            title: new Text('Are you sure?'),
            content: new Text('Do you want to exit an App'),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("NO"),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(true),
                child: Text("YES"),
              ),
            ],
          ),
        ) ??
        false;
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd.MM.yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderRadius: new BorderRadius.circular(17.0),
          ),
          fillColor: Colors.white,
          filled: true,
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
              lastDate: DateTime(2100));
        },
      ),
      Padding(padding: EdgeInsets.all(5)),
      Text(
        'Datum',
        style: TextStyle(color: Colors.white),
      ),
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
      print(lane);
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
