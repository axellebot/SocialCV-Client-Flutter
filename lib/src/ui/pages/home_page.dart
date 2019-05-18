import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

class HomePage extends StatelessWidget {
  final String _tag = '$HomePage';

  HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('$_tag:$build');
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
                  CVLocalizations.of(context).homeWelcome,
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
