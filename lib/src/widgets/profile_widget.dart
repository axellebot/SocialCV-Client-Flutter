import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/utils/navigation.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key key,
    this.profileModel,
  })  : assert(profileModel != null),
        super(key: key);

  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InitialCircleAvatar(
        backgroundImage: NetworkImage(profileModel.picture ?? ""),
      ),
      title: Text(profileModel.title ?? ""),
      subtitle: Text(profileModel.subtitle ?? ""),
      onTap: () => navigateToProfile(context, profileModel.id),
      trailing: Icon(MdiIcons.accountDetails),
    );
  }
}
