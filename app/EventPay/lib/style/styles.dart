import 'package:flutter/cupertino.dart';

import 'colors.dart';

/// Provides text styles for EventPay app.
abstract class EPStyles {
  static const CupertinoTextThemeData textTheme = CupertinoTextThemeData(
    primaryColor: EPColor.primary,
    textStyle: TextStyle(
      color: EPColor.primary,
      fontFamily: 'Roboto',
      fontSize: 12,
    ),
  );

  static TextStyle cardStrongTextStyle(BuildContext context) {
    return TextStyle(
      color: CupertinoDynamicColor.resolve(EPColor.strong, context),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle cardNormalTextStyle(BuildContext context) {
    return TextStyle(
      color: CupertinoDynamicColor.resolve(EPColor.strong, context),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle pageTitleTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: CupertinoDynamicColor.resolve(EPColor.primary, context),
      fontSize: 24,
    );
  }

  static TextStyle buttonTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: CupertinoDynamicColor.resolve(EPColor.primary, context),
      fontSize: 18,
    );
  }

  static TextStyle listTileTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.normal,
      color: CupertinoDynamicColor.resolve(EPColor.primary, context),
      fontSize: 18,
    );
  }

  static TextStyle noOffersTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: CupertinoDynamicColor.resolve(EPColor.strong, context),
      fontSize: 12,
    );
  }

  static TextStyle segmentControlTextStyle(
      BuildContext context, bool selected) {
    return TextStyle(
      fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
      color: CupertinoDynamicColor.resolve(
        selected ? EPColor.primary : EPColor.strong,
        context,
      ),
    );
  }

  static TextStyle profileNameAndNumbersTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: CupertinoDynamicColor.resolve(EPColor.strong, context),
      fontSize: 22,
    );
  }

  static TextStyle joinedTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w400,
      color: CupertinoDynamicColor.resolve(
        EPColor.primaryContrastingColor,
        context,
      ),
      fontSize: 14,
    );
  }

  static TextStyle profileRowTextStyle(BuildContext context) {
    return TextStyle(
      fontWeight: FontWeight.w500,
      color: CupertinoDynamicColor.resolve(EPColor.strong, context),
      fontSize: 18,
    );
  }
}
