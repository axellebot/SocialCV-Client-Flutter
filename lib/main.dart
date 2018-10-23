import 'package:flutter/material.dart';
import 'package:cv/pages/login_page.dart';

void main() => runApp(new CVApp());

class CVApp extends StatelessWidget {
  final String title = 'Social CV';
  final ThemeData theme = new ThemeData(
    primarySwatch: Colors.blue,
    accentColor: Colors.deepOrange,
    // Set background color
    backgroundColor: Colors.white30,
  );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: title,
      theme: theme,
      home: new LoginPage(),
    );
  }
}
