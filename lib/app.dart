import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'package:cv/pages/login_page.dart';
import 'package:cv/pages/home_page.dart';

class CVApp extends StatefulWidget {
  @override
  _CVAppState createState() => _CVAppState();
}

class _CVAppState extends State<CVApp> with SingleTickerProviderStateMixin {
  // Controller to coordinate both the opening/closing of backdrop and sliding
  // of expanding bottom sheet.
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
      value: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "CV Flutter",
      theme: _kCVTheme,
      home: LoginPage(),
    );
  }
}

final ThemeData _kCVTheme = _buildCVTheme();

ThemeData _buildCVTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kCVOrange,
    primaryColor: kCVBlue,
    buttonColor: kCVBlue,
    scaffoldBackgroundColor: kCVBackgroundWhite,
    cardColor: kCVBackgroundWhite,
    textSelectionColor: kCVPink,
    errorColor: kCVErrorRed,
    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.accent,
    ),
    primaryIconTheme: base.iconTheme.copyWith(color: kCVBlue),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    textTheme: _buildCVTextTheme(base.textTheme),
    primaryTextTheme: _buildCVTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildCVTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: kCVBlue);
}

TextTheme _buildCVTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        button: base.button.copyWith(
            fontWeight: FontWeight.w500, fontSize: 14.0, color: kCVWhite),
      )
      .apply(
        fontFamily: 'Google Sans',
        displayColor: kCVBlack,
        bodyColor: kCVBlack,
      );
}
