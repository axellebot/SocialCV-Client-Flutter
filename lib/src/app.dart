import 'package:cv/src/blocs/application_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/main_bloc.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/commons/colors.dart';
import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/pages/login_page.dart';
import 'package:cv/src/pages/main_page.dart';
import 'package:cv/src/pages/profile_page.dart';
import 'package:cv/src/pages/search_page.dart';
import 'package:cv/src/pages/settings_page.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CVApp extends StatelessWidget {
  // Blocs
  // TODO : Check if statefulWidget needed for blocs

  // Routes
  final Router router = Router();

  @override
  Widget build(BuildContext context) {
    print('Building CVApp');
    // Set-up error reporting
    FlutterError.onError = (FlutterErrorDetails error) {
      printException(error.exception, error.stack, error.context);
    };

    BlocProvider<MainBloc> _mainPageProvider = BlocProvider<MainBloc>(
      bloc: MainBloc(),
      child: MainPage(),
    );

    ApplicationBloc _appBloc = BlocProvider.of<ApplicationBloc>(context);

    // Defining routes
    router.define(
      kPathHome,
      handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return _mainPageProvider;
      }),
    );

    router.define(
      kPathAccount,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return _mainPageProvider;
        },
      ),
    );

    // TODO : Check other solution to avoid LoginBloc recreation when
    // LoginBloc rebuild (caused by input change)
    router.define(
      kPathLogin,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return LoginPage();
        },
      ),
    );

    router.define(
      "$kPathProfile/:$kParamProfileId",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return BlocProvider<ProfileBloc>(
            bloc: ProfileBloc(),
            child: ProfilePage(params[kParamProfileId][0]),
          );
        },
      ),
    );

    router.define(
      kPathSettings,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return SettingsPage();
        },
      ),
    );

    router.define(
      kPathSearch,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          return SearchPage();
        },
      ),
    );

    return StreamBuilder<String>(
        stream: _appBloc.themeStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return MaterialApp(
            onGenerateTitle: (BuildContext context) =>
                Localization.of(context).appName,
            theme: _buildCVTheme(snapshot.data),
            home: _mainPageProvider,
            onGenerateRoute: router.generator, // Use Fluro routes
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
      canvasColor: Colors.transparent, // Used for bottom sheet rounded
    );
  }

  TextTheme _buildCVTextTheme(TextTheme base) {
    return base.apply(
      fontFamily: 'Google Sans',
    );
  }
}
