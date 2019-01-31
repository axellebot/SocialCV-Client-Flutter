import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';

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
              snapshot.data == ThemeType.DARK
                  ? MdiIcons.weatherSunny
                  : MdiIcons.whiteBalanceSunny,
            ),
            title: Text(CVLocalizations.of(context).settingsThemeCTA),
            value: snapshot.data == ThemeType.DARK ? true : false,
            onChanged: (bool enable) {
              if (enable)
                _appBloc.setTheme(ThemeType.DARK);
              else
                _appBloc.setTheme(ThemeType.LIGHT);
            });
      },
    );
  }
}
