import 'package:flutter/cupertino.dart';

/// Provides color palette for EventPay app.
abstract class EPColor {
  /// Primary color. Used for filled buttons.
  static const CupertinoDynamicColor primary =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xff243048),
    darkColor: Color(0xffC4C4C4),
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
    color: Color(0xffC4C4C4),
    darkColor: Color(0xff0C1017),
  );

  static const CupertinoDynamicColor strong =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xff262626),
    darkColor: Color(0xffDCDCDC),
  );

  /// Color used for filled buttons that confirm actions and for success.
  static const Color confirm = CupertinoColors.activeGreen;

  // Color used for placeholder text
  static const CupertinoDynamicColor placeholderColor =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xffAEAEAE),
    darkColor: Color(0xffCECECE),
  );

  static const Color darkGrey = Color(0xff262626);

  /// Color used for filled buttons that confirm destructive actions and for
  /// failure.
  static const Color danger = CupertinoColors.destructiveRed;

  static const Color transparent = Color(0x00000000);

  static Color primaryColor(BuildContext context) {
    return CupertinoDynamicColor.resolve(EPColor.primary, context);
  }

  static Color resolveColor(BuildContext context, Color color) {
    return CupertinoDynamicColor.resolve(color, context);
  }

  static const Color yellow = Color(0xFFF3BE00);


  static const Color almostBlack = Color(0xFF0C1017);
  static const Color orange = Color(0xFFF75423);
  static const Color secondary = Color(0xFF466C6E);
  // static const /*  */
}
