import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/src/presentation/localizations/cv_localization.dart';

class ThemeSwitchTile extends StatelessWidget {
  const ThemeSwitchTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppBloc _appBloc = BlocProvider.of<AppBloc>(context);

    return BlocBuilder<AppBloc, AppState>(
      bloc: _appBloc,
      builder: (BuildContext context, AppState state) {
        if (state is AppInitialized) {
          final bool darkMode = state.darkMode;
          return SwitchListTile(
            secondary: Icon(
              darkMode ? MdiIcons.weatherSunny : MdiIcons.whiteBalanceSunny,
            ),
            title: Text(CVLocalizations.of(context).settingsDarkModeCTA),
            value: darkMode,
            onChanged: (bool newValue) =>
                _appBloc.add(AppThemeChange(darkMode: newValue)),
          );
        }
        return Container(child: Text('${state.runtimeType} state unhandled'));
      },
    );
  }
}
