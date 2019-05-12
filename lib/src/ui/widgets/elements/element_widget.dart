import 'package:flutter/widgets.dart';
import 'package:social_cv_client_dart_common/models.dart';

abstract class ElementWidget<T extends ElementViewModel>
    extends StatefulWidget {
  final String elementId;
  final T element;

  ElementWidget({Key key, this.elementId, this.element}) : super(key: key);
}

abstract class ElementWidgetState<T extends ElementWidget> extends State<T> {
  @override
  void initState() {
    super.initState();
  }
}
