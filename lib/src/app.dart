import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_flutter/src/data/repositories/repositories_provider.dart';
import 'package:social_cv_client_flutter/src/routes.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/pages/main_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/splash_page.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

import 'domain/blocs/configuration/configuration.dart';

class ConfigWrapperApp extends StatefulWidget {
  const ConfigWrapperApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConfigWrapperAppState();
}

class _ConfigWrapperAppState extends State<ConfigWrapperApp> {
  ConfigurationBloc _configBloc;

  @override
  void initState() {
    super.initState();
    _configBloc = ConfigurationBloc();
    _configBloc.dispatch(AppLaunched());
  }

  @override
  void dispose() {
    _configBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationEvent, ConfigurationState>(
      bloc: _configBloc,
      builder: (BuildContext context, ConfigurationState state) {
        if (state is ConfigLoading) {
          return WidgetsApp(
            home: SplashPage(),
            color: AppColors.primaryColor,
          );
        } else if (state is ConfigLoaded) {
          return _CVApp(state);
        }
        return ErrorRow(error: NotImplementedYetError());
      },
    );
  }
}

class _CVApp extends StatefulWidget {
  final ConfigLoaded state;

  _CVApp(this.state);

  @override
  State<StatefulWidget> createState() => _CVAppState();
}

class _CVAppState extends State<_CVApp> {
  final String _tag = "_CVAppState";

  AppBloc _appBloc;
  AccountBloc _accountBloc;
  AuthenticationBloc _authBloc;
  LoginBloc _loginBloc;
  RegisterBloc _registerBloc;

  ConfigLoaded get _state => widget.state;

  @override
  void initState() {
    super.initState();
    _appBloc = AppBloc(preferencesRepository: _state.preferencesRepository);

    _accountBloc = AccountBloc(
      cvRepository: _state.cvRepository,
      preferencesRepository: _state.preferencesRepository,
    );

    _authBloc = AuthenticationBloc(
      cvRepository: _state.cvRepository,
      preferencesRepository: _state.preferencesRepository,
      configRepository: _state.configRepository,
      accountBloc: _accountBloc,
    );

    _loginBloc = LoginBloc(
      cvRepository: _state.cvRepository,
      authBloc: _authBloc,
    );

    _registerBloc = RegisterBloc(authenticationBloc: _authBloc);
  }

  @override
  void dispose() {
    _appBloc?.dispose();
    _accountBloc?.dispose();
    _authBloc?.dispose();
    _loginBloc?.dispose();
    _registerBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    logger.info('$_tag:build');

    return BlocBuilder<AppEvent, AppState>(
      bloc: _appBloc,
      builder: (BuildContext context, AppState state) {
        if (state is AppUninitialized) Text('App Uninitialized');

        if (state is AppInitialized) return _CVInitializedApp(state: state);

        if (state is AppFailure) return ErrorCard(error: state.error);

        if (state is AppLoading)
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _CVInitializedApp extends StatelessWidget {
  final String _tag = "_CVInitializedApp";

  const _CVInitializedApp({this.state});

  final AppInitialized state;

  @override
  Widget build(BuildContext context) {
    logger.info('$_tag:build');

    RepositoriesProvider repositories = RepositoriesProvider.of(context);

    ///Routes
    Routes routes = Routes(
      cvRepository: repositories.cvRepository,
      preferencesRepository: repositories.preferencesRepository,
      configRepository: repositories.configRepository,
    );

    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          CVLocalizations.of(context).appName,
      theme: _buildCVTheme(state.theme),
      home: MainPage(),
      onGenerateRoute: routes.router.generator,

      ///Use Fluro routes
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
  }

  ThemeData _buildCVTheme(String theme) {
    ThemeData base;
    if (theme != ThemeType.DARK)
      base = ThemeData.light();
    else {
      base = ThemeData.dark();
    }

    return base.copyWith(
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColorLight,
      primaryColorDark: AppColors.primaryColorDark,
      accentColor: AppColors.accentColor,
      buttonColor: (theme != ThemeType.DARK)
          ? AppColors.white
          : AppColors.primaryColorDark,
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
