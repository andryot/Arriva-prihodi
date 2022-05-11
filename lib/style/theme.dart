import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData apThemeDark = ThemeData.dark().copyWith(
  primaryColor: APColor.primary.darkColor,
  scaffoldBackgroundColor: APColor.backgroud.darkColor,
  backgroundColor: APColor.backgroudColor.darkColor,
  highlightColor: APColor.highlightColor.color,
);

final ThemeData apThemeLight = ThemeData.light().copyWith(
  primaryColor: APColor.primary.color,
  backgroundColor: APColor.backgroudColor.color,
  highlightColor: APColor.highlightColor.darkColor,
);
