import 'package:cv/src/blocs/auth_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/exception_print.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/pages/account_page.dart';
import 'package:cv/src/pages/home_page.dart';
import 'package:cv/src/pages/login_page.dart';
import 'package:cv/src/pages/profile_page.dart';
import 'package:cv/src/pages/search_page.dart';
import 'package:cv/src/pages/settings_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'colors.dart';

class CVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set-up error reporting
    FlutterError.onError = (FlutterErrorDetails error) {
      printException(error.exception, error.stack, error.context);
    };

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: kCVPrimaryColor, //or set color with: Color(0xFF0000FF)
    ));

    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          Localization.of(context).appName,
      theme: _kCVTheme,
      home: BlocProvider<AuthBloc>(
        bloc: AuthBloc(),
        child: LoginPage(),
      ),
      routes: <String, WidgetBuilder>{
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/profile': (context) => ProfilePage(),
        '/account': (context) => AccountPage(),
        '/settings': (context) => SettingsPage(),
        '/search': (context) => SearchPage(),
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
    );
  }
}

final ThemeData _kCVTheme = _buildCVTheme();

ThemeData _buildCVTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    primaryColor: kCVPrimaryColor,
    primaryColorLight: kCVPrimaryColorLight,
    primaryColorDark: kCVPrimaryColorDark,
    accentColor: kCVAccentColor,
    buttonColor: kCVBlue,
    scaffoldBackgroundColor: kCVBackgroundColor,
    cardColor: kCVWhite,
    textSelectionColor: kCVPink,
    errorColor: kCVErrorRed,
    primaryIconTheme: base.primaryIconTheme.copyWith(color: kCVWhite),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    textTheme: _buildCVTextTheme(base.textTheme),
    primaryTextTheme: _buildCVTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildCVTextTheme(base.accentTextTheme),
    iconTheme: _customIconTheme(base.iconTheme),
  );
}

IconThemeData _customIconTheme(IconThemeData original) {
  return original.copyWith(color: kCVWhite);
}

TextTheme _buildCVTextTheme(TextTheme base) {
  return base
      .copyWith(
        headline: base.headline.copyWith(
          color: kCVTextOnPrimary,
          fontWeight: FontWeight.w500,
        ),
        title: base.title.copyWith(
          color: kCVTextOnPrimary,
          fontSize: 18.0,
        ),
        caption: base.caption.copyWith(
          color: kCVBlack,
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        body2: base.body2.copyWith(
          color: kCVBlack,
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
        button: base.button.copyWith(
          color: kCVTextOnAccent,
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
        ),
      )
      .apply(
        fontFamily: 'Google Sans',
      );
}
