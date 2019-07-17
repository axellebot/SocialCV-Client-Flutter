import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/theme_switch_list_tile_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

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
            ThemeSwitchListTile(),
            AboutListTile(icon: Icon(Icons.info)),
          ],
        ),
      ),
    );
  }
}
