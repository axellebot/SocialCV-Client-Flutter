import 'package:cv/src/blocs/account_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AccountTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<bool>(
      stream: _accountBloc.isAuthenticatedStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) return _buildConnectedAccount(context);
          if (snapshot.data == false) return _buildNotConnectedAccount(context);
        }
        return Container();
      },
    );
  }

  Widget _buildConnectedAccount(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<UserModel>(
      stream: _accountBloc.fetchAccountDetailsStream,
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
          return Container(child: Text("${snapshot.error}"));
        }
        return Container();
      },
    );
  }

  Widget _buildNotConnectedAccount(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        title: Center(child: Text(Localization.of(context).loginCTA)),
        trailing: Icon(MdiIcons.login),
      ),
      onTap: () => _navigateToLogin(context),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(kPathLogin);
  }
}
