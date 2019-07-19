import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/ui/commons/styles.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

class HomePage extends StatelessWidget {
  final String _tag = '$HomePage';

  HomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return SafeArea(
      left: false,
      right: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              elevation: AppStyles.cardDefaultElevation,
              child: Container(
                padding: AppStyles.cardDefaultPadding,
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
