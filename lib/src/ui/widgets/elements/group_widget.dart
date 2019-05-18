import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/data/repositories/repositories_provider.dart';

/// If [groupBloc] given we assume that it have been already initialized and
abstract class GroupWidget extends StatefulWidget {
  final String groupId;
  final GroupViewModel group;
  final GroupBloc groupBloc;

  GroupWidget({Key key, this.groupId, this.group, this.groupBloc})
      : assert(groupId != null && group == null && groupBloc == null),
        assert(groupId == null && group != null && groupBloc == null),
        assert(groupId == null && group == null && groupBloc != null),
        super(key: key);
}

/// If [widget.groupBloc] exists the lifecycle of it will be managed by its creator
abstract class GroupWidgetState<T extends GroupWidget> extends State<T> {
  GroupBloc groupBloc;

  @override
  void initState() {
    super.initState();

    groupBloc = widget.groupBloc;

    if (groupBloc == null) {
      var provider = RepositoriesProvider.of(context);
      groupBloc = GroupBloc(cvRepository: provider.cvRepository);
      groupBloc.dispatch(GroupInitialized(
        groupId: widget.groupId,
        group: widget.group,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.groupBloc == null) groupBloc.dispose();
    super.dispose();
  }
}