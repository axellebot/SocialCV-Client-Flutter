import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// If [profileBloc] given we assume that it have been already initialized
abstract class ProfileWidget extends StatefulWidget {
  final String profileId;
  final ProfileViewModel profile;
  final ProfileBloc profileBloc;

  ProfileWidget({Key key, this.profileId, this.profile, this.profileBloc})
      : assert(profileId != null && profile == null && profileBloc == null),
        assert(profileId == null && profile != null && profileBloc == null),
        assert(profileId == null && profile == null && profileBloc != null),
        super(key: key);
}

/// If [widget.profileBloc] exists the lifecycle of it will be managed by its creator
abstract class ProfileWidgetState<T extends ProfileWidget> extends State<T> {
  ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();

    profileBloc = widget.profileBloc;

    if (profileBloc == null) {
      final cvRepository = Provider.of<CVRepository>(context);
      profileBloc = ProfileBloc(cvRepository: cvRepository);
      profileBloc.dispatch(ProfileInitialized(
        profileId: widget.profileId,
        profile: widget.profile,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.profileBloc == null) profileBloc.dispose();
    super.dispose();
  }
}
