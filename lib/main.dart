import 'package:flutter/material.dart';
import 'package:cv/pages/MainPage.dart';

void main() => runApp(new CVApp());

class CVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MainPage(),
    );
  }
}
