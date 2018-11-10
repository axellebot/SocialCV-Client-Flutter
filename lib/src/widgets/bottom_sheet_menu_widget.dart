import 'package:cv/src/blocs/auth_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/paths.dart';
import 'package:flutter/material.dart';

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
    AuthBloc _authBloc = BlocProvider.of<AuthBloc>(context);

    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text("Nickname"),
          subtitle: Text("username@example.com"),
        ),
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

  void _navigateToSettings(BuildContext context) {
    Navigator.of(context).pushNamed(kPathSettings);
  }
}
