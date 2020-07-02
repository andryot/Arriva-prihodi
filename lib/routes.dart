import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bus_time_table/config.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondRoute extends StatefulWidget {
  State<StatefulWidget> createState() => SecondState();
}

final prefs = SharedPreferences.getInstance();
Color starColor;
final ScrollController _controller = ScrollController();
double ct = height * 0.2;
class SecondState extends State<SecondRoute> {

  

  @override
  void initState() {
    super.initState();
    init2().whenComplete(() => setState(() {}));
     WidgetsBinding.instance
        .addPostFrameCallback((_) => {_controller.animateTo(ct/2, duration: Duration(seconds: 1), curve: Curves.ease)});
    ct=height * 0.2;
    // widget.onLoad(context);
  }

  @override
  Widget build(BuildContext context) {
    var willPopScope = WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: width * 0.65,
                child: RichText(
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: routesDeparture + "  ",
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 18),
                      ),
                      WidgetSpan(
                        child: Icon(EvaIcons.arrowForwardOutline),
                      ),
                      TextSpan(
                        text: "  " + routesDestination,
                        style: TextStyle(
                            color: Theme.of(context).primaryColorLight,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.star,
                  size: 30,
                  color: starColor,
                ),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  if (favorites == null) {
                    favorites.add(routesDeparture + "+" + routesDestination);
                    await prefs.setStringList("favorites", favorites);
                    starColor = Colors.yellow;
                    setState(() {});
                  } else {
                    if (favorites
                        .contains(routesDeparture + "+" + routesDestination)) {
                      favorites.remove(departure + "+" + destination);
                      await prefs.remove("favorites");
                      await prefs.setStringList("favorites", favorites);
                      await prefs.reload();
                      starColor = currentTheme.starColor();
                      setState(() {});
                    } else {
                      favorites.add(routesDeparture + "+" + routesDestination);
                      await prefs.setStringList("favorites", favorites);
                      starColor = Colors.yellow;
                      setState(() {});
                    }
                  }
                },
              ),
            ],
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Center(
          child: ListView(
            controller: _controller,
            physics: BouncingScrollPhysics(), children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
            ),
            Container(
              height: height * 0.035,
              width: width * 0.9,
              child: Stack(   
                alignment: FractionalOffset.center,   
                children: <Widget>[
                  Positioned(left: width * 0.09,
                                      child: Text(
                      "Odhod",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 25),
                    ),
                  ),
                  Positioned(right: width * 0.225,
                                      child: Text(
                      "Prihod",
                      style: TextStyle(
                          color: Theme.of(context).primaryColorLight,
                          fontSize: 25),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
            ),
            getTextWidgets(departures, arrivals, context),
          ]),
        ),
      ),
    );
    return willPopScope;
  }
}

Widget getTextWidgets(
    List<String> departure, List<String> arrival, BuildContext context) {
  List<Widget> list = new List<Widget>();
  if (list.isNotEmpty) {
    list.clear();
  }
  if (departures.length == 0) {
    list.add(Padding(padding: EdgeInsets.all(10)));
    list.add(
      Center(
        child: Text(
          "Med izbranima postajama ni povezav",
          style: TextStyle(
            color: Colors.red,
            fontSize: 35,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
    return new Wrap(children: list);
  } else {
    for (var i = 0; i < departures.length; i++) {
      list.add(Center(
        child: Container(
            height: height * 0.062  ,
            width: width * 0.9,
            decoration: (BoxDecoration(
              color:
                  Theme.of(context).primaryColorBrightness == Brightness.light
                      ? Colors.white
                      : Color(0xff404040),
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: (width * 0.75),
                  child: Stack(
                    alignment: FractionalOffset.center,
                    children: <Widget>[
                      Positioned(
                        left: 20,
                        child: Text(
                          departure[i],
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ),
                      Center(
                        child: Icon(
                          EvaIcons.arrowForwardOutline,
                          color: Theme.of(context).primaryColorLight,
                          size: 25,
                        ),
                      ),
                      Positioned(
                        right: 20,
                        child: Text(
                          arrival[i],
                          style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  padding: EdgeInsets.only(bottom: 0),
                  icon: Icon(Icons.info),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            backgroundColor:
                                Theme.of(context).primaryColorBrightness ==
                                        Brightness.light
                                    ? Colors.white
                                    : Color(0xff404040),
                            content: Container(
                              width: width - width * 0.25,
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text(
                                      "Odhod: " + departure[i],
                                      style: TextStyle(
                                          color: Theme.of(context)
                                                      .primaryColorBrightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Color(0xff404040),
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text("Prihod: " + arrival[i],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColorBrightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Color(0xff404040),
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text("Čas: " + travelTime[i],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColorBrightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Color(0xff404040),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text("Razdalja: " + kilometers[i],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColorBrightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Color(0xff404040),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text("Cena: " + price[i],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColorBrightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Color(0xff404040),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text("Prevoznik: " + busCompany[i],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColorBrightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Color(0xff404040),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text("Peron: " + lane[i],
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                        .primaryColorBrightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Color(0xff404040),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  tooltip: "Več informacij",
                  alignment: Alignment.center,
                  iconSize: 25,
                  color: Theme.of(context).primaryColorLight,
                ),
                //child: Image(image: AssetImage("assets/logo.png",),
              ],
            )),
      ));
      if(DateTime(2020, date.month, date.day, int.parse(departure[i].split(":")[0]), int.parse(departure[i].split(":")[1])).isBefore(DateTime.now())){
        ct+=(height*0.072);
        print(ct);
      }
      list.add(new Container(
        height: height * 0.01,
      ));
    }
    return new Wrap(children: list);
  }
}

class AniRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(
                color: Theme.of(context).primaryColorLight,
                size: 80,
              ),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                "Pridobivanje podatkov...",
                style: TextStyle(
                    color: Theme.of(context).primaryColorLight, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> _willPopCallback() async {
  return false;
}

Future<void> init2() async {
  if (favorites.contains(routesDeparture + "+" + routesDestination))
    starColor = Colors.yellow;
  else
    starColor = currentTheme.starColor();
}
