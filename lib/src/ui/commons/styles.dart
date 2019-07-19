import 'dart:ui';

import 'package:flutter/material.dart';

class AppStyles {
  /// --------------------------------------------------------------------------
  ///                           Commons Colors
  /// --------------------------------------------------------------------------

  static const Color colorBlue = Colors.blue;
  static const Color colorOrange = Colors.deepOrange;
  static const Color colorPink = Colors.pink;
  static const Color colorWhite = Colors.white;
  static const Color colorBlack = Colors.black;

  /// --------------------------------------------------------------------------
  ///                           Commons Colors
  /// --------------------------------------------------------------------------

  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.yellow;
  static const Color errorColor = Colors.red;

  /// --------------------------------------------------------------------------
  ///                            Basic Colors
  /// --------------------------------------------------------------------------

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
  static const Color backgroundColorDark = const Color(0xFF3A3A3A);

  /// --------------------------------------------------------------------------
  ///                           Default dimensions
  /// --------------------------------------------------------------------------

  static const double defaultCardElevation = 2.0;
  static const EdgeInsets defaultCardPadding = EdgeInsets.all(15.0);
  static const EdgeInsets defaultFormInputPadding = EdgeInsets.all(15.0);

  /// --------------------------------------------------------------------------
  ///                                Card
  /// --------------------------------------------------------------------------

  static const Color cardBackgroundColor = const Color(0xFFFFFFFF);
  static const Color cardBackgroundColorLight = backgroundColor;
  static const Color cardBackgroundColorDark = const Color(0xFF353A3A);

  static const double cardDefaultElevation = 2.0;
  static const EdgeInsets cardDefaultPadding = EdgeInsets.all(20.0);

  /// Sort Dialog

  static const double sortDialogWidth = 200.0;
  static const double sortDialogHeight = 300.0;

  /// --------------------------------------------------------------------------
  ///                                List
  /// --------------------------------------------------------------------------

  static const double listHeaderDefaultHeightMax = 40.0;
  static const double listHeaderDefaultHeightMin = 40.0;

  /// --------------------------------------------------------------------------
  ///                                App
  /// --------------------------------------------------------------------------

  static const double appMenuButtonVerticalPadding = 3.0;

  /// --------------------------------------------------------------------------
  ///                                Auth
  /// --------------------------------------------------------------------------

  static const double authPageMinHeight = 800.0;
  static const Color authLoginGradientEnd = primaryColorLight;
  static const Color authLoginGradientStart = primaryColorDark;

  /// --------------------------------------------------------------------------
  ///                          Element Profile
  /// --------------------------------------------------------------------------

  static const double profileAvatarMin = 5.0;
  static const double profileAvatarMax = 50.0;
  static const double profileAvatarElevation = 2.0;

  /// --------------------------------------------------------------------------
  ///                          Element Part
  /// --------------------------------------------------------------------------

  /// --------------------------------------------------------------------------
  ///                          Element Group
  /// --------------------------------------------------------------------------

  static const double groupHorizontalPadding = 5.0;
  static const double groupHorizontalListHeight = 300.0;

  /// --------------------------------------------------------------------------
  ///                          Element Entry
  /// --------------------------------------------------------------------------

  static const EdgeInsets entryPadding = const EdgeInsets.all(10.0);
  static const double entryTagSpacing = 4.0;
  static const double entryCardElevation = 2.0;
  static const double entryEventHeight = 200.0;
  static const double entryEventHWidth = 300.0;

  static const double entryHorizontalListHeight = entryEventHeight;
}
