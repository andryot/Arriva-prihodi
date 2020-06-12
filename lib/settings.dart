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
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Nastavitve"),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(alignment: Alignment.centerLeft,
        child: ListView(children: <Widget>[
          SwitchListTile(
            value: darkMode,
            title: Text(
              "Dark mode",
              style: TextStyle(color: Theme.of(context).primaryColorLight),
            ),
            onChanged: (bool value) {
              if (value) {
                bgdColor = Colors.white;
              }
              setState(() {
                darkMode = value;
              });
            },
          ),
          CupertinoButton(
              child: Text("Več informacij"),
              onPressed: () => showAboutDialog(
                  context: context,
                  applicationVersion: "\n1.3",
                  applicationName: "Arriva prihodi",
                  applicationLegalese: "Podatki se pridobivajo iz spletne strani arriva.si\n")),
        ]),
      ),
    );
  }
}
