import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class ProfileTile extends ProfileWidget {
  ProfileTile({
    Key key,
    String profileId,
    ProfileViewModel profile,
    ProfileBloc profileBloc,
  }) : super(
          key: key,
          profileId: profileId,
          profile: profile,
          profileBloc: profileBloc,
        );

  @override
  State<StatefulWidget> createState() => _ProfileTileState();
}

class _ProfileTileState extends ProfileWidgetState<ProfileTile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileEvent, ProfileState>(
      bloc: widget.profileBloc,
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileLoading) {
        } else if (state is ProfileLoaded) {
          var profile = state.element;
          return ListTile(
            leading: InitialCircleAvatar(
              backgroundImage: NetworkImage(profile.picture ?? ''),
            ),
            title: Text(profile.title ?? ''),
            subtitle: Text(profile.subtitle ?? ''),
            onTap: () => navigateToProfile(context, profile.id),
            trailing: Icon(MdiIcons.accountDetails),
          );
        } else if (state is ProfileFailure) {
          return ErrorTile(message: '${state.error.runtimeType}');
        }
        return Container();
      },
    );
  }
}
