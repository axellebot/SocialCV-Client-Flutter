import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

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
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      bloc: _configBloc,
      builder: (BuildContext context, ConfigurationState state) {
        if (state is ConfigLoading) {
          return SplashApp();
        } else if (state is ConfigLoaded) {
          /// Dependency Injection of repositories
          /// Use updateShouldNotify to make dependencies available in
          /// `initState` methods of children widgets
          return BlocProvider<ConfigurationBloc>.value(
            value: _configBloc,
            child: MultiProvider(
              providers: <Provider>[
                Provider<CVAuthService>.value(
                  value: state.cvAuthService,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<AuthInfoRepository>.value(
                  value: state.authInfoRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<AppPrefsRepository>.value(
                  value: state.appPrefsRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<UserRepository>.value(
                  value: state.userRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<ProfileRepository>.value(
                  value: state.profileRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<PartRepository>.value(
                  value: state.partRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<GroupRepository>.value(
                  value: state.groupRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
                Provider<EntryRepository>.value(
                  value: state.entryRepository,
                  updateShouldNotify: (previous, current) => false,
                ),
              ],
              child: _BlocWrapper(state: state),
            ),
          );
        }
        return ErrorApp(error: NotImplementedYetError());
      },
    );
  }
}

/// Wrap all global bloc to configure them
class _BlocWrapper extends StatefulWidget {
  final ConfigLoaded state;

  const _BlocWrapper({Key key, @required this.state}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BlocWrapperState();
}

class _BlocWrapperState extends State<_BlocWrapper> {
  final String _tag = '$_BlocWrapperState';

  AppBloc _appBloc;
  IdentityBloc _identityBloc;
  LoginBloc _loginBloc;
  RegisterBloc _registerBloc;
  AuthenticationBloc _authBloc;

  ConfigLoaded get _state => widget.state;

  @override
  void initState() {
    super.initState();
    _appBloc = AppBloc(
      appPreferencesRepository: _state.appPrefsRepository,
    );

    _loginBloc = LoginBloc(cvAuthService: _state.cvAuthService);
    _registerBloc = RegisterBloc(cvAuthService: _state.cvAuthService);

    _authBloc = AuthenticationBloc(
      authInfoRepository: _state.authInfoRepository,
      cvAuthService: _state.cvAuthService,
      loginBloc: _loginBloc,
      registerBloc: _registerBloc,
    );

    _identityBloc = IdentityBloc(
      identityRepo: _state.identityRepository,
      authBloc: _authBloc,
    );

    // Inform AppBloc that the application just started
    _appBloc.dispatch(AppConfigured());

    // Inform AuthBloc that the application just started
    _authBloc.dispatch(AppStarted());
  }

  @override
  void dispose() {
    _appBloc?.dispose();
    _loginBloc?.dispose();
    _registerBloc?.dispose();
    _identityBloc?.dispose();
    _authBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<AppBloc>.value(value: _appBloc),
        BlocProvider<AuthenticationBloc>.value(value: _authBloc),
        BlocProvider<IdentityBloc>.value(value: _identityBloc),
        BlocProvider<LoginBloc>.value(value: _loginBloc),
        BlocProvider<RegisterBloc>.value(value: _registerBloc),
      ],
      child: _App(),
    );
  }
}

class _App extends StatelessWidget {
  final String _tag = '$_App';

  _App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    ///Routes
    final appRouter = AppRouter();

    AppInitialized tmpState;

    return BlocBuilder(
      bloc: BlocProvider.of<AppBloc>(context),
      builder: (BuildContext context, AppState state) {
        if (state is AppLoading || state is AppInitialized) {
          if (state is AppInitialized) tmpState = state;

          return MaterialApp(
            onGenerateTitle: (BuildContext context) =>
                CVLocalizations.of(context).appName,
            theme: _buildCVTheme(tmpState.darkMode),
            home: const MainPage(),
            onGenerateRoute: appRouter.router.generator,

            // Use Fluro routes
            localizationsDelegates: [
              const CVLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('fr'),
            ],
            debugShowCheckedModeBanner: false,
          );
        } else if (state is AppFailure) {
          return ErrorApp(error: state.error);
        }

        return ErrorApp(error: NotImplementedYetError());
      },
    );
  }

  ThemeData _buildCVTheme(bool darkMode) {
    ThemeData themeData;
    if (!darkMode) {
      themeData = ThemeData.light();
    } else {
      themeData = ThemeData.dark();
    }

    themeData = themeData.copyWith(
      primaryColor: AppStyles.primaryColor,
      primaryColorLight: AppStyles.primaryColorLight,
      primaryColorDark: AppStyles.primaryColorDark,
      accentColor: AppStyles.accentColor,
      inputDecorationTheme: InputDecorationTheme(
        hasFloatingPlaceholder: true,
        border: OutlineInputBorder(),
      ),
    );

    Color buttonColor;
    ButtonThemeData buttonTheme;
    IconThemeData iconThemeData;
    if (!darkMode) {
      buttonColor = AppStyles.colorWhite;
      buttonTheme = ButtonThemeData(buttonColor: themeData.primaryColorLight);
      iconThemeData = IconThemeData(color: Colors.black);
    } else {
      buttonColor = AppStyles.primaryColorDark;
      buttonTheme = ButtonThemeData(buttonColor: themeData.primaryColorDark);
      iconThemeData = IconThemeData(color: Colors.white);
    }

    return themeData.copyWith(
      buttonColor: buttonColor,
      buttonTheme: buttonTheme,
      textTheme: _buildCVTextTheme(themeData.textTheme),
      primaryTextTheme: _buildCVTextTheme(themeData.primaryTextTheme),
      accentTextTheme: _buildCVTextTheme(themeData.accentTextTheme),
      iconTheme: iconThemeData,
    );
  }

  TextTheme _buildCVTextTheme(TextTheme base) {
    return base.apply(
      fontFamily: 'Arial',
    );
  }
}
