import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class AccountTile extends StatefulWidget {
  const AccountTile({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountTitleState();
}

class _AccountTitleState extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationAuthenticated) {
          return _AccountTileConnected();
        } else if (state is AuthenticationUnauthenticated) {
          return _AccountTileNotConnected();
        }
        return ErrorTile(error: NotImplementedYetError());
      },
    );
  }
}

/// ----------------------------------------------------------------------------
///                          _AccountTileConnected
/// ----------------------------------------------------------------------------

class _AccountTileConnected extends StatelessWidget {
  final String _tag = '$_AccountTileConnected';

  _AccountTileConnected({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    return BlocBuilder<IdentityBloc, IdentityState>(
      bloc: BlocProvider.of<IdentityBloc>(context),
      builder: (BuildContext context, IdentityState state) {
        if (state is IdentityUninitialized) {
        } else if (state is IdentityLoaded) {
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
        } else if (state is IdentityFailed) {
          return ErrorTile(error: state.error);
        }
        return ErrorTile(error: NotImplementedYetError());
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
        title: Center(child: Text(CVLocalizations.of(context).authLoginCTA)),
        trailing: Icon(MdiIcons.login),
      ),
      onTap: () => navigateToLogin(context),
    );
  }
}
