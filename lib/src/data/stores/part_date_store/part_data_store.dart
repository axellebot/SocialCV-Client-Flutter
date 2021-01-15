import 'dart:async';

import 'package:social_cv_client_flutter/data.dart';
import 'package:social_cv_client_flutter/presentation.dart';

abstract class PartDataStore {
  FutureOr<PartDataModel> getPart(String partId);

  FutureOr<PartDataModel> setPart(PartDataModel partModel);

  FutureOr<List<PartDataModel>> getParts({
    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  FutureOr<List<PartDataModel>> getPartsFromProfile(
    String profileId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });

  FutureOr<List<PartDataModel>> getPartsFromUser(
    String userId, {

    /// TODO: Add filters
    /// TODO: Add sort
    Cursor cursor = const Cursor(),
  });
}
