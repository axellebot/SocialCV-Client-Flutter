import 'package:cv/src/blocs/auth_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/auth_model.dart';
import 'package:cv/src/paths.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountPage extends StatelessWidget {
  AccountPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Building AccountPage');

    AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return SafeArea(
      child: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _authBloc.isWorkingStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return LinearProgressIndicator();
              }
              return Container();
            },
          ),
          StreamBuilder<bool>(
            stream: _authBloc.isAuthenticatedStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == true)
                  return _buildConnectedAccount(context);
                if (snapshot.data == false)
                  return _buildNotConnectedAccount(context);
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedAccount(context) {
    AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);
    // TODO : Fetch data from AccountBloc ?
    return StreamBuilder<AuthLoginResponseModel>(
      stream: _authBloc.connectionStream,
      builder: (BuildContext context,
          AsyncSnapshot<AuthLoginResponseModel> snapshot) {
        String username = "";
        String token = "";
        String email = "";
        List<String> profileIds = [];
        if (snapshot.hasData) {
          username = snapshot.data.user.username;
          email = snapshot.data.user.email;
          token = snapshot.data.token;
          profileIds = snapshot.data.user.profileIds;
        }
        return ListView(
          children: <Widget>[
            ListTile(
              title: Text(Localization.of(context).username),
              subtitle: Text(username),
              leading: Icon(MdiIcons.account),
            ),
            Divider(),
            ListTile(
              title: Text(Localization.of(context).email),
              subtitle: Text(email),
              leading: Icon(MdiIcons.email),
            ),
            Divider(),
            ListTile(
              title: Text(Localization.of(context).token),
              subtitle: Text(token),
              leading: Icon(MdiIcons.coins),
            ),
            Divider(),
            ExpansionTile(
              leading: Icon(MdiIcons.accountBoxMultiple),
              title: Text(Localization.of(context).accountMyProfile),
              children: _buildProfiles(context, profileIds),
            ),
            Center(
              child: RaisedButton(
                child: Text(Localization.of(context).logoutCTA),
                onPressed: _authBloc.logout,
              ),
            ),
          ],
        );
      },
    );
  }

  List<ListTile> _buildProfiles(BuildContext context, List<String> ids) {
    List<ListTile> _widgets = [];
    ids.forEach((id) {
      _widgets.add(ListTile(
        title: Text("CV ${id}"),
        subtitle: Text(id),
        onTap: () => Navigator.of(context).pushNamed(kPathProfile),
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor,
        ),
        trailing: Icon(MdiIcons.accountDetails),
      ));
    });
    return _widgets;
  }

  Center _buildNotConnectedAccount(BuildContext context) {
    return Center(
      child: RaisedButton(
        child: Text(Localization.of(context).loginCTA),
        onPressed: () => _navigateToLogin(context),
      ),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(kPathLogin);
  }
}
