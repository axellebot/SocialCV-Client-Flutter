import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';

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
//    primaryIconTheme: base.iconTheme.copyWith(color: kShrineBrown900),
//    inputDecorationTheme: InputDecorationTheme(border: CutCornersBorder()),
//    textTheme: _buildShrineTextTheme(base.textTheme),
//    primaryTextTheme: _buildShrineTextTheme(base.primaryTextTheme),
//    accentTextTheme: _buildShrineTextTheme(base.accentTextTheme),
//    iconTheme: _customIconTheme(base.iconTheme),
  );
}
