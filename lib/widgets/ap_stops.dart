import 'package:flutter/material.dart';

import '../models/route_stop.dart';
import '../style/theme.dart';
import 'ap_circle.dart';

class ApStops extends StatelessWidget {
  final List<RouteStop> routeStops;
  final String from;
  final String destination;
  const ApStops({
    Key? key,
    required this.routeStops,
    required this.from,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  routeStops.first.time,
                  style: TextStyle(
                    fontSize: routeStops.first.station == from ? 20 : 14,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            APCircle(
              color: Theme.of(context).primaryColor,
              radius: routeStops.first.station == from ? 20 : 10,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                routeStops.first.station,
                style: TextStyle(
                  fontSize: routeStops.first.station == from ? 20 : 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 2,
          height: 30,
          color: Colors.amber,
        ),
        for (int i = 1; i < routeStops.length - 1; i++) ...[
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    routeStops[i].time,
                    style: TextStyle(
                      fontSize: routeStops[i].station == from ? 20 : 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              APCircle(
                  color: routeStops[i].station == from
                      ? Theme.of(context).brightness == Brightness.light
                          ? Colors.green
                          : Colors.red
                      : Colors.amber,
                  radius: routeStops[i].station == from ? 20 : 10),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  routeStops[i].station,
                  style: TextStyle(
                    fontSize: routeStops[i].station == from ? 20 : 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            width: 2,
            height: 30,
            color: Colors.amber,
          ),
        ],
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  routeStops.last.time,
                  style: TextStyle(
                    fontSize: routeStops.last.station == from ? 20 : 14,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            APCircle(
                color: myColors.secondLocationColor!,
                radius: routeStops.last.station == from ? 20 : 10),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Text(
              routeStops.last.station,
              style: TextStyle(
                fontSize: routeStops.last.station == from ? 20 : 14,
              ),
            )),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
