import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// If [profileListBloc] given we assume that it have been already initialized
abstract class ProfileListWidget extends StatefulWidget {
  final String? parentUserId;
  final String? ownerId;
  final ProfileListBloc? profileListBloc;

  const ProfileListWidget({
    Key? key,
    this.parentUserId,
    this.ownerId,
    this.profileListBloc,
  })  : assert(
            parentUserId != null && ownerId == null && profileListBloc == null),
        assert(
            parentUserId == null && ownerId != null && profileListBloc == null),
        assert(
            parentUserId == null && ownerId == null && profileListBloc != null),
        super(key: key);
}

/// If [widget.profileListBloc] exists the lifecycle of it will be managed by its creator
abstract class ProfileListWidgetState<T extends ProfileListWidget>
    extends State<T> {
  ProfileListBloc? profileListBloc;

  @override
  void initState() {
    super.initState();
    profileListBloc = widget.profileListBloc;
    if (widget.profileListBloc == null) {
      final profileRepo =
          Provider.of<ProfileRepository>(context, listen: false);

      profileListBloc = ProfileListBloc(repository: profileRepo);
      profileListBloc!.add(ProfileListInitialize(
        parentUserId: widget.parentUserId,
        ownerId: widget.ownerId,
        cursor: const Cursor(),
      ));
    }
  }

  @override
  void dispose() {
    if (widget.profileListBloc == null) profileListBloc!.close();
    super.dispose();
  }
}
