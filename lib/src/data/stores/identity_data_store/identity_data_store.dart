import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';

abstract class IdentityDataStore {
  FutureOr<UserDataModel?> getIdentity();

  FutureOr<UserDataModel> setIdentity(UserDataModel userModel);
}
