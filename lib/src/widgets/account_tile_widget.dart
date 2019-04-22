import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';
import 'package:social_cv_client_flutter/src/widgets/initial_circle_avatar_widget.dart';

class AccountTile extends StatelessWidget {
  const AccountTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<bool>(
      stream: _accountBloc.isAuthenticatedStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) return _AccountTileConnected();
          if (snapshot.data == false) return _AccountTileNotConnected();
        }
        return Container();
      },
    );
  }
}

class _AccountTileConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<UserModel>(
      stream: _accountBloc.accountDetailsStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          UserModel userModel = snapshot.data;
          return ListTile(
            leading: InitialCircleAvatar(
                text: userModel.username,
                backgroundImage: NetworkImage(userModel.picture)),
            title: Text(userModel.username),
            subtitle: Text(userModel.email),
            trailing: IconButton(
              icon: Icon(MdiIcons.logout),
              onPressed: () => _accountBloc.logout(),
            ),
          );
        } else if (snapshot.hasError) {
          return Container(child: Text('${snapshot.error}'));
        }
        return Container();
      },
    );
  }
}

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
