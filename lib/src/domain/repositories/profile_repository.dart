import 'dart:async';

import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';
import 'package:social_cv_client_flutter/src/domain/repositories/entity_repository.dart';

/// Repository interface for profile element purpose
abstract class ProfileRepository extends EntityRepository<ProfileEntity> {
  FutureOr<List<ProfileEntity>> getProfilesFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
