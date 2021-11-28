import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// If [entryBloc] given we assume that it have been already initialized
abstract class EntryWidget extends StatefulWidget {
  final String entryId;
  final EntryEntity entry;
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
      final repo = Provider.of<EntryRepository>(context, listen: false);

      entryBloc = EntryBloc(repository: repo);
      entryBloc.add(EntryInitialize(
        entryId: widget.entryId,
        entry: widget.entry,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.entryBloc == null) entryBloc.close();
    super.dispose();
  }
}
