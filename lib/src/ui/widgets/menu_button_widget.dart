import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  // TODO: Add AuthBloc
  AuthenticationBloc get _authBloc => null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationEvent, AuthenticationState>(
      bloc: _authBloc,
      builder: (BuildContext context, AuthenticationState state) {
        if (state is AuthenticationAuthenticated) return _MenuButtonConnected();
        if (state is AuthenticationUnauthenticated)
          return _MenuButtonNotConnected();
        return Container();
      },
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                          _MenuButtonNotConnected                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

class _MenuButtonNotConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => openMenuBottomSheet(context),
      icon: Icon(Icons.menu),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                          _MenuButtonConnected                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

class _MenuButtonConnected extends StatefulWidget {
  _MenuButtonConnected({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuButtonConnectedState();
}

class _MenuButtonConnectedState extends State<_MenuButtonConnected> {
  AccountBloc get _accountBloc => null;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountEvent, AccountState>(
      bloc: _accountBloc,
      builder: (BuildContext context, AccountState state) {
        if (state is AccountLoaded) {
          return Padding(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            child: IconButton(
              onPressed: () => openMenuBottomSheet(context),
              icon: InitialCircleAvatar(
                text: state.user.username,
                backgroundImage: NetworkImage(state.user.picture),
              ),
            ),
          );
        }
      },
    );
  }
}
