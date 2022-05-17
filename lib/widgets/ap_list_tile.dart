import 'package:flutter/material.dart';

import '../models/ride.dart';

class APListTile extends StatelessWidget {
  final int index;
  final Ride ride;
  final Function()? onTap;
  const APListTile({
    Key? key,
    required this.ride,
    required this.index,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: [
          Material(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(ride.startTime!),
                    Text(ride.endTime!),
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