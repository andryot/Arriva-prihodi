import 'package:flutter/material.dart';

import '../models/route_stop.dart';
import 'ap_circle.dart';

class ApStops extends StatelessWidget {
  final List<RouteStop> routeStops;
  const ApStops({
    Key? key,
    required this.routeStops,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // TIMES
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (RouteStop stop in routeStops) ...[
                Text(stop.time),
                const SizedBox(
                  height: 40,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        // DOTS
        Column(
          children: [
            const APCircle(color: Colors.red, radius: 10),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 2,
              height: 40,
              color: Colors.amberAccent,
            ),
            const SizedBox(
              height: 5,
            ),
            for (int i = 1; i < routeStops.length - 1; i++) ...[
              const APCircle(color: Colors.amber, radius: 10),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 2,
                height: 40,
                color: Colors.amberAccent,
              ),
              const SizedBox(
                height: 5,
              ),
            ],
            const APCircle(color: Colors.red, radius: 10),
          ],
        ),
        const SizedBox(
          width: 20,
        ),
        // STATIONS
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (RouteStop stop in routeStops) ...[
                Text(stop.station),
                const SizedBox(
                  height: 40,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
