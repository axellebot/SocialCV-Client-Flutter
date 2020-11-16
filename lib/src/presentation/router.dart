import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class AppRouter {
  final String _tag = '$AppRouter';
  final FluroRouter router = FluroRouter();

  AppRouter() {
    _defineRoutes();
  }

  void _defineRoutes() {
    Logger.log('$_tag:_defineRoutes');

    router.define(
      AppPaths.kPathHome,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          Logger.log('Navigate to ${AppPaths.kPathHome}');
          return const MainPage();
        },
      ),
    );

    router.define(
      AppPaths.kPathAccount,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          Logger.log('Navigate to ${AppPaths.kPathAccount}');
          return const MainPage();
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
          final String profileId =
              params[AppPaths.kParamProfileId][0] as String;

          Logger.log('Navigate to ${AppPaths.kPathProfiles}/$profileId');

          return ProfileProfilePage(profileId: profileId);
        },
      ),
    );

    router.define(
      '${AppPaths.kPathParts}/:${AppPaths.kParamPartId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          final String partId = params[AppPaths.kParamPartId][0] as String;

          Logger.log('Navigate to ${AppPaths.kPathParts}/$partId');

          return PartProfilePage(partId: partId);
        },
      ),
    );

    router.define(
      '${AppPaths.kPathGroups}/:${AppPaths.kParamGroupId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          final String groupId = params[AppPaths.kParamGroupId][0] as String;

          Logger.log('Navigate to ${AppPaths.kPathGroups}/$groupId');

          return GroupPage(groupId: groupId);
        },
      ),
    );

    router.define(
      '${AppPaths.kPathEntries}/:${AppPaths.kParamEntryId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          final String entryId = params[AppPaths.kParamEntryId][0] as String;

          Logger.log('Navigate to ${AppPaths.kPathEntries}/$entryId');

          return EntryPage(entryId: entryId);
        },
      ),
    );
  }
}
