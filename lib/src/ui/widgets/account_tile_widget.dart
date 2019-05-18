import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class AccountTile extends StatefulWidget {
  const AccountTile({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountTitleState();
}

class _AccountTitleState extends State<AccountTile> {
  // TODO: Add AuthenticationBloc
  AuthenticationBloc get _authBloc => null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationEvent, AuthenticationState>(
      bloc: _authBloc,
      builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationAuthenticated)
          return _AccountTileConnected();
        if (state is AuthenticationUnauthenticated)
          return _AccountTileNotConnected();
        return Container();
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                          _AccountTileConnected                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

class _AccountTileConnected extends StatefulWidget {
  _AccountTileConnected({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountTileConnectedState();
}

class _AccountTileConnectedState extends State<_AccountTileConnected> {
  // TODO: Add AccountBloc
  AccountBloc get _accountBloc => null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountEvent, AccountState>(
      bloc: _accountBloc,
      builder: (BuildContext context, AccountState state) {
        if (state is AccountUninitialized) {
          return Container();
        }
        if (state is AccountLoaded) {
          var userModel = state.user;
          return ListTile(
            leading: InitialCircleAvatar(
              text: userModel.username,
              backgroundImage: NetworkImage(userModel.picture),
            ),
            title: Text(userModel.username),
            subtitle: Text(userModel.email),
            trailing: IconButton(
              icon: Icon(MdiIcons.logout),
              onPressed: () => null, // TODO: Add logout
            ),
          );
        }
        if (state is AccountFailed) {
          return Container(child: Text('${state.error}'));
        }
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                       _AccountTileNotConnected                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
class _AccountTileNotConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        title: Center(child: Text(CVLocalizations.of(context).authSignInCTA)),
        trailing: Icon(MdiIcons.login),
      ),
      onTap: () => navigateToLogin(context),
    );
  }
}
