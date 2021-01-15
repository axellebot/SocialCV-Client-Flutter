import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class MenuButton extends StatelessWidget {
  final String _tag = '$MenuButton';
  final EdgeInsetsGeometry padding;

  MenuButton({
    Key key,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppStyles.appMenuButtonVerticalPadding,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    return Padding(
      padding: padding,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
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

/// ----------------------------------------------------------------------------
///                             Not connected
/// ----------------------------------------------------------------------------

class _MenuButtonNotConnected extends StatelessWidget {
  final String _tag = '$_MenuButtonNotConnected';

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');
    return IconButton(
      onPressed: () => openMenuBottomSheet(context),
      icon: Icon(Icons.menu),
    );
  }
}

/// ----------------------------------------------------------------------------
///                             Connected
/// ----------------------------------------------------------------------------

class _MenuButtonConnected extends StatelessWidget {
  final String _tag = '$_MenuButtonConnected';

  _MenuButtonConnected({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    return BlocBuilder<IdentityBloc, IdentityState>(
      bloc: BlocProvider.of<IdentityBloc>(context),
      builder: (BuildContext context, IdentityState state) {
        if (state is IdentityUninitialized) {
          return _MenuButtonNotConnected();
        } else if (state is IdentityLoading) {
          return GestureDetector(
            onTap: () => openMenuBottomSheet(context),
            child: const CircularProgressIndicator(),
          );
        } else if (state is IdentityLoaded) {
          return IconButton(
            onPressed: () => openMenuBottomSheet(context),
            icon: InitialCircleAvatar(
              text: state.user.username,
              backgroundImage: NetworkImage(state.user.picture),
            ),
          );
        } else if (state is IdentityFailed) {
          return IconButton(
            onPressed: () => openMenuBottomSheet(context),
            icon: const ErrorIcon(),
          );
        }
        return ErrorText(error: NotImplementedYetError());
      },
    );
  }
}
