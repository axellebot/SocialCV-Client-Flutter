import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// If [profileListBloc] given we assume that it have been already initialized
abstract class ProfileListWidget extends StatefulWidget {
  final String parentUserId;
  final String ownerId;
  final ProfileListBloc profileListBloc;

  ProfileListWidget({
    Key key,
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
  ProfileListBloc profileListBloc;

  @override
  void initState() {
    super.initState();
    profileListBloc = widget.profileListBloc;
    if (widget.profileListBloc == null) {
      final cvRepository = Provider.of<CVRepository>(context, listen: false);

      profileListBloc = ProfileListBloc(cvRepository: cvRepository);
      profileListBloc.dispatch(ProfileListInitialized(
        parentUserId: widget.parentUserId,
        ownerId: widget.ownerId,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.profileListBloc == null) profileListBloc.dispose();
    super.dispose();
  }
}
