import 'package:bloc/bloc.dart';
import 'package:social_cv_client_dart_common/managers.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/data/managers/asset_config_manager.dart';
import 'package:social_cv_client_flutter/src/data/managers/shared_preferences_manager.dart';
import 'package:social_cv_client_flutter/src/domain/blocs/configuration/configuration.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final String _tag = '$ConfigurationBloc';

  ConfigurationBloc() : super();

  /// Interceptors
  ApiInterceptor _apiInterceptor;

  /// Managers
  CVApiManager _cvApiManager;
  CVCacheManager _cvCacheManager;

  /// Repositories
  CVRepository _cvRepository;
  PreferencesRepository _preferencesRepository;
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

      /// Preferences managers and repositories
      _preferencesRepository = SharedPreferencesManager();

      /// Config managers and repositories
      _configRepository = AssetConfigManager();

      /// CV Managers and repositories
      _apiInterceptor = ApiInterceptor(
        accessToken: await _preferencesRepository.getAccessToken(),
        refreshToken: await _preferencesRepository.getRefreshToken(),
      );
      _cvApiManager = DefaultCVApiManager(
        apiInterceptor: _apiInterceptor,
        apiBaseUrl: await _configRepository.getApiServerUrl(),
      );

      _cvCacheManager = DefaultCVCacheManager();

      _cvRepository = DefaultCloudCVRepository(
        cvApiManager: _cvApiManager,
        cvCacheManager: _cvCacheManager,
      );

      yield ConfigLoaded(
        cvRepository: _cvRepository,
        preferencesRepository: _preferencesRepository,
        configRepository: _configRepository,
      );
    } catch (error, stacktrace) {
      Logger.error('${error.runtimeType}', stackTrace: stacktrace);
      yield ConfigFailure(error: error);
    }
  }
}
