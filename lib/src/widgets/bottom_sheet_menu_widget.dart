import 'package:cv/src/blocs/account_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/paths.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomSheetMenu extends StatefulWidget {
  const BottomSheetMenu(
      {Key key,
      this.backgroundColor = Colors.white,
      this.height = 210.0,
      this.borderRadius = const BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0))})
      : super(key: key);

  final Color backgroundColor;
  final double height;
  final BorderRadius borderRadius;

  @override
  State<StatefulWidget> createState() => _BottomSheetMenuState();
}

class _BottomSheetMenuState extends State<BottomSheetMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      color: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: widget.borderRadius,
        ),
        child: _buildBottomSheet(context),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildAccountLine(context),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text(Localization.of(context).settings),
          onTap: () => _navigateToSettings(context),
        ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text(Localization.of(context).menuPP),
              onPressed: () {},
            ),
            Text(Localization.of(context).middleDot),
            MaterialButton(
              child: Text(Localization.of(context).menuToS),
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }

  Widget _buildAccountLine(BuildContext context) {
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
    return StreamBuilder<ResponseModel<UserModel>>(
      stream: _accountBloc.fetchAccountDetailsStream,
      builder: (BuildContext context,
          AsyncSnapshot<ResponseModel<UserModel>> snapshot) {
        if (snapshot.hasData) {
          UserModel userModel = snapshot.data.data;
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
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildNotConnectedAccount(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        title: Text(Localization.of(context).loginCTA),
        trailing: Icon(MdiIcons.login),
      ),
      onTap: () => _navigateToLogin(context),
    );
  }

  void _navigateToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(kPathLogin);
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).pushNamed(kPathSettings);
  }
}
