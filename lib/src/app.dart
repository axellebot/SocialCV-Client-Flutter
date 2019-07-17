import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/domain/blocs/configuration/configuration.dart';
import 'package:social_cv_client_flutter/src/router.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/pages/main_page.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/splash_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

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

    /// Inform ConfigBloc that the application have been launched
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
          return SplashApp();
        } else if (state is ConfigLoaded) {
          return BlocProvider<ConfigurationBloc>(
            bloc: _configBloc,
            child: MultiProvider(
              providers: <Provider>[
                Provider<CVRepository>.value(
                  value: state.cvRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<ConfigRepository>.value(
                  value: state.configRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<AuthPreferencesRepository>.value(
                  value: state.authPreferencesRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<AppPreferencesRepository>.value(
                  value: state.appPreferencesRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
              ],
              child: _AppWrapper(state: state),
            ),
          );
        }
        return ErrorApp(error: NotImplementedYetError());
      },
    );
  }
}

class _AppWrapper extends StatefulWidget {
  final ConfigLoaded state;

  _AppWrapper({Key key, @required this.state}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<_AppWrapper> {
  final String _tag = '$_AppWrapperState';

  AppBloc _appBloc;
  AccountBloc _accountBloc;
  AuthenticationBloc _authBloc;

  ConfigLoaded get _state => widget.state;

  @override
  void initState() {
    super.initState();
    _appBloc = AppBloc(
      appPreferencesRepository: _state.appPreferencesRepository,
    );

    _accountBloc = AccountBloc(
      cvRepository: _state.cvRepository,
      appPreferencesRepository: _state.appPreferencesRepository,
    );

    _authBloc = AuthenticationBloc(
      cvRepository: _state.cvRepository,
      authPreferencesRepository: _state.authPreferencesRepository,
      configRepository: _state.configRepository,
      accountBloc: _accountBloc,
    );

    /// Inform AppBloc that the application just started
    _appBloc.dispatch(AppConfigured());

    /// Inform AuthBloc that the application just started
    _authBloc.dispatch(AppStarted());
  }

  @override
  void dispose() {
    _appBloc?.dispose();
    _accountBloc?.dispose();
    _authBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    AppState tmpState = AppInitialized.defaultValues();

    return BlocBuilder<AppEvent, AppState>(
      bloc: _appBloc,
      builder: (BuildContext context, AppState state) {
        if (state is AppLoading || state is AppInitialized) {
          if (state is AppLoading) state = tmpState;
          tmpState = state;

          /// Dependency Injection of repositories and blocs
          /// Use updateShouldNotify to make dependencies available in
          /// `initState` methods of children widgets
          return BlocProviderTree(
            blocProviders: <BlocProvider>[
              BlocProvider<AppBloc>(bloc: _appBloc),
              BlocProvider<AuthenticationBloc>(bloc: _authBloc),
              BlocProvider<AccountBloc>(bloc: _accountBloc),
            ],
            child: _App(state: state),
          );
        } else if (state is AppFailure) {
          return ErrorApp(error: state.error);
        }

        return ErrorApp(error: NotImplementedYetError());
      },
    );
  }
}

class _App extends StatelessWidget {
  final String _tag = '$_App';

  final AppInitialized state;

  _App({Key key, @required this.state})
      : assert(state != null, 'No $AppInitialized given'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    ///Routes
    final appRouter = AppRouter();

    return MaterialApp(
      onGenerateTitle: (BuildContext context) =>
          CVLocalizations.of(context).appName,
      theme: _buildCVTheme(state.theme),
      home: MainPage(),
      onGenerateRoute: appRouter.router.generator,

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
