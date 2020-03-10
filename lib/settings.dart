import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

//import 'HomePage.dart';
class SettingsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SettingsState();
}

bool darkMode = true;

class SettingsState extends State<SettingsPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff000000),
        title: Text("Nastavitve"),
      ),
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: <Widget>[
          SwitchListTile(
            value: darkMode,
            title: Text(
              "Dark mode",
              style: TextStyle(color: Colors.white),
            ),
            onChanged: (bool value) { 
              if(value) {
                bgdColor = Colors.white;
              }
              setState(() {
                darkMode = value;
              });
            },
          ),
        ]),
      ),
    );
  }
}
