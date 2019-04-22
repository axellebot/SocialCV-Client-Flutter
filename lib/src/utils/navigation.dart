import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/commons/paths.dart';
import 'package:social_cv_client_flutter/src/widgets/menu_bottom_sheet_widget.dart';

void navigateToLogin(BuildContext context) {
  Navigator.of(context).pushNamed(AppPaths.kPathLogin);
}

void navigateToSettings(BuildContext context) {
  Navigator.of(context).pushNamed(AppPaths.kPathSettings);
}

void navigateToSearch(BuildContext context) {
  Navigator.of(context).pushNamed(AppPaths.kPathSearch);
}

void navigateToProfile(BuildContext context, String profileId) {
  Navigator.of(context)
      .pushNamed(AppPaths.kPathProfiles + '/${profileId ?? ''}');
}

void navigateToPart(BuildContext context, String partId) {
  Navigator.of(context).pushNamed(AppPaths.kPathParts + '/${partId ?? ''}');
}

void navigateToGroup(BuildContext context, String groupId) {
  Navigator.of(context).pushNamed(AppPaths.kPathGroups + '/${groupId ?? ''}');
}

void navigateToEntry(BuildContext context, String entryId) {
  Navigator.of(context).pushNamed(AppPaths.kPathEntries + '/${entryId ?? ''}');
}

void openMenuBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => MenuBottomSheet(),
  );
}
