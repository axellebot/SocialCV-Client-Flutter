import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';

/// [EntryListWidget] is a clever widget that use an [EntryListBloc]
/// based on [parentGroupId] or [ownerId] or [entryListBloc]
abstract class EntryListWidget extends StatefulWidget {
  final String parentGroupId;
  final String ownerId;
  final EntryListBloc entryListBloc;

  EntryListWidget({
    Key key,
    this.parentGroupId,
    this.ownerId,
    this.entryListBloc,
  })  : assert(
            parentGroupId != null && ownerId == null && entryListBloc == null),
        assert(
            parentGroupId == null && ownerId != null && entryListBloc == null),
        assert(
            parentGroupId == null && ownerId == null && entryListBloc != null),
        super(key: key);
}

/// If [widget.entryListBloc] exists the lifecycle of it will be managed by its creator
abstract class ComplexEntryListState<T extends EntryListWidget>
    extends State<T> {
  EntryListBloc entryListBloc;

  @override
  void initState() {
    super.initState();

    entryListBloc = widget.entryListBloc;

    if (entryListBloc == null) {
      final cvRepository = Provider.of<CVRepository>(context);
      entryListBloc = EntryListBloc(cvRepository: cvRepository);
      entryListBloc.dispatch(EntryListInitialized(
        parentGroupId: widget.parentGroupId,
        ownerId: widget.ownerId,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.entryListBloc == null) entryListBloc.dispose();
    super.dispose();
  }
}
