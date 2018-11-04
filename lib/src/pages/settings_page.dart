import 'package:cv/src/localizations/localization.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building SettingsPage');
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(Localization.of(context).settingsTitle),
    );
  }

  ListView _buildBody(BuildContext context) {
    return ListView(
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
      ],
    );
  }
}
