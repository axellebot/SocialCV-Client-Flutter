import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/app.dart';
import 'package:social_cv_client_flutter/src/repositories/shared_preferences_repository.dart';
import 'package:social_cv_client_flutter/src/repositories/repositories_provider.dart';
import 'package:social_cv_client_flutter/src/repositories/local_secrets_repository.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';

// TODO automatically set this to false for release builds
const DEBUG_MODE = true;

Future<void> main() async {
  /// SystemChrome.setPreferredOrientations(
  ///     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  void run() async {
    initLogger(package: "CV App");

    SecretsRepository secretsRepository = LocalSecretsRepository();
    PreferencesRepository preferencesRepository = SharedPreferencesRepository();

    CVClient cvClient = CVClientImpl(
      accessToken: await preferencesRepository.getAccessToken(),
      refreshToken: await preferencesRepository.getRefreshToken(),
    );
    CVCache cvCache = CVCacheImpl();

    CVRepository cvRepository = CVRepositoryImpl(
      client: cvClient,
      cache: cvCache,
    );

    runApp(
      RepositoriesProvider(
        cvRepository: cvRepository,
        preferencesRepository: preferencesRepository,
        secretsRepository: secretsRepository,
        child: CVApp(),
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
