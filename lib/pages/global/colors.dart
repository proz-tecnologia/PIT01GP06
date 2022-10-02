import 'dart:ui';

import 'package:flutter/material.dart';

class MyColor{
  MyColor._();

  static const Map<int, Color> ltColor = {
    50:  Color.fromRGBO(100, 78, 78, .1),
    100:  Color.fromRGBO(100, 78, 78, .2),
    200:  Color.fromRGBO(100, 78, 78, .3),
    300:  Color.fromRGBO(100, 78, 78, .4),
    400:  Color.fromRGBO(100, 78, 78, .5),
    500:  Color.fromRGBO(100, 78, 78, .6),
    600:  Color.fromRGBO(100, 78, 78, .7),
    700:  Color.fromRGBO(100, 78, 78, .8),
    800:  Color.fromRGBO(100, 78, 78, .9),
    900:  Color.fromRGBO(100, 78, 78, 1),
  };

  static const Map<int, Color> dtColor = {
    50:  Color.fromRGBO(100, 60, 70, .1),
    100:  Color.fromRGBO(100,60, 70, .2),
    200:  Color.fromRGBO(100, 60, 70, .3),
    300:  Color.fromRGBO(100, 60, 70, .4),
    400:  Color.fromRGBO(100, 60, 70, .5),
    500:  Color.fromRGBO(100, 60, 70, .6),
    600:  Color.fromRGBO(100, 60, 70, .7),
    700:  Color.fromRGBO(100, 60, 70, .8),
    800:  Color.fromRGBO(100, 60, 70, .9),
    900:  Color.fromRGBO(100, 60, 70, 1),
  };

  static const Color red = Color(0xFFD9373A);

  static const MaterialColor ltPrimaryColor = MaterialColor(0xFFFFC6C7, ltColor);
  static const Color ltBackgroundColor = Color (0xFFFAEEE7);
  static const Color ltAccentColor = Color (0xFF679D40);
  static const Color ltIconsandTextColor = Color (0xFF33272A);
  static const Color ltsecondaryTextColor = Color(0xFF594A4E);

  static const MaterialColor dtPrimaryColor = MaterialColor(0xFFFF99B2, dtColor);
  static const Color dtBackgroundColor = Color(0xFF2C3E47);
  static const Color dtAccentColor = Color(0xFF2B4E11);
  static const Color dtIconsandTextColor = Color (0xFF100F10);
}