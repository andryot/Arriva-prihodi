import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData apThemeDark = ThemeData.dark().copyWith(
  useMaterial3: true,
  primaryColor: APColor.primary.darkColor,
  scaffoldBackgroundColor: APColor.backgroud.darkColor,
  backgroundColor: APColor.backgroudColor.darkColor,
  highlightColor: APColor.highlightColor.color,
  textSelectionTheme:
      TextSelectionThemeData(cursorColor: APColor.primary.darkColor),
  extensions: <ThemeExtension<dynamic>>[
    MyColors(
      textFieldBackground: APColor.textfield.darkColor,
      secondLocationColor: Colors.yellow,
    ),
  ],
);

final ThemeData apThemeLight = ThemeData.light().copyWith(
  useMaterial3: true,
  primaryColor: APColor.primary.color,
  backgroundColor: APColor.backgroudColor.color,
  highlightColor: APColor.highlightColor.darkColor,
  textSelectionTheme:
      TextSelectionThemeData(cursorColor: APColor.primary.color),
  extensions: <ThemeExtension<dynamic>>[
    MyColors(
      textFieldBackground: APColor.textfield.color,
      secondLocationColor: Colors.red,
    ),
  ],
);

@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors({
    required this.textFieldBackground,
    required this.secondLocationColor,
  });

  final Color? textFieldBackground;
  final Color? secondLocationColor;

  @override
  MyColors copyWith({
    Color? textFieldBackground,
  }) {
    return MyColors(
      textFieldBackground: textFieldBackground ?? this.textFieldBackground,
      secondLocationColor: secondLocationColor ?? this.secondLocationColor,
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
    );
  }

  // Optional
  @override
  String toString() => 'MyColors(textFieldBackground: $textFieldBackground';
}
