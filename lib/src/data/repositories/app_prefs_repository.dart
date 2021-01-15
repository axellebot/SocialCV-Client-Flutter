import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/domain.dart';

class ImplAppPrefsRepository extends AppPrefsRepository {
  final AppPrefsDataStoreFactory factory;

  ImplAppPrefsRepository({@required this.factory})
      : assert(factory != null, 'No $AppPrefsDataStoreFactory given');

  @override
  FutureOr<bool> toggleDarkMode(bool darkMode) {
    return factory.create.toggleDarkMode(darkMode);
  }

  @override
  FutureOr<bool> getDarkMode() {
    return factory.create.getDarkMode();
  }

  @override
  FutureOr<bool> deleteDarkMode() {
    return factory.create.getDarkMode();
  }

  @override
  FutureOr deleteAll() {
    return factory.create.deleteAll();
  }
}
