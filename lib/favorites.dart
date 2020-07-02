import 'package:bus_time_table/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  void refresh() {
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(17.0),
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          getTextWidgets(),
        ],
      ),
    );
  }

  Widget getTextWidgets() {
    List<Widget> list = new List<Widget>();
    if (favorites.isNotEmpty) {
      for (var i = 0; i < favorites.length; i++) {
        List<String> temp = new List<String>();
        favorites[i].split("+").forEach((f) => temp.add(f));
        list.add(Container(
          decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(width: 1))),
          height: height * 0.055,
          child: Dismissible(
            background: slideRightBackground(),
            secondaryBackground: slideLeftBackground(),
            key: Key(favorites[i]),
            confirmDismiss: (confirmDismiss) async {
              final bool res = await showCupertinoDialog(
                context: context,
                builder: (context) => Theme(
                  data: ThemeData.dark(),
                  child: CupertinoAlertDialog(
                    title: new Text(
                      'Želite odstaniti priljubljeno relacijo?',
                      textAlign: TextAlign.center,
                    ),
                    actions: <Widget>[
                      CupertinoButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          "Prekliči",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      CupertinoButton(
                        onPressed: () => [
                          setState(() {
                            favorites.removeAt(i);
                          }),
                          Navigator.of(context).pop(true),
                          refresh()
                        ],
                        child: Text(
                          "Potrdi",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              return res;
            },
            child: Ink(
              child: InkWell(
                onTap: () => [
                  routesDeparture = temp[0],
                  routesDestination = temp[1],
                  FocusScope.of(context).requestFocus(new FocusNode()),
                  Navigator.of(context).push(new CupertinoPageRoute<bool>(
                    fullscreenDialog: true,
                    builder: (context) => AniRoute(),
                  )),
                  fetch(temp[0].toString(), temp[1].toString(), date)
                      .whenComplete(() => [
                            Navigator.pop(context),
                            Navigator.of(context)
                                .push(new CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (context) => SecondRoute(),
                            )),
                          ]),
                ],
                child: ListTile(
                  dense: true,
                  title: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: temp[0].toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black),
                      ),
                      WidgetSpan(
                        child: Icon(
                          EvaIcons.arrowForwardOutline,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: temp[1].toString(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ]),
                  ),
                ),
              ),

              /*Positioned(
                              right: 10,
                              child: Material(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.star),
                                        iconSize: 30,
                                        color: Colors.yellow,
                                        onPressed: () async {
                                          favorites.removeAt(i);
                                          refresh();
                                        },
                                      ),
                                    ],
                                  )),
                            ),*/
            ),
          ),
        ));
        list.add(new Container(
          height: height * 0.02,
        ));
      }
      return new Wrap(children: list);
    } else
      return Text("Seznam priljubljenih relacij je prazen!");
  }

  Widget slideRightBackground() {
    return Container(
      decoration: ShapeDecoration(
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          )),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: width * 0.04,
            ),
            Icon(
              Icons.delete,
              color: Theme.of(context).primaryColorLight,
            ),
            Text(
              " Izbriši",
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      decoration: ShapeDecoration(
          color: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          )),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Theme.of(context).primaryColorLight,
            ),
            Text(
              " Izbriši",
              style: TextStyle(
                color: Theme.of(context).primaryColorLight,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: width * 0.04,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }
}
