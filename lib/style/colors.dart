import 'package:flutter/cupertino.dart';

/// Provides color palette for Vectura app.
abstract class APColor {
  /// Primary color. Used for filled buttons.
  static const CupertinoDynamicColor primary =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xff001898),
    darkColor: Color(0xff00A7DC),
  );

  static const CupertinoDynamicColor primaryContrastingColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xffAEAEAE),
    darkColor: Color(0xffCECECE),
  );

  static const CupertinoDynamicColor highlightColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xffffffff),
    darkColor: Color(0xff000000),
  );

  static const CupertinoDynamicColor backgroud =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xffF2F2F2),
    darkColor: Color(0xff181818),
  );

  static const CupertinoDynamicColor strong =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xff262626),
    darkColor: Color(0xffDCDCDC),
  );

  static const CupertinoTextThemeData textTheme = CupertinoTextThemeData(
    primaryColor: primary,
    textStyle: TextStyle(color: primary, fontFamily: 'Roboto', fontSize: 12),
  );

  /// Color used for filled buttons that confirm actions and for success.
  static const Color confirm = CupertinoColors.activeGreen;

  // Color used for placeholder text
  static const Color placeholderColor = Color(0xffAEAEAE);

  static const Color darkGrey = Color(0xff262626);

  static const TextStyle cardStrongTextStyle =
      TextStyle(color: strong, fontWeight: FontWeight.w600);
  static const TextStyle cardNormalTextStyle =
      TextStyle(color: strong, fontWeight: FontWeight.normal);

  /// Color used for filled buttons that confirm destructive actions and for
  /// failure.
  static const Color danger = CupertinoColors.destructiveRed;

  static const Color transparent = Color(0x00000000);
}
