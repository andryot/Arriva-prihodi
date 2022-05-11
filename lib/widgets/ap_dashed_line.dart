import 'package:flutter/material.dart';

class APDashedLine extends StatelessWidget {
  const APDashedLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: 2.5,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).primaryColor,
                    Colors.red,
                  ],
                ),
              ),
            ),
            Column(
              children: List.generate(
                9,
                (index) => Container(
                  height: 8,
                  color: index % 2 == 0
                      ? Colors.transparent
                      : Theme.of(context).backgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
