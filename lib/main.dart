import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/managers.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/app.dart';
import 'package:social_cv_client_flutter/src/data/managers/local_configuration_manager.dart';
import 'package:social_cv_client_flutter/src/data/managers/shared_preferences_manager.dart';
import 'package:social_cv_client_flutter/src/data/repositories/repositories_provider.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';

// TODO automatically set this to false for release builds
const DEBUG_MODE = true;

Future<void> main() async {
  /// SystemChrome.setPreferredOrientations(
  ///     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  void run() async {
    initLogger(package: "CV App");

    ConfigRepository configRepository = LocalConfigManager();
    PreferencesRepository preferencesRepository = SharedPreferencesManager();

    CVApiManager cvClient = DefaultCVApiManager(
      apiBaseUrl: await configRepository.getApiServerUrl(),
      apiInterceptor: ApiInterceptor(
        accessToken: await preferencesRepository.getAccessToken(),
        refreshToken: await preferencesRepository.getRefreshToken(),
      ),
    );

    CVCacheManager cacheManager = DefaultCVCacheManager();

    CVRepository cvRepository = DefaultCloudCVRepository(
      cvApiManager: cvClient,
      cvCacheManager: cacheManager,
    );

    runApp(
      RepositoriesProvider(
        cvRepository: cvRepository,
        preferencesRepository: preferencesRepository,
        configRepository: configRepository,
        child: ConfigWrapperApp(),
      ),
    );
  }

  if (DEBUG_MODE) {
    run();
  } else {
    FlutterError.onError = globalErrorHandler;
    runZoned(run, onError: globalErrorHandler);
  }
}

///
/// Global error handler. Show stack trace
///
void globalErrorHandler(details) {
  String stackTrace;

  if (details is FlutterErrorDetails) {
    if (details.exception is Error) {
      stackTrace = details.stack.toString();
    }
  } else if (details is Error) {
    stackTrace = details.stackTrace.toString();
  } else {
    throw details;
  }

  LoggingService.fatal(
    details.toString(),
    errorCode: ErrorCodes.UNHANDLED_EXCEPTION,
    stackTrace: stackTrace,
  );
}
