import 'package:cv/src/blocs/application_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/localizations/cv_localization.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({
    Key key,
  }) : super(key: key);

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
            title: Text(CVLocalizations.of(context).settingsThemeCTA),
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
