import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/widgets/menu_bottom_sheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rounded_modal/rounded_modal.dart';

void navigateToLogin(BuildContext context) {
  Navigator.of(context).pushNamed(kPathLogin);
}

void navigateToSettings(BuildContext context) {
  Navigator.of(context).pushNamed(kPathSettings);
}

void navigateToSearch(BuildContext context) {
  Navigator.of(context).pushNamed(kPathSearch);
}

void navigateToProfile(BuildContext context, String profileId) {
  Navigator.of(context).pushNamed(kPathProfiles + '/${profileId ?? ""}');
}

void navigateToPart(BuildContext context, String partId) {
  Navigator.of(context).pushNamed(kPathParts + '/${partId ?? ""}');
}

void navigateToGroup(BuildContext context, String groupId) {
  Navigator.of(context).pushNamed(kPathGroups + '/${groupId ?? ""}');
}

void navigateToEntry(BuildContext context, String entryId) {
  Navigator.of(context).pushNamed(kPathEntries + '/${entryId ?? ""}');
}

void openMenuBottomSheet(BuildContext context) {
  showRoundedModalBottomSheet(
    context: context,
    builder: (context) => Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: MenuBottomSheet(),
        ),
  );
}
