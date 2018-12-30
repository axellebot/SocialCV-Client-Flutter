import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum SortState {
  SortAsc,
  SortDesc,
  NoSort,
}

class Sortbox extends StatefulWidget {
  const Sortbox({
    Key key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final SortState value;
  final ValueChanged<SortState> onChanged;

  /// The width of a checkbox widget.
  static const double width = 18.0;

  @override
  _SortboxState createState() => _SortboxState();
}

class _SortboxState extends State<Sortbox> {
  @override
  Widget build(BuildContext context) {
    IconData iconSort;
    if (widget.value == SortState.SortAsc) {
      iconSort = Icons.arrow_upward;
    } else if (widget.value == SortState.SortDesc) {
      iconSort = Icons.arrow_downward;
    } else {
      iconSort = Icons.close;
    }
    return GestureDetector(
      onTap: () => widget.onChanged(widget.value),
      child: Icon(iconSort),
    );
  }
}
