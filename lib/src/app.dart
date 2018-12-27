import 'package:cv/src/blocs/application_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/main_bloc.dart';
import 'package:cv/src/commons/colors.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/pages/main_page.dart';
import 'package:cv/src/routes.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CVApp extends StatelessWidget {
  const CVApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('Building App');

    // Set-up error reporting
    FlutterError.onError = (FlutterErrorDetails error) {
      printException(error.exception, error.stack, error.context);
    };

    BlocProvider<MainBloc> _mainPageProvider = BlocProvider<MainBloc>(
      bloc: MainBloc(),
      child: MainPage(),
    );

    // Routes
    Routes routes = Routes(_mainPageProvider);

    ApplicationBloc _appBloc = BlocProvider.of<ApplicationBloc>(context);

    return StreamBuilder<String>(
        stream: _appBloc.themeStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return MaterialApp(
            onGenerateTitle: (BuildContext context) =>
                Localization.of(context).appName,
            theme: _buildCVTheme(snapshot.data),
            home: _mainPageProvider,
            onGenerateRoute: routes.router.generator,
            // Use Fluro routes
            localizationsDelegates: [
              const CVLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('fr'),
            ],
            debugShowCheckedModeBanner: false,
//            showSemanticsDebugger: true,
          );
        });
  }

  ThemeData _buildCVTheme(String theme) {
    ThemeData base;
    if (theme != THEME.DARK)
      base = ThemeData.light();
    else {
      base = ThemeData.dark();
    }

    return base.copyWith(
      primaryColor: kCVPrimaryColor,
      primaryColorLight: kCVPrimaryColorLight,
      primaryColorDark: kCVPrimaryColorDark,
      accentColor: kCVAccentColor,
      buttonColor: (theme != THEME.DARK) ? kCVWhite : kCVPrimaryColorDark,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
      textTheme: _buildCVTextTheme(base.textTheme),
      primaryTextTheme: _buildCVTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildCVTextTheme(base.accentTextTheme),
    );
  }

  TextTheme _buildCVTextTheme(TextTheme base) {
    return base.apply(
      fontFamily: 'Google Sans',
    );
  }
}
