import 'package:bus_time_table/HomePage.dart';
import 'package:flutter/cupertino.dart';
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
    //var myGroup = AutoSizeGroup();

    List<Widget> list = new List<Widget>();
    if (favorites.isNotEmpty) {
      for (var i = 0; i < favorites.length; i++) {
        List<String> temp = new List<String>();
        favorites[i].split("+").forEach((f) => temp.add(f));
        list.add(
          Dismissible(
              key: Key(favorites[i]),
              confirmDismiss: (confirmDismiss) => (showCupertinoDialog(context: context, builder: (context) => Theme(
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
                  onPressed: () => Navigator.of(context).pop(true),
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
          ),)),
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
                  title: Stack(
                      alignment: FractionalOffset.center,
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            width: width * 0.6,
                            color: Colors.red,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: width * 0.3,
                                  child: AutoSizeText(
                                    " " + temp[0].toString(),
                                    maxLines: 1,
                                    minFontSize: 15,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 5, left: 5),
                                  child: Icon(
                                    EvaIcons.arrowForwardOutline,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  width: width * 0.3,
                                  child: AutoSizeText(
                                    temp[1].toString(),
                                    maxLines: 1,
                                    minFontSize: 15,
                                    //maxFontSize: 40,
                                    //group: myGroup,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Theme.of(context).primaryColorDark),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                //),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
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
                        ),
                      ]),
                ),
              )),
        );
        list.add(new Container(
          height: height * 0.02,
        ));
      }
      return new Wrap(children: list);
    } else
      return Text("Seznam priljubljenih relacij je prazen!");
  }
}
