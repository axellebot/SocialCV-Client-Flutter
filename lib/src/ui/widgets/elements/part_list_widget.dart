import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/data/repositories/repositories_provider.dart';

abstract class PartListWidget extends StatefulWidget {
  final String parentProfileId;
  final String ownerId;
  final PartListBloc partListBloc;

  PartListWidget({
    Key key,
    this.parentProfileId,
    this.ownerId,
    this.partListBloc,
  })  : assert(
            parentProfileId != null && ownerId == null && partListBloc == null),
        assert(
            parentProfileId == null && ownerId != null && partListBloc == null),
        assert(
            parentProfileId == null && ownerId == null && partListBloc != null),
        super(key: key);
}

/// If [widget.partListBloc] exists the lifecycle of it will be managed by its creator
abstract class PartListWidgetState<T extends PartListWidget> extends State<T> {
  PartListBloc partListBloc;

  @override
  void initState() {
    super.initState();
    partListBloc = widget.partListBloc;
    if (widget.partListBloc == null) {
      var provider = RepositoriesProvider.of(context);
      partListBloc = PartListBloc(cvRepository: provider.cvRepository);
      partListBloc.dispatch(PartListInitialized(
        parentProfileId: widget.parentProfileId,
        ownerId: widget.ownerId,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.partListBloc == null) partListBloc.dispose();
    super.dispose();
  }
}
