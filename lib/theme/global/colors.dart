import 'package:flutter/material.dart';

class MyColor {
  MyColor._();

  static const Map<int, Color> lightThemeColor = {
    50: Color.fromRGBO(100, 78, 78, .1),
    100: Color.fromRGBO(100, 78, 78, .2),
    200: Color.fromRGBO(100, 78, 78, .3),
    300: Color.fromRGBO(100, 78, 78, .4),
    400: Color.fromRGBO(100, 78, 78, .5),
    500: Color.fromRGBO(100, 78, 78, .6),
    600: Color.fromRGBO(100, 78, 78, .7),
    700: Color.fromRGBO(100, 78, 78, .8),
    800: Color.fromRGBO(100, 78, 78, .9),
    900: Color.fromRGBO(100, 78, 78, 1),
  };

  static const Map<int, Color> darkThemeColor = {
    50: Color.fromRGBO(100, 60, 70, .1),
    100: Color.fromRGBO(100, 60, 70, .2),
    200: Color.fromRGBO(100, 60, 70, .3),
    300: Color.fromRGBO(100, 60, 70, .4),
    400: Color.fromRGBO(100, 60, 70, .5),
    500: Color.fromRGBO(100, 60, 70, .6),
    600: Color.fromRGBO(100, 60, 70, .7),
    700: Color.fromRGBO(100, 60, 70, .8),
    800: Color.fromRGBO(100, 60, 70, .9),
    900: Color.fromRGBO(100, 60, 70, 1),
  };

  static const Color red = Color(0xFFD9373A);

  static const MaterialColor lightThemePrimaryColor =
      MaterialColor(0xFFFFC6C7, lightThemeColor);
  static const Color lightThemeBackgroundColor = Color(0xFFFAEEE7);
  static const Color lightThemeAccentColor = Color(0xFF679D40);
  static const Color lightThemeIconsandTextColor = Color(0xFF33272A);
  static const Color lightThemesecondaryTextColor = Color(0xFF594A4E);
  static const Color lightThemeButtonSecondary = Color(0xffff8ba7);

  static const MaterialColor darkThemePrimaryColor =
      MaterialColor(0xFFFF99B2, darkThemeColor);
  static const Color darkThemeBackgroundColor = Color(0xFF2C3E47);
  static const Color darkThemeAccentColor = Color(0xFF2B4E11);
  static const Color darkThemeIconsandTextColor = Color(0xFF100F10);
  static const Color darkThemeCardColor = Color(0xFF49484B);
  static const Color darkThemeButtonSecondary = Color(0xffFFC6C7);
}
