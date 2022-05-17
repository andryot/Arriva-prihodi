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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(routeStops.first.time),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const APCircle(color: Colors.red, radius: 10),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Text(routeStops.first.station)),
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
                  child: Text(routeStops[i].time),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const APCircle(color: Colors.amber, radius: 10),
              const SizedBox(
                width: 10,
              ),
              Expanded(child: Text(routeStops[i].station)),
            ],
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
                child: Text(routeStops.last.time),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const APCircle(color: Colors.red, radius: 10),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Text(routeStops.last.station)),
          ],
        ),
      ],
    );
  }
}
