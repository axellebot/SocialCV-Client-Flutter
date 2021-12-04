import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum SortState {
  sortAsc,
  sortDesc,
  noSort,
}

class SortBox extends StatelessWidget {
  const SortBox({
    Key? key,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final SortState? value;
  final ValueChanged<SortState?>? onChanged;

  /// The width of a checkbox widget.
  final double width = 18.0;

  @override
  Widget build(BuildContext context) {
    IconData iconSort;
    if (value == SortState.sortAsc) {
      iconSort = Icons.arrow_upward;
    } else if (value == SortState.sortDesc) {
      iconSort = Icons.arrow_downward;
    } else {
      iconSort = Icons.close;
    }
    return GestureDetector(
      onTap: () => onChanged!(value),
      child: Icon(iconSort),
    );
  }
}
