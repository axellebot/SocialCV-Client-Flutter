import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/element_widget.dart';

/// If [partBloc] given we assume that it have been already initialized
abstract class PartWidget extends ElementWidget<PartViewModel> {
  final PartBloc partBloc;

  PartWidget({Key key, String partId, PartViewModel part, this.partBloc})
      : assert(partId != null && part == null && partBloc == null),
        assert(partId == null && part != null && partBloc == null),
        assert(partId == null && part == null && partBloc != null),
        super(key: key, elementId: partId, element: part);
}

/// If [widget.profileBloc] exists the lifecycle of it will be managed by its creator
abstract class PartWidgetState<T extends PartWidget>
    extends ElementWidgetState<PartWidget> {
  PartBloc partBloc;

  @override
  void initState() {
    super.initState();

    partBloc = widget.partBloc;

    if (partBloc == null) {
      partBloc = PartBloc();
      partBloc.dispatch(PartInitialized(
        withId: widget.elementId,
        withPart: widget.element,
      ));
    }
  }

  @override
  void dispose() {
    if (widget.partBloc == null) partBloc.dispose();
    super.dispose();
  }
}
