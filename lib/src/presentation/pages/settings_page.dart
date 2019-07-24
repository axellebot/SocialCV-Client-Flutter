import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('Building SettingsPage');
    return Scaffold(
      appBar: AppBar(
        title: Text(CVLocalizations.of(context).settingsTitle),
      ),
      body: SafeArea(
        left: false,
        right: false,
        child: ListView(
          children: [
            const ThemeSwitchTile(),
            AboutListTile(icon: Icon(Icons.info)),
          ],
        ),
      ),
    );
  }
}
