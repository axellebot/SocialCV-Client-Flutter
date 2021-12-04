import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/src/presentation/utils/navigation.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/elements/profile_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/initial_circle_avatar_widget.dart';

class ProfileTile extends ProfileWidget {
  const ProfileTile({
    Key? key,
    String? profileId,
    ProfileEntity? profile,
    ProfileBloc? profileBloc,
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      bloc: widget.profileBloc,
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileLoading) {
        } else if (state is ProfileLoaded) {
          final profile = state.element;
          return ListTile(
            leading: InitialCircleAvatar(
              backgroundImage: NetworkImage('${profile.picture ?? ''}'),
            ),
            title: Text(profile.title ?? ''),
            subtitle: Text(profile.subtitle ?? ''),
            onTap: () => navigateToProfile(context, profile.id),
            trailing: const Icon(MdiIcons.accountDetails),
          );
        } else if (state is ProfileFailure) {
          return ErrorTile(error: state.error);
        }
        return ErrorTile(error: NotImplementedYetError());
      },
    );
  }
}
