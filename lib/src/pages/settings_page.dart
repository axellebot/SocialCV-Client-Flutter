import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:cv/src/widgets/theme_switch_tile_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('Building SettingsPage');
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).settingsTitle),
      ),
      body: SafeArea(
        left: false,
        right: false,
        child: ListView(
          children: [
            ThemeSwitchTile(),
            AboutListTile(icon: Icon(Icons.info)),
          ],
        ),
      ),
    );
  }
}
