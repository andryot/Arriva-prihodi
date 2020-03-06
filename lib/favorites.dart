import 'package:bus_time_table/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'HomePage.dart';
import 'data_fetch.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'routes.dart';

class FavoritesSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoritesState();
}

class FavoritesState extends State<FavoritesSection> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.green, width: 5),
        borderRadius: new BorderRadius.circular(17.0),
        //color: Color(0xff404040),
      ),
      //height: 200,

      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          getTextWidgets(context),
        ],
      ),
    );
  }
}
//neki  List<double>() = [10, 5];

Widget getTextWidgets(BuildContext context) {
  List<Widget> list = new List<Widget>();
  if (list.isNotEmpty) {
    list.clear();
  }
  if (favorites.isNotEmpty) {
    for (var i = 0; i < favorites.length; i++) {
      List<String> temp = new List<String>();
      favorites[i].split("+").forEach((f) => temp.add(f));
      list.add(
        RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0)),
            padding: EdgeInsets.all(10),
            onPressed: () => [
                  departure = temp[0],
                  destination = temp[1],
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
                  fetch(temp[0].toString(), temp[1].toString(), date)
                      .whenComplete(() => [
                            Navigator.pop(context),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SecondRoute()))
                          ]),
                ],
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: width - width * 0.222,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: AutoSizeText(
                            temp[0].toString() + "   ",
                            maxLines: 1,
                            maxFontSize: 40,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        Icon(
                          EvaIcons.arrowForwardOutline,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            "   " + temp[1].toString(),
                            maxLines: 1,
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    padding: EdgeInsets.only(left: 1, right: 5),
                    child: Material(
                        elevation: 0,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            IconButton(
                              icon: Icon(Icons.star),
                              iconSize: 38,
                              padding: EdgeInsets.only(left: 0),
                              color: Colors.yellow,
                              onPressed: () {
                                print("123");
                              },
                            ),
                          ],
                        )),
                  ),
                ])),

        //child: Image(image: AssetImage("assets/logo.png",),
      );
      list.add(new Container(
        height: 10,
      ));
    }
  }
  return new Wrap(children: list);
}
