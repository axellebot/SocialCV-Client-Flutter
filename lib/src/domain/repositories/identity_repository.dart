import 'dart:async';

import 'package:social_cv_client_flutter/domain.dart';

/// Repository interface for connected user information purpose
abstract class IdentityRepository {
  /// Fetch information of the authenticated user
  ///
  /// Must return an [UserEntity]
  FutureOr<UserEntity> getIdentity();

//  /// Fetch profiles from the authenticated user account
//  ///
//  /// [Cursor] can be used to choose the offset and the limit
//  ///
//  /// Must return a [List] of [ProfileEntity]
//  FutureOr<List<ProfileEntity>> getProfilesFromIdentity({
//    /// TODO: Add filters
//    /// TODO: Add sort
//    Cursor cursor = const Cursor(),
//  });
}
