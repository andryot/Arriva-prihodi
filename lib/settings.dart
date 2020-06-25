import 'package:bus_time_table/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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
      body: Center(
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Dark mode",
                  style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 17),
                ),
                Switch(
                  activeColor: Colors.blue,
                  value: darkMode,
                  onChanged: (bool value) {
                    setState(() {
                      currentTheme.switchTheme();
                      darkMode = value;
                    });
                  },
                ),
              ],
            ),
          ),
          CupertinoButton(
              child: Text("Več informacij"),
              onPressed: () => showAboutDialog(
                  context: context,
                  useRootNavigator: false,
                  applicationVersion: "\n1.3",
                  applicationName: "Arriva prihodi",
                  applicationLegalese:
                      "Podatki se pridobivajo iz spletne strani arriva.si\n\nRazvijalec: Andraž Anderle\nIcon made by Freepi from www.flaticon.com")),
        ]),
      ),
    );
  }
}
