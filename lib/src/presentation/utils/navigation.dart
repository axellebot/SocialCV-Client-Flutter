import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

void navigateToLogin(BuildContext context) {
  Navigator.of(context).pushNamed(AppPaths.kPathLogin);
}

void navigateToSettings(BuildContext context) {
  Navigator.of(context).pushNamed(AppPaths.kPathSettings);
}

void navigateToSearch(BuildContext context) {
  Navigator.of(context).pushNamed(AppPaths.kPathSearch);
}

void navigateToProfile(BuildContext context, String? profileId) {
  Navigator.of(context)
      .pushNamed('${AppPaths.kPathProfiles}/${profileId ?? ''}');
}

void navigateToPart(BuildContext context, String? partId) {
  Navigator.of(context).pushNamed('${AppPaths.kPathParts}/${partId ?? ''}');
}

void navigateToGroup(BuildContext context,
    {String? groupId, GroupEntity? group}) {
  assert(groupId != null || group != null);
  if (group != null) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => GroupPage(group: group)));
//    Navigator.of(context).pushNamed(
//      AppPaths.kPathGroups + '/${group.id ?? ''}',
//      arguments: group,
//    );
  } else if (groupId != null) {
    Navigator.of(context).pushNamed(
      '${AppPaths.kPathGroups}/${groupId}',
    );
  }
}

void navigateToEntry(BuildContext context,
    {String? entryId, EntryEntity? entry}) {
  assert(entryId != null || entry != null);
  if (entry != null) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EntryPage(entry: entry)));
//    Navigator.of(context).pushNamed(
//      AppPaths.kPathEntries + '/${entry.id ?? ''}',
//      arguments: entry,
//    );
  } else if (entryId != null) {
    Navigator.of(context).pushNamed('${AppPaths.kPathEntries}/${entryId}');
  }
}

void openMenuBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => MenuBottomSheet(),
  );
}
