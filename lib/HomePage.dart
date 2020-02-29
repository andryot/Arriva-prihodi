//import 'dart:io';
import 'package:bus_time_table/settings.dart';
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
//import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'datePicker.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

DateTime date = DateTime.now();
var map = new Map<String, int>();

List <String> departures = new List<String>();

List <String> arrivals = new List<String>();

List <String> travelTime= new List<String>();
List <String> busCompany = new List<String>();
List <String> kilometers = new List<String>();
List <String> price = new List<String>();
List <String> lane = new List<String>();

var width;

String destination = "";  
String departure = "";

String bytes;
var array = [];

class HomeState extends State<HomePage> {

TextEditingController destinationController = new TextEditingController();

Widget build(BuildContext context) {
    init();
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar( 
        backgroundColor: Color(0xff000000)
      ),
      drawer:Drawer(      
        child: Container(
          color: Color(0xff171B1B),
          child: ListView(
          children: <Widget>[
            DrawerHeader(
              padding: EdgeInsets.all(30),
              child: 
              Text('Arriva prihodi', style: TextStyle(color: Colors.white, fontSize: 25,),),
              decoration: BoxDecoration(border: Border.all(width: 2.0, color: Colors.white)),
            ),
            ListTile(
              title: Text('Iskalnik voznih redov', style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.pop(context);
                
              },
            ),
            ListTile(
              title: Text('Nastavitve', style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage()));
                
              },
            ),
          ],),
          ), 
          
          
      ),
      backgroundColor: Color(0xff000000),
      body: Center(
        child: Container(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            children: <Widget>[
                Padding(padding: EdgeInsets.all(3)),
                TextFormField(
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
                Padding(padding: EdgeInsets.all(10)),
                TextFormField(
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
                Padding(padding: EdgeInsets.all(10)),
                BasicDateField(),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 75),
                  height: 40.0,
                  child: RaisedButton(onPressed: () => 
                  [FocusScope.of(context).requestFocus(new FocusNode()),Navigator.push(context, MaterialPageRoute<void>(builder: (context) => AniRoute(), fullscreenDialog: true)), 
                  fetch(departure, destination, date).whenComplete(() 
                    => [Navigator.pop(context), Navigator.push(context, MaterialPageRoute(builder: (context)=> SecondRoute()))])],
                    child: Text("Išči"),
                    color: Color(0xff00adb5),
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
          border: UnderlineInputBorder(
          borderRadius: new BorderRadius.circular(17.0),),
          fillColor: Colors.white,
          filled: true,),
        format: format,
        initialValue: date,
        onChanged: (DateTime dat) {date = dat;},
        onShowPicker: (context, currentValue) {  
          return showDatePicker(
              context: context,
              builder: (BuildContext context, Widget child) { return Theme(data: ThemeData.dark(),child: child,);},
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              
              lastDate: DateTime(2100));
        },
      ),
      Padding(padding: EdgeInsets.all(5)),
      
      Text('Datum', style: TextStyle(color: Colors.white),),
      ]
    );
  }
}


void init() async{

   bytes = await rootBundle.loadString("assets/postaje.txt");
  bytes.split("\n").forEach((ch) => array.add(ch.split(":")));
  array.removeLast();

  for(int i = 0; i < array.length; i++){
    map[array[i][0]] = int.parse(array[i][1]);
  }
}


Future<void> fetch(String depar, String dest, DateTime date1) async {

  WidgetsFlutterBinding.ensureInitialized();
  

  String departure = depar.replaceAll(" ", "+");
  String destination = dest.replaceAll(" ", "+");
  String date = DateFormat('dd.MM.yyy').format(date1);

  var rng = new Random();
  int next = 1000 + rng.nextInt(8999);
  
  String url = "https://arriva.si/en/timetable/?departure-" + next.toString() + departure + "&departure_id="
  + map[departure].toString() + "&departure=" + departure +   "&destination=" + destination + "&destination_id=" +
  map[destination].toString() + "&trip_date=" + date;

  http.Response response =  await http.get(url);
  

  dom.Document document = parser.parse(response.body);

  
  departures.clear();
  
  document.getElementsByClassName('departure').forEach((dom.Element element){
      departures.add(element.getElementsByTagName('span').first.text); 
  });

  arrivals.clear();

  document.getElementsByClassName('arrival').forEach((dom.Element element){
      arrivals.add(element.getElementsByTagName('span').first.text); 
  });
  
  travelTime.clear();
  document.getElementsByClassName('travel-duration').forEach((dom.Element element){
      travelTime.add(element.getElementsByTagName('span').first.text); 
  });

  busCompany.clear();
  document.getElementsByClassName('prevoznik').forEach((dom.Element element){
      busCompany.add(element.getElementsByTagName('span').last.text); 
  });

  kilometers.clear();
  document.getElementsByClassName('length').forEach((dom.Element element){
      kilometers.add(element.text); 
  });
  kilometers.removeAt(0);

  price.clear();
  document.getElementsByClassName('price').forEach((dom.Element element){
      price.add(element.text.replaceAll("EUR", "€")); 
  });
  price.removeAt(0);
  lane.clear();
  document.getElementsByClassName('peron').forEach((dom.Element element){
      lane.add(element.getElementsByTagName('span').last.text); 
  });

  print(lane);
  



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



