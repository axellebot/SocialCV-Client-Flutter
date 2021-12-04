import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/presentation.dart';

abstract class ProfileDataStore {
  FutureOr<ProfileDataModel?> getProfile(String profileId);

  FutureOr<ProfileDataModel> setProfile(ProfileDataModel profileModel);

  FutureOr<List<ProfileDataModel>> getProfiles({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  FutureOr<List<ProfileDataModel>> getProfilesFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
