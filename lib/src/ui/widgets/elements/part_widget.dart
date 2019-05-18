import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/data/repositories/repositories_provider.dart';

/// If [partBloc] given we assume that it have been already initialized
abstract class PartWidget extends StatefulWidget {
  final String partId;
  final PartViewModel part;
  final PartBloc partBloc;

  PartWidget({Key key, this.partId, this.part, this.partBloc})
      : assert(partId != null && part == null && partBloc == null),
        assert(partId == null && part != null && partBloc == null),
        assert(partId == null && part == null && partBloc != null),
        super(key: key);
}

/// If [widget.partBloc] exists the lifecycle of it will be managed by its creator
abstract class PartWidgetState<T extends PartWidget> extends State<T> {
  PartBloc partBloc;

  @override
  void initState() {
    super.initState();

    partBloc = widget.partBloc;

    if (partBloc == null) {
      var provider = RepositoriesProvider.of(context);
      partBloc = PartBloc(cvRepository: provider.cvRepository);
      partBloc.dispatch(PartInitialized(
        partId: widget.partId,
        part: widget.part,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.partBloc == null) partBloc.dispose();
    super.dispose();
  }
}
