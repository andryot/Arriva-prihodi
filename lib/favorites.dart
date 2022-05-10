import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'config.dart';
import 'data_fetch.dart';
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
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        getTextWidgets(),
      ],
    );
  }

  Widget getTextWidgets() {
    List<Widget> list = [];
    if (favorites.isNotEmpty) {
      for (var i = 0; i < favorites.length; i++) {
        List<String> temp = [];
        favorites[i].split("+").forEach((f) => temp.add(f));
        list.add(
          Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(width: 1))),
            height: pixelsVertical > 1750
                ? height *
                    (height > 600
                        ? pixelsVertical > 2500
                            ? 0.019
                            : 0.023
                        : 0.020) *
                    MediaQuery.of(context).devicePixelRatio
                : height *
                    (pixelsVertical > 900 ? 0.034 : 0.042) *
                    MediaQuery.of(context).devicePixelRatio,
            //height: height > 650 ? height *0.023 *MediaQuery.of(context).devicePixelRatio : height *0.034 *MediaQuery.of(context).devicePixelRatio, // MediaQuery.of(context).size.height < 750 ? 55 : 60,,
            child: Dismissible(
              background: slideRightBackground(),
              secondaryBackground: slideLeftBackground(),
              key: Key(favorites[i]),
              confirmDismiss: (confirmDismiss) async {
                final bool res = await showCupertinoDialog(
                  context: context,
                  builder: (context) => Theme(
                    data: currentTheme.themeData,
                    child: CupertinoAlertDialog(
                      title: new Text(
                        'Želite odstraniti priljubljeno relacijo?',
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
                          onPressed: () async => await deleteFavorite(i),
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
                child: Center(
                  child: ListTile(
                    leading: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(
                          text: temp[0].toString(),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        WidgetSpan(
                          child: Icon(
                            EvaIcons.arrowForwardOutline,
                            color: Colors.black,
                            size: 18,
                          ),
                        ),
                        TextSpan(
                          text: temp[1].toString(),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
        list.add(new Container(
          height: height * 0.02,
        ));
      }
      return new Wrap(children: list);
    } else
      return Text(
          "Seznam priljubljenih relacij je prazen! \nRelacijo dodaš s pritiskom na zvezdico v desnem zgornem kotu!");
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

  deleteFavorite(int i) async {
    final prefs = await SharedPreferences.getInstance();
    favorites.removeAt(i);
    await prefs.remove("favorites");
    await prefs.setStringList("favorites", favorites);
    await prefs.reload();
    Navigator.of(context).pop(true);
    refresh();
  }
}
