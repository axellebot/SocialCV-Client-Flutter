import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/blocs/main_bloc.dart';
import 'package:social_cv_client_flutter/src/commons/paths.dart';
import 'package:social_cv_client_flutter/src/pages/entry_page.dart';
import 'package:social_cv_client_flutter/src/pages/group_page.dart';
import 'package:social_cv_client_flutter/src/pages/auth_page.dart';
import 'package:social_cv_client_flutter/src/pages/part_page.dart';
import 'package:social_cv_client_flutter/src/pages/profile_page.dart';
import 'package:social_cv_client_flutter/src/pages/search_page.dart';
import 'package:social_cv_client_flutter/src/pages/settings_page.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';

class Routes {
  final Router router = Router();

  Routes({
    this.mainPageProvider,
    this.cvRepository,
    this.secretsRepository,
    this.preferencesRepository,
  }) {
    _defineRoutes();
  }

  final BlocProvider<MainBloc> mainPageProvider;
  final CVRepository cvRepository;
  final SecretsRepository secretsRepository;
  final PreferencesRepository preferencesRepository;

  void _defineRoutes() {
    router.define(
      AppPaths.kPathHome,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info('Navigate to ${AppPaths.kPathHome}');
          return mainPageProvider;
        },
      ),
    );

    router.define(
      AppPaths.kPathAccount,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info('Navigate to ${AppPaths.kPathAccount}');
          return mainPageProvider;
        },
      ),
    );

    ///TODO : Check other solution to avoid LoginBloc recreation when
    ///LoginPage rebuild (caused by input change)
    router.define(
      AppPaths.kPathLogin,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info('Navigate to ${AppPaths.kPathLogin}');
          return AuthPage();
        },
      ),
    );

    router.define(
      AppPaths.kPathSettings,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info('Navigate to ${AppPaths.kPathSettings}');
          return SettingsPage();
        },
      ),
    );

    ///TODO : Check other solution to avoid SearchBloc recreation when
    ///SearchPage rebuild (caused by input change)
    router.define(
      AppPaths.kPathSearch,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info('Navigate to ${AppPaths.kPathSearch}');

          return SearchPage();
        },
      ),
    );

    router.define(
      '${AppPaths.kPathProfiles}/:${AppPaths.kParamProfileId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var profileId = params[AppPaths.kParamProfileId][0];

          logger.info('Navigate to ${AppPaths.kPathProfiles}/$profileId');

          return BlocProvider<ProfileBloc>(
            bloc: ProfileBloc(cvRepository: cvRepository),
            child: ProfilePage(profileId: profileId),
          );
        },
      ),
    );

    router.define(
      '${AppPaths.kPathParts}/:${AppPaths.kParamPartId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var partId = params[AppPaths.kParamPartId][0];

          logger.info('Navigate to ${AppPaths.kPathParts}/$partId');

          return BlocProvider<PartBloc>(
            bloc: PartBloc(cvRepository: cvRepository),
            child: PartPage(partId: partId),
          );
        },
      ),
    );

    router.define(
      '${AppPaths.kPathGroups}/:${AppPaths.kParamGroupId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var groupId = params[AppPaths.kParamGroupId][0];

          logger.info('Navigate to ${AppPaths.kPathGroups}/$groupId');

          return BlocProvider<GroupBloc>(
            bloc: GroupBloc(cvRepository: cvRepository),
            child: GroupPage(groupId: groupId),
          );
        },
      ),
    );

    router.define(
      '${AppPaths.kPathEntries}/:${AppPaths.kParamEntryId}',
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var entryId = params[AppPaths.kParamEntryId][0];

          logger.info('Navigate to ${AppPaths.kPathEntries}/$entryId');

          return BlocProvider<EntryBloc>(
            bloc: EntryBloc(cvRepository: cvRepository),
            child: EntryPage(entryId: entryId),
          );
        },
      ),
    );
  }
}
