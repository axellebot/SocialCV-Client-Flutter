import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/app.dart';
import 'package:social_cv_client_flutter/src/repositories/preferences_repository.dart';
import 'package:social_cv_client_flutter/src/repositories/repositories_provider.dart';
import 'package:social_cv_client_flutter/src/repositories/secrets_repository.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

Future<void> main() async {
  //  SystemChrome.setPreferredOrientations(
  //      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  initLogger(package: "CV App");

  SecretsRepository secretsRepository = SecretsRepositoryImpl();
  PreferencesRepository preferencesRepository = PreferencesRepositoryImpl();

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
