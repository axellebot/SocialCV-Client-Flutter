import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  ///Colors
  static const Color kCVBlue = Colors.blue;
  static const Color kCVOrange = Colors.deepOrange;
  static const Color kCVPink = Colors.pink;
  static const Color kCVWhite = Colors.white;
  static const Color kCVBlack = Colors.black;

  ///Basics
  static const Color kCVPrimaryColor = const Color(0xFF2196f3);
  static const Color kCVPrimaryColorLight = const Color(0xFF6ec6ff);
  static const Color kCVPrimaryColorDark = const Color(0xFF0069c0);
  static const Color kCVTextOnPrimary = const Color(0xFFFFFFFF);
  static const Color kCVAccentColor = const Color(0xFFFF5722);
  static const Color kCVAccentColorLight = const Color(0xFFff8a50);
  static const Color kCVAccentColorDark = const Color(0xFFc41c00);
  static const Color kCVTextOnAccent = const Color(0xFFFFFFFF);

  static const Color kCVBackgroundColor = const Color(0xFFFFFFFF);
  static const Color kCVBackgroundColorLight = kCVBackgroundColor;
  static const Color kCVBackgroundColorDark = const Color(0xFF353A3A);

  ///Cards
  static const Color kCVCardBackgroundColor = const Color(0xFFFFFFFF);
  static const Color kCVCardBackgroundColorLight = kCVBackgroundColor;
  static const Color kCVCardBackgroundColorDark = const Color(0xFF353A3A);

  /// Misc
  static const Color kCVErrorRed = Colors.red;

  /// Auth Stuff
  static const Color loginGradientEnd = kCVPrimaryColorLight;
  static const Color loginGradientStart = kCVPrimaryColorDark;
}
