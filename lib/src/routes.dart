import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/blocs/main_bloc.dart';
import 'package:social_cv_client_flutter/src/commons/paths.dart';
import 'package:social_cv_client_flutter/src/pages/entry_page.dart';
import 'package:social_cv_client_flutter/src/pages/group_page.dart';
import 'package:social_cv_client_flutter/src/pages/login_page.dart';
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
      kPathHome,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathHome");
          return mainPageProvider;
        },
      ),
    );

    router.define(
      kPathAccount,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathAccount");
          return mainPageProvider;
        },
      ),
    );

    // TODO : Check other solution to avoid LoginBloc recreation when
    // LoginPage rebuild (caused by input change)
    router.define(
      kPathLogin,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathLogin");
          return LoginPage();
        },
      ),
    );

    router.define(
      kPathSettings,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathSettings");
          return SettingsPage();
        },
      ),
    );

    // TODO : Check other solution to avoid SearchBloc recreation when
    // SearchPage rebuild (caused by input change)
    router.define(
      kPathSearch,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathSearch");

          return SearchPage();
        },
      ),
    );

    router.define(
      "$kPathProfiles/:$kParamProfileId",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var profileId = params[kParamProfileId][0];

          logger.info("Navigate to $kPathProfiles/$profileId");

          return BlocProvider<ProfileBloc>(
            bloc: ProfileBloc(cvRepository: cvRepository),
            child: ProfilePage(profileId: profileId),
          );
        },
      ),
    );

    router.define(
      "$kPathParts/:$kParamPartId",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var partId = params[kParamPartId][0];

          logger.info("Navigate to $kPathParts/$partId");

          return BlocProvider<PartBloc>(
            bloc: PartBloc(cvRepository: cvRepository),
            child: PartPage(partId: partId),
          );
        },
      ),
    );

    router.define(
      "$kPathGroups/:$kParamGroupId",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var groupId = params[kParamGroupId][0];

          logger.info("Navigate to $kPathGroups/$groupId");

          return BlocProvider<GroupBloc>(
            bloc: GroupBloc(cvRepository: cvRepository),
            child: GroupPage(groupId: groupId),
          );
        },
      ),
    );

    router.define(
      "$kPathEntries/:$kParamEntryId",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          var entryId = params[kParamEntryId][0];

          logger.info("Navigate to $kPathEntries/$entryId");

          return BlocProvider<EntryBloc>(
            bloc: EntryBloc(cvRepository: cvRepository),
            child: EntryPage(entryId: entryId),
          );
        },
      ),
    );
  }
}
