import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';
import 'package:social_cv_client_flutter/src/widgets/initial_circle_avatar_widget.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return StreamBuilder<bool>(
      stream: _accountBloc.isAuthenticatedStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) return _MenuButtonConnected();
          if (snapshot.data == false) return _MenuButtonNotConnected();
        }
        return Container();
      },
    );
  }
}

class _MenuButtonNotConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => openMenuBottomSheet(context),
      icon: Icon(Icons.menu),
    );
  }
}

class _MenuButtonConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return StreamBuilder<UserModel>(
      stream: _accountBloc.accountDetailsStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasData) {
          UserModel userModel = snapshot.data;
          return Padding(
              padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
              child: IconButton(
                onPressed: () => openMenuBottomSheet(context),
                icon: InitialCircleAvatar(
                    text: userModel.username,
                    backgroundImage: NetworkImage(userModel.picture)),
              ));
        } else if (snapshot.hasError) {
          return Container(child: Text('Error ${snapshot.error}'));
        }
        return Container();
      },
    );
  }
}
