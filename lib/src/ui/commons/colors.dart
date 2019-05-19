import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  /// Colors
  static const Color colorBlue = Colors.blue;
  static const Color colorOrange = Colors.deepOrange;
  static const Color colorPink = Colors.pink;
  static const Color white = Colors.white;
  static const Color colorBlack = Colors.black;

  /// Misc Colors
  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.yellow;
  static const Color errorColor = Colors.red;

  ///Basics
  static const Color primaryColor = const Color(0xFF2196f3);
  static const Color primaryColorLight = const Color(0xFF6ec6ff);
  static const Color primaryColorDark = const Color(0xFF0069c0);
  static const Color textOnPrimary = const Color(0xFFFFFFFF);
  static const Color accentColor = const Color(0xFFFF5722);
  static const Color accentColorLight = const Color(0xFFff8a50);
  static const Color accentColorDark = const Color(0xFFc41c00);
  static const Color textOnAccent = const Color(0xFFFFFFFF);

  static const Color backgroundColor = const Color(0xFFFFFFFF);
  static const Color backgroundColorLight = backgroundColor;
  static const Color backgroundColorDark = const Color(0xFF353A3A);

  ///Cards
  static const Color cardBackgroundColor = const Color(0xFFFFFFFF);
  static const Color cardBackgroundColorLight = backgroundColor;
  static const Color cardBackgroundColorDark = const Color(0xFF353A3A);

  /// Auth Stuff
  static const Color loginGradientEnd = primaryColorLight;
  static const Color loginGradientStart = primaryColorDark;
}
