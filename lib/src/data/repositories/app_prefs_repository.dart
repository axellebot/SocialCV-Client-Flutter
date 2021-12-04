import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

class ImplAppPrefsRepository extends AppPrefsRepository {
  final AppPrefsDataStoreFactory factory;

  ImplAppPrefsRepository({required this.factory});

  @override
  FutureOr<bool> toggleDarkMode(bool darkMode) {
    return factory.create.setDarkMode(darkMode);
  }

  @override
  FutureOr<bool?> getDarkMode() {
    return factory.create.getDarkMode();
  }

  @override
  FutureOr<bool> deleteDarkMode() {
    return factory.create.deleteDarkMode();
  }

  @override
  FutureOr<bool> deleteAll() {
    return factory.create.deleteAllPrefs();
  }
}
