import 'package:cv/localizations/localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageSate createState() => _SettingsPageSate();
}

class _SettingsPageSate extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(Localization.of(context).settingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        children: [
          Center(
            child: FlatButton(
              child: Text(Localization.of(context).settingsToS),
              onPressed: () {},
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 30.0)),
          Text(
            Localization.of(context).account,
            style: const TextStyle(
              fontSize: 18.0,
              fontFamily: "Google Sans",
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 10.0)),
          Text(
            "username@example.com",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 14.0)),
          Center(
            child: FlatButton(
              child: Text(Localization.of(context).logout),
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
