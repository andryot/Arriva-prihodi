import 'package:bus_time_table/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'HomePage.dart';
import 'data_fetch.dart';
import 'routes.dart';

class FavoritesSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoritesState();
}

class FavoritesState extends State<FavoritesSection> {
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.green, width: 5),
        borderRadius: new BorderRadius.circular(17.0),
        //color: Color(0xff404040),
      ),
      // color: Color(0xff404040),
      //height: 200,
      child: ListView(
        physics: ScrollPhysics(),
        children: <Widget>[
          getTextWidgets(context),
          /*Text(
            "Priljubljene relacije: ",
            style: TextStyle(color: Colors.black, fontSize: 30),
          )
          */
        ],
      ),
    ));
  }
}

Widget getTextWidgets(BuildContext context) {
  List<Widget> list = new List<Widget>();
  if (list.isNotEmpty) {
    list.clear();
  }
  if (favorites.isNotEmpty) {
    for (var i = 0; i < favorites.length; i++) {
      var temp = [];
      temp.clear();
      favorites[i].split("+").forEach((f) => temp.add(f));

      print(temp[0]);
      list.add(
        RaisedButton(
          shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
          padding: EdgeInsets.all(12),
          
            onPressed: () => [departure = temp[0], destination = temp[1],
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
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  width: (width - width / 100 * 15) -
                      (width - width / 100 * 13) * 0.20,
                  child: Row(children: <Widget>[
                  
                  AutoSizeText(
                   // (i + 1).toString() +
                      //  ". " +
                        temp[0].toString() +
                        " --> " +
                        temp[1].toString(),
                        
                    maxLines: 1,
                    
                    minFontSize: 12,
                    maxFontSize: 19,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      color: Colors.black,
                    ),
                  ),])
                ),
                //child: Image(image: AssetImage("assets/logo.png",),
              ],
            )),
      );
      list.add(new Container(
        height: 10,
      ));
    }
  }
  return new Wrap(children: list);
}
