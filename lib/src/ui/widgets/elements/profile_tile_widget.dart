import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class ProfileTile extends StatelessWidget {
  final ProfileViewModel profileViewModel;

  const ProfileTile({
    Key key,
    this.profileViewModel,
  })  : assert(profileViewModel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InitialCircleAvatar(
        backgroundImage: NetworkImage(profileViewModel.picture ?? ''),
      ),
      title: Text(profileViewModel.title ?? ''),
      subtitle: Text(profileViewModel.subtitle ?? ''),
      onTap: () => navigateToProfile(context, profileViewModel.id),
      trailing: Icon(MdiIcons.accountDetails),
    );
  }
}
