import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/utils/navigation.dart';
import 'package:cv/src/widgets/account_tile_widget.dart';
import 'package:cv/src/widgets/theme_switch_tile_widget.dart';
import 'package:flutter/material.dart';

class MenuBottomSheet extends StatelessWidget {
  const MenuBottomSheet(
      {Key key,
      this.backgroundColor,
      this.borderRadius = const BorderRadius.only(
          topLeft: const Radius.circular(10.0),
          topRight: const Radius.circular(10.0))})
      : super(key: key);

  final Color backgroundColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: new BoxDecoration(
          color: backgroundColor ?? Theme.of(context).dialogBackgroundColor,
          borderRadius: borderRadius,
        ),
        child: SafeArea(
          left: false,
          right: false,
          child: Wrap(
            children: <Widget>[
              AccountTile(),
              Divider(),
              ThemeSwitchTile(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text(Localization.of(context).settingsCTA),
                onTap: () => navigateToSettings(context),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    child: Text(Localization.of(context).menuPPCTA),
                    onPressed: null,
                  ),
                  Text(Localization.of(context).middleDot),
                  MaterialButton(
                    child: Text(Localization.of(context).menuToSCTA),
                    onPressed: null,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
