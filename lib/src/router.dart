import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/ui/commons/paths.dart';
import 'package:social_cv_client_flutter/src/ui/pages/auth_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/elements/entry_profile_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/elements/group_profile_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/elements/part_profile_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/elements/profile_profile_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/main_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/search_page.dart';
import 'package:social_cv_client_flutter/src/ui/pages/settings_page.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';

class AppRouter {
  final String _tag = '$AppRouter';
  final Router router = Router();

  AppRouter() {
    _defineRoutes();
  }

  void _defineRoutes() {
    Logger.log('$_tag:$_defineRoutes');

    router.define(
      AppPaths.kPathHome,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          Logger.log('Navigate to ${AppPaths.kPathHome}');
          return MainPage();
        },
      ),
    );

    router.define(
      AppPaths.kPathAccount,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          Logger.log('Navigate to ${AppPaths.kPathAccount}');
          return MainPage();
        },
      ),
    );

    router.define(
      AppPaths.kPathLogin,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          Logger.log('Navigate to ${AppPaths.kPathLogin}');
          return AuthPage();
        },
      ),
    );

    router.define(
      AppPaths.kPathSettings,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          Logger.log('Navigate to ${AppPaths.kPathSettings}');
          return SettingsPage();
        },
      ),
    );

    router.define(
      AppPaths.kPathSearch,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          Logger.log('Navigate to ${AppPaths.kPathSearch}');
          return SearchPage();
        },
      ),
    );

    router.define(
      '${AppPaths.kPathProfiles}/:${AppPaths.kParamProfileId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var profileId = params[AppPaths.kParamProfileId][0];

          Logger.log('Navigate to ${AppPaths.kPathProfiles}/$profileId');

          return ProfileProfilePage(profileId: profileId);
        },
      ),
    );

    router.define(
      '${AppPaths.kPathParts}/:${AppPaths.kParamPartId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var partId = params[AppPaths.kParamPartId][0];

          Logger.log('Navigate to ${AppPaths.kPathParts}/$partId');

          return PartProfilePage(partId: partId);
        },
      ),
    );

    router.define(
      '${AppPaths.kPathGroups}/:${AppPaths.kParamGroupId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var groupId = params[AppPaths.kParamGroupId][0];

          Logger.log('Navigate to ${AppPaths.kPathGroups}/$groupId');

          return GroupPage(groupId: groupId);
        },
      ),
    );

    router.define(
      '${AppPaths.kPathEntries}/:${AppPaths.kParamEntryId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var entryId = params[AppPaths.kParamEntryId][0];

          Logger.log('Navigate to ${AppPaths.kPathEntries}/$entryId');

          return EntryPage(entryId: entryId);
        },
      ),
    );
  }
}
