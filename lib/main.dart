import 'package:flutter/material.dart';
import 'package:cv/pages/home_page.dart';

void main() => runApp(new CVApp());

class CVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepOrange,
        // Set background color
        backgroundColor: Colors.white30,
      ),
      home: new HomePage(),
    );
  }
}
