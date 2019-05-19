import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class AccountTile extends StatefulWidget {
  const AccountTile({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AccountTitleState();
}

class _AccountTitleState extends State<AccountTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationEvent, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationAuthenticated)
          return _AccountTileConnected();
        if (state is AuthenticationUnauthenticated)
          return _AccountTileNotConnected();
        return ErrorTile(error: NotImplementedYetError());
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                          _AccountTileConnected                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

class _AccountTileConnected extends StatelessWidget {
  final String _tag = '$_AccountTileConnected';

  _AccountTileConnected({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return BlocBuilder<AccountEvent, AccountState>(
      bloc: BlocProvider.of<AccountBloc>(context),
      builder: (BuildContext context, AccountState state) {
        if (state is AccountUninitialized) {
        } else if (state is AccountLoaded) {
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
        } else if (state is AccountFailed) {
          return Container(child: Text('${state.error}'));
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
        title: Center(child: Text(CVLocalizations.of(context).authSignInCTA)),
        trailing: Icon(MdiIcons.login),
      ),
      onTap: () => navigateToLogin(context),
    );
  }
}
