import 'package:flutter/material.dart';

import '../style/theme.dart';

class APDashedLine extends StatelessWidget {
  const APDashedLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MyColors myColors = Theme.of(context).extension<MyColors>()!;
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
                    myColors.secondLocationColor!,
                  ],
                ),
              ),
            ),
            ClipRRect(
              child: Column(
                children: List.generate(
                  // TODO: make this dynamic
                  9,
                  (index) => Container(
                    width: 3,
                    height: 8,
                    color: index % 2 == 0
                        ? Colors.transparent
                        : Theme.of(context).backgroundColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
