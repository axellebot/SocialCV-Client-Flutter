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
    print('Building HomePage');
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Container(
                padding: EdgeInsets.all(25.0),
                child: Text(
                  Localization.of(context).homeWelcome,
                  style: Theme.of(context).textTheme.body2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
