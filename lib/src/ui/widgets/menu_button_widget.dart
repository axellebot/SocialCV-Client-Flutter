import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class MenuButton extends StatelessWidget {
  final String _tag = '$MenuButton';
  final EdgeInsetsGeometry padding;

  MenuButton({
    Key key,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppDimensions.menuButtonPadding,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return Padding(
      padding: padding,
      child: BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationAuthenticated)
            return _MenuButtonConnected();
          if (state is AuthenticationUnauthenticated)
            return _MenuButtonNotConnected();
          return ErrorRow(error: NotImplementedYetError());
        },
      ),
    );
  }
}

/// ----------------------------------------------------------
/// ---------------------- Not connected ---------------------
/// ----------------------------------------------------------

class _MenuButtonNotConnected extends StatelessWidget {
  final String _tag = '$_MenuButtonNotConnected';

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');
    return IconButton(
      onPressed: () => openMenuBottomSheet(context),
      icon: Icon(Icons.menu),
    );
  }
}

/// ----------------------------------------------------------
/// ---------------------- Connected -------------------------
/// ----------------------------------------------------------

class _MenuButtonConnected extends StatelessWidget {
  final String _tag = '$_MenuButtonConnected';

  _MenuButtonConnected({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return BlocBuilder<AccountEvent, AccountState>(
      bloc: BlocProvider.of<AccountBloc>(context),
      builder: (BuildContext context, AccountState state) {
        if (state is AccountUninitialized) {
          return _MenuButtonNotConnected();
        } else if (state is AccountLoading) {
          return GestureDetector(
            onTap: () => openMenuBottomSheet(context),
            child: CircularProgressIndicator(),
          );
        } else if (state is AccountLoaded) {
          return IconButton(
            onPressed: () => openMenuBottomSheet(context),
            icon: InitialCircleAvatar(
              text: state.user.username,
              backgroundImage: NetworkImage(state.user.picture),
            ),
          );
        } else if (state is AccountFailed) {
          return IconButton(
            onPressed: () => openMenuBottomSheet(context),
            icon: ErrorIcon(),
          );
        }
        return ErrorText(error: NotImplementedYetError());
      },
    );
  }
}
