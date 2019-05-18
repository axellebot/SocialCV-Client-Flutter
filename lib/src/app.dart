import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/domain/blocs/configuration/configuration.dart';
import 'package:social_cv_client_flutter/src/routes.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/pages/main_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/splash_page.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';

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
          return WidgetsApp(
            home: SplashPage(),
            color: AppColors.primaryColor,
          );
        } else if (state is ConfigLoaded) {
          return _ConfiguredApp(state);
        }
        return ErrorApp(error: NotImplementedYetError());
      },
    );
  }
}

class _ConfiguredApp extends StatefulWidget {
  final ConfigLoaded state;

  _ConfiguredApp(this.state);

  @override
  State<StatefulWidget> createState() => _ConfiguredAppState();
}

class _ConfiguredAppState extends State<_ConfiguredApp> {
  final String _tag = '$_ConfiguredAppState';

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

    /// Inform AuthBloc that the application have been configured
    _authBloc.dispatch(AppStarted());
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
    Logger.log('$_tag:$build');

    return BlocBuilder<AppEvent, AppState>(
      bloc: _appBloc,
      builder: (BuildContext context, AppState state) {
        if (state is AppUninitialized) {
        } else if (state is AppLoading) {
          return LoadingApp();
        } else if (state is AppInitialized) {
          /// Dependency Injection of repositories and blocs
          /// Use updateShouldNotify to make dependencies available in
          /// `initState` methods of children widgets
          return MultiProvider(
            providers: <Provider>[
              Provider<CVRepository>.value(
                value: _state.cvRepository,
                updateShouldNotify: (previous, current) => false,
              ),
              Provider<ConfigRepository>.value(
                value: _state.configRepository,
                updateShouldNotify: (previous, current) => false,
              ),
              Provider<PreferencesRepository>.value(
                value: _state.preferencesRepository,
                updateShouldNotify: (previous, current) => false,
              ),
            ],
            child: BlocProviderTree(
              blocProviders: <BlocProvider>[
                BlocProvider(bloc: _appBloc),
                BlocProvider(bloc: _accountBloc),
                BlocProvider(bloc: _authBloc),
                BlocProvider(bloc: _loginBloc),
                BlocProvider(bloc: _registerBloc),
              ],
              child: _InitializedApp(state: state),
            ),
          );
        } else if (state is AppFailure) {
          return ErrorApp(error: state.error);
        }

        return ErrorApp(error: NotImplementedYetError());
      },
    );
  }
}

class _InitializedApp extends StatelessWidget {
  final String _tag = '$_InitializedApp';

  final AppInitialized state;

  _InitializedApp({this.state});

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    ///Routes
    final routes = Routes(context);

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
