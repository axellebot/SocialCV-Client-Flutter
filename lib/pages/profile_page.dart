import 'package:cv/localizations/localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageSate createState() => _ProfilePageSate();
}

class _ProfilePageSate extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(MdiIcons.accountBoxMultiple),
          title: Text(Localization.of(context).profileMyResume),
          onTap: () => Navigator.of(context).pushNamed('/resume'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
