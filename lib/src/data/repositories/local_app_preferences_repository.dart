import 'package:meta/meta.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/data/managers/app_shared_preferences_manager.dart';

class LocalAppPreferencesRepository implements AppPreferencesRepository {
  final AppSharedPreferencesManager appSharedPreferencesManager;

  LocalAppPreferencesRepository({@required this.appSharedPreferencesManager})
      : assert(
          appSharedPreferencesManager != null,
          'No $AppSharedPreferencesManager given',
        );

  @override
  Future<void> deleteAll() async {
    return await appSharedPreferencesManager.deleteAll();
  }

  @override
  Future<void> deleteAppTheme() async {
    return await appSharedPreferencesManager.deleteAppTheme();
  }

  @override
  Future<void> deleteUserEmail() async {
    return await appSharedPreferencesManager.deleteUserEmail();
  }

  @override
  Future<void> deleteUserId() async {
    return await appSharedPreferencesManager.deleteUserId();
  }

  @override
  Future<String> getAppTheme() async {
    return await appSharedPreferencesManager.getAppTheme();
  }

  @override
  Future<String> getUserEmail() async {
    return await appSharedPreferencesManager.getUserEmail();
  }

  @override
  Future<String> getUserId() async {
    return await appSharedPreferencesManager.getUserId();
  }

  @override
  Future<void> setAppTheme(String theme) async {
    return await appSharedPreferencesManager.setAppTheme(theme);
  }

  @override
  Future<void> setUserEmail(String userEmail) async {
    return await appSharedPreferencesManager.setUserEmail(userEmail);
  }

  @override
  Future<void> setUserId(String userId) async {
    return await appSharedPreferencesManager.setUserId(userId);
  }
}
