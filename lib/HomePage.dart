import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:flutter/services.dart' show  rootBundle;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
//import 'package:path/path.dart';
import 'routes.dart';
//import 'datePicker.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
  
}

DateTime date = DateTime.now();
var map = new Map<String, int>();

List <String> departures = new List<String>();

List <String> arrivals = new List<String>();

var width;

class HomeState extends State<HomePage> {
TextEditingController destinationController = new TextEditingController();

String destination = "";  
String departure = "";

Widget build(BuildContext context) {
     width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff443737),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),     
          child: ListView(
            children: <Widget>[
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                    onChanged: (text) {departure = text;},
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Departure',
                    ),
                  ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                    onChanged: (text) {destination = text;},
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: UnderlineInputBorder(
                        
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Destination',
                    ),
                  ),
                Padding(padding: EdgeInsets.all(10)),
                BasicDateField(),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 75),
                  height: 40.0,
                  child: RaisedButton(onPressed: () => [fetch(departure, destination, date),
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondRoute()))],
                    child: Text("Išči"),
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(13.0),
                    ),
                    ),
                  ),
                Padding(padding: EdgeInsets.all(10)),      
                ],
          ),
        ),
      ),
    );
  }
}


class BasicDateField extends StatelessWidget {
  final format = DateFormat("dd.MM.yyyy");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,),
        format: format,
        initialValue: date,
        onChanged: (DateTime dat) {date = dat;},
        onShowPicker: (context, currentValue) {  
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
      Padding(padding: EdgeInsets.all(5)),
      
      Text('Datum', style: TextStyle(color: Colors.white),),
    ]);
  }
}


Future<void> fetch(String depar, String dest, DateTime date1) async {

  WidgetsFlutterBinding.ensureInitialized();
  String bytes = await rootBundle.loadString("assets/postaje.txt");

  var array = [];
  
  bytes.split("\n").forEach((ch) => array.add(ch.split(":")));
  array.removeLast();

  for(int i = 0; i < array.length; i++){
    map[array[i][0]] = int.parse(array[i][1]);
  }

  String departure = depar.replaceAll(" ", "+");
  String destination = dest.replaceAll(" ", "+");
  String date = DateFormat('dd.MM.yyy').format(date1);

  var rng = new Random();
  int next = 1000 + rng.nextInt(8999);
  
  String url = "https://arriva.si/en/timetable/?departure-" + next.toString() + departure + "&departure_id="
  + map[departure].toString() + "&departure=" + departure +   "&destination=" + destination + "&destination_id=" +
  map[destination].toString() + "&trip_date=" + date;
  
  http.Response response = await http.get(url);

  dom.Document document = parser.parse(response.body);
  
  departures.clear();
  document.getElementsByClassName('departure').forEach((dom.Element element){
      departures.add(element.getElementsByTagName('span').first.text); 
  });
  arrivals.clear();
  document.getElementsByClassName('arrival').forEach((dom.Element element){
      arrivals.add(element.getElementsByTagName('span').first.text); 
  });
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
}



