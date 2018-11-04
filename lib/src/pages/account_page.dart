import 'package:cv/src/localizations/localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageSate createState() => _AccountPageSate();
}

class _AccountPageSate extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ExpansionTile(
          leading: Icon(MdiIcons.accountBoxMultiple),
          title: Text(Localization.of(context).accountMyProfile),
          children: <Widget>[
            ListTile(
              title: Text("CV 1"),
              subtitle: Text("Flutter Developper"),
              onTap: () => Navigator.of(context).pushNamed('/profile'),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
              ),
              trailing: Icon(MdiIcons.accountDetails),
            ),
          ],
        ),
      ],
    );
  }
}
