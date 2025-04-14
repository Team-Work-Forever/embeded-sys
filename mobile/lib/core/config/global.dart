import 'package:flutter/material.dart';
import 'package:mobile/core/config/fonts.dart';

final class AppColor {
  // Widget Colors
  static const Color widgetBackground = Color.fromRGBO(246, 249, 252, 1);
  static const Color widgetBackgroundBlurry = Color.fromRGBO(246, 249, 252, 66);

  static const Color primaryColor = Color.fromRGBO(0, 48, 73, 1);
  static const Color secondaryColor = Color.fromRGBO(106, 119, 138, 1);
  static const Color separatedLine = Color.fromRGBO(235, 237, 240, 1);
  static const Color buttonBackground = Color.fromRGBO(26, 65, 87, 1);
  static const Color disabledButton = Color.fromRGBO(106, 119, 138, 1);

  static const Color shadowColor = Color.fromRGBO(66, 71, 76, 0.08);
  static const Color subtracted = Color.fromRGBO(235, 237, 240, 75);

  // State Colors
  static const Color free = Color.fromRGBO(73, 154, 86, 1);
  static const Color occupied = Color.fromRGBO(163, 22, 33, 1);
  static const Color reserved = Color.fromRGBO(0, 48, 73, 1);
  static const Color emergency = Color.fromRGBO(252, 163, 17, 1);
  static const Color notDefined = Color.fromRGBO(106, 119, 138, 1);

  // Others
  static const Color strongRed = Color.fromRGBO(120, 0, 0, 1);

  // Notifications Colors
  static const Color primaryError = Color.fromRGBO(255, 97, 102, 1);
  static const Color error = Color.fromRGBO(255, 58, 65, 1);

  static const Color primaryWarning = Color.fromRGBO(245, 164, 74, 1);
  static const Color warning = Color.fromRGBO(242, 143, 30, 1);

  static const Color primaryInfo = Color.fromRGBO(0, 161, 223, 1);
  static const Color info = Color.fromRGBO(0, 113, 255, 1);
}

final class AppBoxDecoration {
  static const Radius radius5 = Radius.circular(5);
  static const Radius radius7 = Radius.circular(7);
  static const Radius radius10 = Radius.circular(10);
  // BorderRadius
  static const BorderRadius borderRadius5 = BorderRadius.all(radius5);
  static const BorderRadius borderRadius7 = BorderRadius.all(radius7);
  static const BorderRadius borderRadius10 = BorderRadius.all(radius10);

  static const BoxShadow defaultShadow = BoxShadow(
    color: AppColor.shadowColor,
    blurRadius: 10,
    spreadRadius: 0.0,
  );
}

// Text Sizes
final class TextSizes {
  static const double title_64 = 64;
  static const double title_48 = 48;
  static const double title1 = 32;
  static const double title2 = 24;
  static const double title3 = 20;
  static const double title4 = 16;
  static const double title5 = 14;
  static const double title6 = 12;
  static const double title7 = 10;
  static const double title8 = 8;
}

final class AppText {
  static TextStyle customStyle({
    Color color = AppColor.secondaryColor,
    double fontSize = TextSizes.title3,
    FontWeight fontWeight = FontWeight.bold,
    TextDecoration decoration = TextDecoration.none,
    String font = AppFonts.lato,
  }) {
    assert(
      font != AppFonts.bowlbyOne,
      'AppFonts.bowlbyOne must be used only with AppText.bowlbyOne()',
    );

    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      decoration: decoration,
      fontFamily: font,
    );
  }

  static TextStyle bowlbyOne({
    Color color = AppColor.secondaryColor,
    double fontSize = TextSizes.title3,
    TextDecoration decoration = TextDecoration.none,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      decoration: decoration,
      fontFamily: AppFonts.bowlbyOne,
    );
  }
}
