import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData apThemeDark = ThemeData.dark().copyWith(
  useMaterial3: true,
  primaryColor: APColor.primary.darkColor,
  splashColor: APColor.primary.darkColor,
  cardColor: APColor.backgroudColor.darkColor,
  scaffoldBackgroundColor: APColor.backgroud.darkColor,
  canvasColor: Colors.transparent,
  backgroundColor: APColor.backgroudColor.darkColor,
  textSelectionTheme:
      TextSelectionThemeData(cursorColor: APColor.primary.darkColor),
  extensions: <ThemeExtension<dynamic>>[
    MyColors(
      textFieldBackground: APColor.textfield.darkColor,
      secondLocationColor: Colors.yellow,
      labelColor: Colors.white,
      expiredRideColor: APColor.expiredRideColor.darkColor,
    ),
  ],
);

final ThemeData apThemeLight = ThemeData.light().copyWith(
  useMaterial3: true,
  primaryColor: APColor.primary.color,
  splashColor: APColor.primary.color,
  cardColor: APColor.backgroud.color,
  canvasColor: Colors.transparent,
  scaffoldBackgroundColor: APColor.backgroud.color,
  backgroundColor: APColor.backgroudColor.color,
  textSelectionTheme:
      TextSelectionThemeData(cursorColor: APColor.primary.color),
  extensions: <ThemeExtension<dynamic>>[
    MyColors(
      textFieldBackground: APColor.textfield.color,
      secondLocationColor: Colors.red,
      labelColor: Colors.black,
      expiredRideColor: APColor.expiredRideColor.color,
    ),
  ],
);

@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.textFieldBackground,
    required this.secondLocationColor,
    this.labelColor,
    this.expiredRideColor,
  });

  final Color? textFieldBackground;
  final Color? secondLocationColor;
  final Color? labelColor;
  final Color? expiredRideColor;

  @override
  MyColors copyWith({
    Color? textFieldBackground,
    Color? secondLocationColor,
    Color? labelColor,
    Color? expiredRideColor,
  }) {
    return MyColors(
      textFieldBackground: textFieldBackground ?? this.textFieldBackground,
      secondLocationColor: secondLocationColor ?? this.secondLocationColor,
      labelColor: labelColor ?? this.labelColor,
      expiredRideColor: expiredRideColor ?? this.expiredRideColor,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      textFieldBackground:
          Color.lerp(textFieldBackground, other.textFieldBackground, t),
      secondLocationColor:
          Color.lerp(secondLocationColor, other.secondLocationColor, t),
      labelColor: Color.lerp(labelColor, other.labelColor, t),
      expiredRideColor: Color.lerp(expiredRideColor, other.expiredRideColor, t),
    );
  }
}
