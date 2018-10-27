import 'dart:async';
import 'package:flutter/material.dart';

import 'package:cv/pages/profile_page.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  _AccountPageSate createState() => _AccountPageSate();
}

class _AccountPageSate extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text("Profile"),
          onTap: () => Navigator.of(context).pushNamed('/profile'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
        ListTile(
          leading: Icon(Icons.vpn_key),
          title: Text("Login"),
          onTap: () => Navigator.of(context).pushNamed('/login'),
          trailing: Icon(Icons.keyboard_arrow_right),
        ),
      ],
    );
  }
}
