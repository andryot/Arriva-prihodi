import 'package:bus_time_table/bloc/timetable/timetable_bloc.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/ride.dart';
import '../style/theme.dart';

class APListTile extends StatelessWidget {
  final int index;
  final Ride ride;
  final Function()? onTap;
  final TimetableBloc blocProvider;
  const APListTile({
    Key? key,
    required this.ride,
    required this.index,
    required this.blocProvider,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      blocProvider.calculateScroll();
    });
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Material(
            color: Theme.of(context).backgroundColor,
            clipBehavior: Clip.hardEdge,
            shadowColor: Colors.grey,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            //borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    Icon(
                      Icons.access_time,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 5),
                    Text(ride.startTime!),
                    const SizedBox(width: 30),
                    Flexible(
                      child: DottedLine(
                        lineThickness: 2.5,
                        dashGradient: [
                          Theme.of(context).primaryColor,
                          myColors.secondLocationColor!,
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Icon(
                      CupertinoIcons.time,
                      color: myColors.secondLocationColor,
                    ),
                    const SizedBox(width: 5),
                    Text(ride.endTime!),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
