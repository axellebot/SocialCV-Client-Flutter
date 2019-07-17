import 'package:bloc/bloc.dart';
import 'package:social_cv_client_dart_common/managers.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/data/managers/app_shared_preferences_manager.dart';
import 'package:social_cv_client_flutter/src/data/managers/auth_shared_preferences_manager.dart';
import 'package:social_cv_client_flutter/src/data/managers/config_assets_manager.dart';
import 'package:social_cv_client_flutter/src/data/repositories/local_app_preferences_repository.dart';
import 'package:social_cv_client_flutter/src/data/repositories/local_auth_preferences_repository.dart';
import 'package:social_cv_client_flutter/src/data/repositories/local_config_repository.dart';
import 'package:social_cv_client_flutter/src/domain/blocs/configuration/configuration.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final String _tag = '$ConfigurationBloc';

  ConfigurationBloc() : super();

  /// Repositories
  CVRepository _cvRepository;
  AuthPreferencesRepository _authPreferencesRepository;
  AppPreferencesRepository _appPreferencesRepository;
  ConfigRepository _configRepository;

  @override
  ConfigurationState get initialState => ConfigLoading();

  @override
  Stream<ConfigurationState> mapEventToState(ConfigurationEvent event) async* {
    if (event is AppLaunched) {
      yield* _mapAppLaunchedEventToState();
    }
  }

  Stream<ConfigurationState> _mapAppLaunchedEventToState() async* {
    try {
      yield ConfigLoading();

      /// Managers
      final _appSharedPreferencesManager = AppSharedPreferencesManager();
      final _authSharedPreferencesManager = AuthSharedPreferencesManager();
      final _localConfigManager = ConfigAssetsManager();

      /// Repositories
      _appPreferencesRepository = LocalAppPreferencesRepository(
        appSharedPreferencesManager: _appSharedPreferencesManager,
      );
      _authPreferencesRepository = LocalAuthPreferencesRepository(
        authSharedPreferencesManager: _authSharedPreferencesManager,
      );
      _configRepository = LocalConfigRepository(
        configAssetsManager: _localConfigManager,
      );

      /// CV Managers and repositories
      final _apiInterceptor = ApiInterceptor(
        accessToken: await _authPreferencesRepository.getAccessToken(),
        refreshToken: await _authPreferencesRepository.getRefreshToken(),
      );

      final _cvApiManager = DefaultCVApiManager(
        apiInterceptor: _apiInterceptor,
        apiBaseUrl: await _configRepository.getApiServerUrl(),
      );

      final _cvCacheManager = DefaultCVCacheManager();

      _cvRepository = DefaultCloudCVRepository(
        cvApiManager: _cvApiManager,
        cvCacheManager: _cvCacheManager,
      );

      yield ConfigLoaded(
        cvRepository: _cvRepository,
        authPreferencesRepository: _authPreferencesRepository,
        appPreferencesRepository: _appPreferencesRepository,
        configRepository: _configRepository,
      );
    } catch (error, stacktrace) {
      Logger.error('${error.runtimeType}', stackTrace: stacktrace);
      yield ConfigFailure(error: error);
    }
  }
}
