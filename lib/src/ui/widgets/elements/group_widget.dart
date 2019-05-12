import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/element_widget.dart';

/// If [groupBloc] given we assume that it have been already initialized and
abstract class GroupWidget extends ElementWidget<GroupViewModel> {
  final GroupBloc groupBloc;

  GroupWidget({Key key, String groupId, GroupViewModel group, this.groupBloc})
      : assert(groupId != null && group == null && groupBloc == null),
        assert(groupId == null && group != null && groupBloc == null),
        assert(groupId == null && group == null && groupBloc != null),
        super(key: key, elementId: groupId, element: group);
}

/// If [widget.profileBloc] exists the lifecycle of it will be managed by its creator
abstract class GroupWidgetState<T extends GroupWidget>
    extends ElementWidgetState<GroupWidget> {
  GroupBloc groupBloc;

  @override
  void initState() {
    super.initState();

    groupBloc = widget.groupBloc;

    if (groupBloc == null) {
      groupBloc = GroupBloc();
      groupBloc.dispatch(GroupInitialized(
        withId: widget.elementId,
        withGroup: widget.element,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.groupBloc == null) groupBloc.dispose();
    super.dispose();
  }
}
