import 'dart:async';

import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Service for authentication purpose
abstract class CVAuthService {
  /// --------------------------------------------------------------------------
  ///                                  Auth
  /// --------------------------------------------------------------------------

  /// Authenticate
  ///
  /// Must use [email] and [password] to authenticate an user
  ///
  /// Must return an [AuthDataModel]
  FutureOr<AuthEntity> authenticate({
    @required String email,
    @required String password,
  });

  /// Register
  ///
  /// Must use [fName], [lName], [email] and [password] to register an user
  ///
  /// Must return an [AuthDataModel]
  FutureOr<AuthEntity> register({
    @required String fName,
    @required String lName,
    @required String email,
    @required String password,
  });

  FutureOr<void> logout();
}
