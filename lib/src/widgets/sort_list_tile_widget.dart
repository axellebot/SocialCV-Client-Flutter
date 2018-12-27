import 'package:cv/src/widgets/sort_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SortListItem {
  SortListItem({
    this.title,
    this.field,
    this.value,
  });

  final String title;
  final String field;
  SortState value;
}

class SortListTile extends StatelessWidget {
  SortListTile({
    Key key,
    this.activeColor,
    this.title,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final Color activeColor;
  final Widget title;
  final ValueChanged<SortState> onChanged;
  final SortState value;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: activeColor ?? Theme.of(context).accentColor,
        child: ListTile(
          key: key,
          leading: Icon(Icons.unfold_more),
          title: title,
          trailing: Sortbox(value: value, onChanged: onChanged),
          onTap: onChanged != null
              ? () {
                  if (value == SortState.SortAsc) onChanged(SortState.SortDesc);
                  if (value == SortState.SortDesc) onChanged(SortState.NoSort);
                  if (value == SortState.NoSort) onChanged(SortState.SortAsc);
                }
              : null,
        ),
      ),
    );
  }
}
