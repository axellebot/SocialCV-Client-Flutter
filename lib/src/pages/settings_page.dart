import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/widgets/theme_switch_tile_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building SettingsPage');
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(Localization.of(context).settingsTitle),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          ThemeSwitchTile(),
          const Padding(padding: EdgeInsets.only(top: 8.0)),
        ],
      ),
    );
  }
}
