import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/data/repositories/repositories_provider.dart';

/// If [entryBloc] given we assume that it have been already initialized
abstract class EntryWidget extends StatefulWidget {
  final String entryId;
  final EntryViewModel entry;
  final EntryBloc entryBloc;

  EntryWidget({Key key, this.entryId, this.entry, this.entryBloc})
      : assert(entryId != null && entry == null && entryBloc == null),
        assert(entryId == null && entry != null && entryBloc == null),
        assert(entryId == null && entry == null && entryBloc != null),
        super(key: key);
}

/// If [widget.entryBloc] exists the lifecycle of it will be managed by its creator
abstract class EntryWidgetState<T extends EntryWidget> extends State<T> {
  EntryBloc entryBloc;

  @override
  void initState() {
    super.initState();

    entryBloc = widget.entryBloc;

    if (entryBloc == null) {
      var provider = RepositoriesProvider.of(context);
      entryBloc = EntryBloc(cvRepository: provider.cvRepository);
      entryBloc.dispatch(EntryInitialized(
        entryId: widget.entryId,
        entry: widget.entry,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.entryBloc == null) entryBloc.dispose();
    super.dispose();
  }
}
