import 'dart:math';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/timetable/timetable_bloc.dart';
import '../style/theme.dart';
import 'ap_circle_button.dart';

class APSliverAppBar extends SliverPersistentHeaderDelegate {
  final double _maxExtent;
  final double _minExtent;

  final bool? _isFavorite;
  final String _from;
  final String _destination;
  final String _date;

  APSliverAppBar({
    required double maxExtent,
    required double minExtent,
    required String from,
    required String destination,
    required String date,
    required bool? isFavorite,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent,
        _isFavorite = isFavorite,
        _from = from,
        _destination = destination,
        _date = date,
        super();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double paddingTop = MediaQuery.of(context).padding.top;

    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);
    final double width = MediaQuery.of(context).size.width;
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;

    return Container(
      height: visibleMainHeight,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Theme.of(context).backgroundColor,
      ),
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // BACK BUTTON
            Align(
              alignment: Alignment(-1, max(0 - animationVal, -0.8)),
              child: CupertinoButton(
                onPressed: Navigator.of(context).pop,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),

            // HEART ICON
            Positioned(
              right: width * 0.07 - width * 0.03 * (1 - animationVal),
              child: SizedBox(
                width: 30 + animationVal * 20 + 8,
                height: 30 + animationVal * 20 + 8,
                child: APCircleButton(
                  elevation: 0,
                  icon: _isFavorite == true
                      ? CupertinoIcons.heart_solid
                      : CupertinoIcons.heart,
                  iconColor: Colors.red,
                  size: 30 + animationVal * 20,
                  onPressed: () =>
                      BlocProvider.of<TimetableBloc>(context).favorite(),
                ),
              ),
            ),
            // FROM TEXT
            Align(
              alignment: Alignment(-0.75 + 0.3 * animationVal,
                  (-0.8 + (1 - animationVal)).clamp(-0.8, 0)),
              child: SizedBox(
                width: width * 0.35 + width * 0.3 * animationVal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        _from + " edwqeqweqw",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 14 + 5 * animationVal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // VERTICAL DOTTED LINE
            Align(
              alignment: const Alignment(-0.4, -0.38),
              child: Opacity(
                opacity: ((animationVal - 0.7) / (1 - 0.7)).clamp(0, 1),
                child: SizedBox(
                  height: maxExtent * 0.22 - animationVal * 10,
                  width: width * 0.35 + width * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 7),
                    child: DottedLine(
                      direction: Axis.vertical,
                      dashGradient: [
                        Theme.of(context).primaryColor,
                        myColors.secondLocationColor!,
                      ],
                      lineThickness: 2.5,
                      dashGapLength: 5,
                      dashLength: 8,
                    ),
                  ),
                ),
              ),
            ),
            // HORIZONTAL DOTTED LINE
            /* Align(
              alignment: const Alignment(-0.05, 0),
              child: Opacity(
                opacity: ((.4 - animationVal) / (1 - .6)).clamp(0, 1),
                child: SizedBox(
                  width: width * 0.12 - animationVal * 10,
                  child: DottedLine(
                    direction: Axis.horizontal,
                    dashGradient: [
                      Theme.of(context).primaryColor,
                      myColors.secondLocationColor!,
                    ],
                    lineThickness: 2.5,
                    dashGapLength: 5,
                    dashLength: 8,
                  ),
                ),
              ),
            ), */
            // DESTINATION TEXT
            Align(
              alignment: Alignment(
                  -0.75 * animationVal +
                      0.3 * animationVal -
                      (-1 + animationVal) * 0.6,
                  0),
              child: SizedBox(
                width: width * 0.35 + width * 0.3 * animationVal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: myColors.secondLocationColor,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        _destination + "eqweqwe",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 14 + 5 * animationVal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(-0.73, .7),
              child: Opacity(
                  opacity: ((animationVal - 0.3) / (1 - 0.3)).clamp(0, 1),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        _date,
                        style: TextStyle(fontSize: 14 + 5 * animationVal),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  double scrollAnimationValue(double shrinkOffset) {
    final double maxScrollAllowed = maxExtent - minExtent;
    return ((maxScrollAllowed - shrinkOffset) / maxScrollAllowed)
        .clamp(0, 1)
        .toDouble();
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => _minExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
