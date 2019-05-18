import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

abstract class GroupListWidget extends StatefulWidget {
  final String parentPartId;
  final String ownerId;
  final GroupListBloc groupListBloc;

  GroupListWidget({
    Key key,
    this.parentPartId,
    this.ownerId,
    this.groupListBloc,
  })  : assert(
            parentPartId != null && ownerId == null && groupListBloc == null),
        assert(
            parentPartId == null && ownerId != null && groupListBloc == null),
        assert(
            parentPartId == null && ownerId == null && groupListBloc != null),
        super(key: key);
}

/// If [widget.groupListBloc] exists the lifecycle of it will be managed by its creator
abstract class GroupListWidgetState<T extends GroupListWidget>
    extends State<T> {
  GroupListBloc groupListBloc;

  @override
  void initState() {
    super.initState();

    groupListBloc = widget.groupListBloc;

    if (widget.groupListBloc == null) {
      final cvRepository = Provider.of<CVRepository>(context);
      groupListBloc = GroupListBloc(cvRepository: cvRepository);
      groupListBloc.dispatch(GroupListInitialized(
        parentPartId: widget.parentPartId,
        ownerId: widget.ownerId,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.groupListBloc == null) groupListBloc.dispose();
    super.dispose();
  }
}
