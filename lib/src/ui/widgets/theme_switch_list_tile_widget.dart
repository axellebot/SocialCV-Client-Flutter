import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

class ThemeSwitchListTile extends StatelessWidget {
  final String _tag = '$ThemeSwitchListTile';

  ThemeSwitchListTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    AppBloc _appBloc = BlocProvider.of<AppBloc>(context);

    return BlocBuilder<AppEvent, AppState>(
      bloc: _appBloc,
      builder: (BuildContext context, AppState state) {
        if (state is AppLoading || state is AppInitialized) {
          bool value;
          Widget leadingWidget;
          Widget trailingWidget;

          final function = (bool enable) {
            if (enable) {
              _appBloc.dispatch(AppThemeChanged(theme: ThemeType.DARK));
            } else {
              _appBloc.dispatch(AppThemeChanged(theme: ThemeType.LIGHT));
            }
          };

          if (state is AppLoading) {
            value = true;
            leadingWidget = CircularProgressIndicator();
            trailingWidget = CircularProgressIndicator();
          } else if (state is AppInitialized) {
            value = (state.theme == ThemeType.DARK) ? true : false;
            leadingWidget = Icon(state.theme == ThemeType.DARK
                ? MdiIcons.weatherSunny
                : MdiIcons.whiteBalanceSunny);

            trailingWidget = Switch(
              value: value,
              onChanged: function,
            );
          }

          return ListTile(
            onTap: () => function(!value),
            leading: leadingWidget,
            title: Text(CVLocalizations.of(context).settingsThemeCTA),
            trailing: trailingWidget,
          );
        }
      },
    );
  }
}
