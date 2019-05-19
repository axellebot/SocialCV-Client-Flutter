import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';

class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBloc _appBloc = BlocProvider.of<AppBloc>(context);

    return BlocBuilder<AppEvent, AppState>(
      bloc: _appBloc,
      builder: (BuildContext context, AppState state) {
        if (state is AppLoading) {
          return ListTile(
            title: Text(CVLocalizations.of(context).settingsThemeCTA),
            trailing: CircularProgressIndicator(),
          );
        }
        if (state is AppInitialized) {
          return SwitchListTile(
            secondary: Icon(
              state.theme == ThemeType.DARK
                  ? MdiIcons.weatherSunny
                  : MdiIcons.whiteBalanceSunny,
            ),
            title: Text(CVLocalizations.of(context).settingsThemeCTA),
            value: state.theme == ThemeType.DARK ? true : false,
            onChanged: (bool enable) {
              if (enable)
                _appBloc.dispatch(AppThemeChanged(theme: ThemeType.DARK));
              else
                _appBloc.dispatch(AppThemeChanged(theme: ThemeType.LIGHT));
            },
          );
        }
      },
    );
  }
}
