import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class MenuBottomSheet extends StatelessWidget {
  final String _tag = '$MenuBottomSheet';

  MenuBottomSheet({
    Key? key,
    this.backgroundColor,
    this.borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
  }) : super(key: key);

  final Color? backgroundColor;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    return SafeArea(
      left: false,
      right: false,
      child: Wrap(
        children: <Widget>[
          const AccountTile(),
          const Divider(),
          const ThemeSwitchTile(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(CVLocalizations.of(context)!.settingsCTA),
            onTap: () => navigateToSettings(context),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                child: Text(CVLocalizations.of(context)!.menuPPCTA),
                onPressed: null,
              ),
              const Text('·'),
              MaterialButton(
                child: Text(CVLocalizations.of(context)!.menuToSCTA),
                onPressed: null,
              ),
            ],
          )
        ],
      ),
    );
  }
}
