import 'package:flutter/material.dart';

import '../models/ride.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Material(
            clipBehavior: Clip.hardEdge,
            shadowColor: Colors.grey,
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            //borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTap,
              onLongPress: onLongPress,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Text(
                        ride.from,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.arrow_forward),
                    Expanded(
                      child: Text(
                        ride.destination,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
