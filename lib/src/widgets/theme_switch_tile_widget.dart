import 'package:cv/src/blocs/application_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ThemeSwitchTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ApplicationBloc _appBloc = BlocProvider.of<ApplicationBloc>(context);
    return StreamBuilder<String>(
      stream: _appBloc.themeStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return SwitchListTile(
            secondary: Icon(
              snapshot.data == THEME.DARK
                  ? MdiIcons.weatherSunny
                  : MdiIcons.whiteBalanceSunny,
            ),
            title: Text(Localization.of(context).settingsThemeCTA),
            value: snapshot.data == THEME.DARK ? true : false,
            onChanged: (bool enable) {
              if (enable)
                _appBloc.setTheme(THEME.DARK);
              else
                _appBloc.setTheme(THEME.LIGHT);
            });
      },
    );
  }
}
