import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/timetable/timetable_bloc.dart';

class APSliverAppBar extends SliverPersistentHeaderDelegate {
  final double _maxExtent;
  final double _minExtent;

  final bool? _isFavorite;
  final String _from;
  final String _destination;

  APSliverAppBar({
    required double maxExtent,
    required double minExtent,
    required String from,
    required String destination,
    required bool? isFavorite,
  })  : _maxExtent = maxExtent,
        _minExtent = minExtent,
        _isFavorite = isFavorite,
        _from = from,
        _destination = destination,
        super();

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double visibleMainHeight = max(maxExtent - shrinkOffset, minExtent);
    final double animationVal = scrollAnimationValue(shrinkOffset);
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(
        left: 20 * animationVal,
        right: 20 * animationVal,
      ),
      child: SizedBox(
        height: visibleMainHeight,
        width: width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 10 * animationVal, bottom: 23 * animationVal),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20 * animationVal),
                  color: Theme.of(context).backgroundColor,
                ),
              ),
            ),
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
              right: 10,
              child: CupertinoButton(
                child: Icon(
                  _isFavorite == true
                      ? CupertinoIcons.heart_solid
                      : CupertinoIcons.heart,
                  color: Colors.red,
                  size: 30 + animationVal * 20,
                ),
                onPressed: () =>
                    BlocProvider.of<TimetableBloc>(context).favorite(),
              ),
            ),
            // FROM TEXT
            Align(
              alignment: Alignment(max(-1.0 + animationVal, -0.6),
                  (-0.5 + (1 - animationVal)).clamp(-0.5, 0)),
              child: Text(
                _from,
                style: TextStyle(fontSize: 19 + 5 * animationVal),
              ),
            ),
            Transform.rotate(
              angle: pi + animationVal * pi / 2,
              child: Icon(
                Icons.arrow_back,
                size: 25 + animationVal * 5,
              ),
            ),
            Align(
              alignment: Alignment(min(1 - animationVal, 0.4),
                  (0.3 - (1 - animationVal)).clamp(0, 0.3)),
              child: Text(
                _destination,
                style: TextStyle(fontSize: 19 + 5 * animationVal),
              ),
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
