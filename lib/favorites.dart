import 'package:bus_time_table/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';

class FavoritesSection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FavoritesState();
}

class FavoritesState extends State<FavoritesSection> {
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.green, width: 5),
        borderRadius: new BorderRadius.circular(17.0),
        //color: Color(0xff404040),
      ),
      // color: Color(0xff404040),
      //height: 200,
      child: ListView(
        children: <Widget>[
          getTextWidgets(),
          /*Text(
            "Priljubljene relacije: ",
            style: TextStyle(color: Colors.black, fontSize: 30),
          )
          */
        ],
      ),
    );
  }
}

Widget getTextWidgets() {
  List<Widget> list = new List<Widget>();
  if (list.isNotEmpty) {
    list.clear();
  }

  for (var i = 0; i < favorites.length; i++) {
    /*if(i % 2 == 1){
        barva = Color(0xff171B1B);
      }    „
      */
    list.add(Center(
      child: Container(
          height: 60,
          width: width - width / 100 * 9,
          padding: EdgeInsets.all(17),
          decoration: (BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          )),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: (width - width / 100 * 15) -
                    (width - width / 100 * 13) * 0.30,
                child: AutoSizeText(
                  (i + 1).toString() + ". " + favorites[i],
                  maxLines: 1,
                  minFontSize: 10,
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                  ),
                ),
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
