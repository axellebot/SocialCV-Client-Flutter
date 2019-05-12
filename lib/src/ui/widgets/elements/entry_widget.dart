import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/element_widget.dart';

/// If [entryBloc] given we assume that it have been already initialized
abstract class EntryWidget extends ElementWidget<EntryViewModel> {
  final EntryBloc entryBloc;

  EntryWidget({Key key, String entryId, EntryViewModel entry, this.entryBloc})
      : assert(entryId != null && entry == null && entryBloc == null),
        assert(entryId == null && entry != null && entryBloc == null),
        assert(entryId == null && entry == null && entryBloc != null),
        super(key: key, elementId: entryId, element: entry);
}

/// If [widget.profileBloc] exists the lifecycle of it will be managed by its creator
abstract class EntryWidgetState<T extends EntryWidget>
    extends ElementWidgetState<EntryWidget> {
  EntryBloc entryBloc;

  @override
  void initState() {
    super.initState();

    entryBloc = widget.entryBloc;

    if (entryBloc == null) {
      entryBloc = EntryBloc();
      entryBloc.dispatch(EntryInitialized(
        withId: widget.elementId,
        withEntry: widget.element,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.entryBloc == null) entryBloc.dispose();
    super.dispose();
  }
}
