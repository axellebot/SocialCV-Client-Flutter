import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/element_widget.dart';

/// If [profileBloc] given we assume that it have been already initialized
abstract class ProfileWidget extends ElementWidget<ProfileViewModel> {
  final ProfileBloc profileBloc;

  ProfileWidget(
      {Key key, String profileId, ProfileViewModel profile, this.profileBloc})
      : assert(profileId != null && profile == null && profileBloc == null),
        assert(profileId == null && profile != null && profileBloc == null),
        assert(profileId == null && profile == null && profileBloc != null),
        super(key: key, elementId: profileId, element: profile);
}

/// If [widget.profileBloc] exists the lifecycle of it will be managed by its creator
abstract class ProfileWidgetState<T extends ProfileWidget>
    extends ElementWidgetState<ProfileWidget> {
  ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();

    profileBloc = widget.profileBloc;

    if (profileBloc == null) {
      profileBloc = ProfileBloc();
      profileBloc.dispatch(ProfileInitialized(
        withId: widget.elementId,
        withProfile: widget.element,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.profileBloc == null) profileBloc.dispose();
    super.dispose();
  }
}
