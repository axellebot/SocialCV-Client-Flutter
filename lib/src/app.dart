import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/blocs/main_bloc.dart';
import 'package:social_cv_client_flutter/src/commons/colors.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/pages/main_page.dart';
import 'package:social_cv_client_flutter/src/repositories/repositories_provider.dart';
import 'package:social_cv_client_flutter/src/routes.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

class CVApp extends StatelessWidget {
  const CVApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.info('Building App');

    RepositoriesProvider repositories = RepositoriesProvider.of(context);

    return BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(
        preferencesRepository: repositories.preferencesRepository,
      ),
      child: BlocProvider<AccountBloc>(
        bloc: AccountBloc(
          cvRepository: repositories.cvRepository,
          preferencesRepository: repositories.preferencesRepository,
          secretRepository: repositories.secretsRepository,
        ),
        child: _CVThemedApp(),
      ),
    );
  }
}

class _CVThemedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RepositoriesProvider repositories = RepositoriesProvider.of(context);

    BlocProvider<MainBloc> _mainPageProvider = BlocProvider<MainBloc>(
      bloc: MainBloc(),
      child: MainPage(),
    );

    // Routes
    Routes routes = Routes(
      mainPageProvider: _mainPageProvider,
      cvRepository: repositories.cvRepository,
      preferencesRepository: repositories.preferencesRepository,
      secretsRepository: repositories.secretsRepository,
    );

    ApplicationBloc _appBloc = BlocProvider.of<ApplicationBloc>(context);

    return StreamBuilder<String>(
        stream: _appBloc.themeStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return MaterialApp(
            onGenerateTitle: (BuildContext context) =>
                CVLocalizations.of(context).appName,
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
    if (theme != ThemeType.DARK)
      base = ThemeData.light();
    else {
      base = ThemeData.dark();
    }

    return base.copyWith(
      primaryColor: kCVPrimaryColor,
      primaryColorLight: kCVPrimaryColorLight,
      primaryColorDark: kCVPrimaryColorDark,
      accentColor: kCVAccentColor,
      buttonColor: (theme != ThemeType.DARK) ? kCVWhite : kCVPrimaryColorDark,
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
