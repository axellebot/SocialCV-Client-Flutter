import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_bloc.dart';
import 'package:cv/src/blocs/group_bloc.dart';
import 'package:cv/src/blocs/main_bloc.dart';
import 'package:cv/src/blocs/part_bloc.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/pages/entry_page.dart';
import 'package:cv/src/pages/group_page.dart';
import 'package:cv/src/pages/login_page.dart';
import 'package:cv/src/pages/part_page.dart';
import 'package:cv/src/pages/profile_page.dart';
import 'package:cv/src/pages/search_page.dart';
import 'package:cv/src/pages/settings_page.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';

class Routes {
  final BlocProvider<MainBloc> _mainPageProvider;
  final Router router = Router();

  Routes(this._mainPageProvider) {
    _defineRoutes();
  }

  void _defineRoutes() {
    router.define(
      kPathHome,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathHome");
          return _mainPageProvider;
        },
      ),
    );

    router.define(
      kPathAccount,
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathAccount");
          return _mainPageProvider;
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
          logger.info("Navigate to $kPathProfiles/:$kParamProfileId");

          return BlocProvider<ProfileBloc>(
            bloc: ProfileBloc(),
            child: ProfilePage(profileId: params[kParamProfileId][0]),
          );
        },
      ),
    );

    router.define(
      "$kPathParts/:$kParamPartId",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathParts/:$kParamPartId");

          return BlocProvider<PartBloc>(
            bloc: PartBloc(),
            child: PartPage(partId: params[kParamPartId][0]),
          );
        },
      ),
    );

    router.define(
      "$kPathGroups/:$kParamGroupId",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathGroups/:$kParamGroupId");

          return BlocProvider<GroupBloc>(
            bloc: GroupBloc(),
            child: GroupPage(groupId: params[kParamGroupId][0]),
          );
        },
      ),
    );

    router.define(
      "$kPathEntries/:$kParamEntryId",
      handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
          logger.info("Navigate to $kPathEntries/:$kParamEntryId");

          return BlocProvider<EntryBloc>(
            bloc: EntryBloc(),
            child: EntryPage(entryId: params[kParamEntryId][0]),
          );
        },
      ),
    );
  }
}
