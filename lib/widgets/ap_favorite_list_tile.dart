import 'package:bus_time_table/widgets/ap_reorderable_start_listener.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

import '../models/ride.dart';
import '../style/theme.dart';

class APFavoriteListTile extends StatelessWidget {
  final int index;
  final Ride ride;
  final Function()? onTap;
  final Function()? onLongPress;

  const APFavoriteListTile({
    Key? key,
    required this.ride,
    required this.index,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return Card(
      key: key,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Theme.of(context).backgroundColor,
      //surfaceTintColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shadowColor: Theme.of(context).backgroundColor.withOpacity(.8),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  ride.from,
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 5),
              Flexible(
                child: DottedLine(
                  dashGradient: [
                    Theme.of(context).primaryColor,
                    myColors.secondLocationColor!,
                  ],
                  lineThickness: 2.5,
                  dashGapLength: 5,
                  dashLength: 8,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.location_on,
                color: myColors.secondLocationColor,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  ride.destination,
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 5),
              APReorderableDragStartListener(
                index: index,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    const Icon(
                      Icons.drag_handle,
                      size: 24,
                    ),
                    Container(
                      color: Colors.transparent,
                      width: 35,
                      height: 35,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
