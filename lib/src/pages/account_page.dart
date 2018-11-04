import 'package:cv/src/localizations/localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building AccountPage');
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
