import 'package:cv/src/localizations/localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageSate createState() => _HomePageSate();
}

class _HomePageSate extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Text(Localization.of(context).homeWelcome),
      ),
    );
  }
}
