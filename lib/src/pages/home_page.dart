import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('Building HomePage');
    return SafeArea(
      left: false,
      right: false,
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
