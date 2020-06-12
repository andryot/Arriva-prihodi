import 'package:auto_size_text/auto_size_text.dart';
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

class SecondState extends State<SecondRoute> {
  @override
  void initState() {
    super.initState();
    init2().whenComplete(() => setState(() {}));

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
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.star,
                  size: 31,
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
                      await prefs.setStringList("favorites", favorites);
                      starColor = Colors.white;
                      setState(() {});
                    } else {
                      //favorites.add(departure + " " + destination);
                      favorites.add(routesDeparture + "+" + routesDestination);
                      await prefs.setStringList("favorites", favorites);
                      starColor = Colors.yellow;
                      setState(() {});
                    }
                  }
                },
              )
            ],
            backgroundColor: Theme.of(context).primaryColor,
            title: Row(
              children: <Widget>[
                Container(
                  width: width*0.3,
                  child: AutoSizeText(
                    routesDeparture + "  ",
                    maxLines: 1,
                    style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 25),
                  ),
                ),
                Icon(EvaIcons.arrowForwardOutline,),
                Container(
                  width: width*0.3,
                  child: AutoSizeText(
                    "  " + routesDestination,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
          body: Center(
            child: Container(
              child: ListView(
                  physics: BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Container(
                      padding: EdgeInsets.only(right:width*0.12),
                    
                      child: Row(
                        
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Odhod",
                            style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 20),
                          ),
                          //Icon(EvaIcons.arrowForwardOutline, color: Colors.black,),
                          Text(
                            "Prihod",
                            style: TextStyle(color: Theme.of(context).primaryColorLight, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    getTextWidgets(departures, arrivals, context),
                  ]),
            ),
          ),
        ));
    return willPopScope;
  }
}

/*
Future<void> pejt_domov(BuildContext context){

  Navigator.popUntil(context, ModalRoute.withName("/home"));
}
*/

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
            height: 60,
            width: width * 0.9,
            padding: EdgeInsets.all(17),
            decoration: (BoxDecoration(
              color: Theme.of(context).primaryColorBrightness == Brightness.light ?  Colors.white : Color(0xff404040),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: (width  * 0.7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      AutoSizeText(
                        departure[i],
                        maxLines: 1,
                        minFontSize: 23,
                        style: TextStyle(
                          fontSize: 35,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),

                      Icon(EvaIcons.arrowForwardOutline, color: Theme.of(context).primaryColorLight,),
                      AutoSizeText(
                        arrival[i],
                        maxLines: 1,
                        minFontSize: 23,
                        style: TextStyle(
                          fontSize: 35,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ],
                  ),
                ),

                IconButton(
                  padding: EdgeInsets.only(left: 0, bottom: 3),
                  icon: Icon(Icons.info),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0))),
                            backgroundColor: Theme.of(context).primaryColorBrightness == Brightness.light ? Colors.white : Color(0xff404040),
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
                                          color: Colors.white,
                                          fontSize: 34,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text("Prihod: " + arrival[i],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 34,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: Text("Čas: " + travelTime[i],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text("Razdalja: " + kilometers[i],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text("Cena: " + price[i],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text("Prevoznik: " + busCompany[i],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.0),
                                    child: Text("Peron: " + lane[i],
                                        style: TextStyle(
                                            color: Colors.white,
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
                  iconSize: 30,
                  color: Theme.of(context).primaryColorLight,
                ),
                //child: Image(image: AssetImage("assets/logo.png",),
              ],
            )),
      ));
      list.add(new Container(
        height: 10,
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
        backgroundColor: Color(0xff000000),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SpinKitCircle(
                color: Colors.white,
                size: 80,
              ),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                "Pridobivanje podatkov...",
                style: TextStyle(color: Colors.white, fontSize: 25),
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

class PopupContent extends StatefulWidget {
  final Widget content;
  PopupContent({
    Key key,
    this.content,
  }) : super(key: key);
  _PopupContentState createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("123455242"),
    );
  }
}

Future<void> init2() async {
  if (favorites.contains(routesDeparture + "+" + routesDestination))
    starColor = Colors.yellow;
  else
    starColor = Colors.white;
}
