import 'package:cv/src/blocs/application_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/login_bloc.dart';
import 'package:cv/src/blocs/main_bloc.dart';
import 'package:cv/src/commons/colors.dart';
import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/pages/login_page.dart';
import 'package:cv/src/pages/main_page.dart';
import 'package:cv/src/pages/profile_page.dart';
import 'package:cv/src/pages/search_page.dart';
import 'package:cv/src/pages/settings_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CVApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CVAppState();
}

class _CVAppState extends State<CVApp> {
  // Blocs
  final MainBloc _mainBloc = MainBloc();
  final LoginBloc _loginBloc = LoginBloc();

  // Pages
  final MainPage _mainPage = MainPage();

  @override
  Widget build(BuildContext context) {
    // Set-up error reporting
    FlutterError.onError = (FlutterErrorDetails error) {
      printException(error.exception, error.stack, error.context);
    };

    BlocProvider<MainBloc> _mainPageProvider = BlocProvider<MainBloc>(
      bloc: _mainBloc,
      child: _mainPage,
    );

    ApplicationBloc _appBloc = BlocProvider.of<ApplicationBloc>(context);

    return StreamBuilder<String>(
        stream: _appBloc.themeStream,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return MaterialApp(
            onGenerateTitle: (BuildContext context) =>
                Localization.of(context).appName,
            theme: _buildCVTheme(snapshot.data),
            home: _mainPageProvider,
            routes: <String, WidgetBuilder>{
              kPathHome: (context) {
                return _mainPageProvider;
              },
              kPathAccount: (context) {
                return _mainPageProvider;
              },
              kPathLogin: (context) {
                return BlocProvider<LoginBloc>(
                  bloc: _loginBloc,
                  child: LoginPage(),
                );
              },
              kPathProfile: (context) => ProfilePage(),
              kPathSettings: (context) => SettingsPage(),
              kPathSearch: (context) => SearchPage(),
            },
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
            //showSemanticsDebugger: true,
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
