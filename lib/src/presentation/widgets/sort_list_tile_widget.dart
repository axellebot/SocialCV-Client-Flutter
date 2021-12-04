import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/sort_box_widget.dart';

class SortListItem {
  SortListItem({
    this.title,
    this.field,
    this.value,
  });

  final String? title;
  final String? field;
  SortState? value;
}

class SortListTile extends StatelessWidget {
  const SortListTile({
    Key? key,
    this.activeColor,
    this.title,
    this.value,
    this.onChanged,
  }) : super(key: key);

  final Color? activeColor;
  final Widget? title;
  final ValueChanged<SortState?>? onChanged;
  final SortState? value;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ListTileTheme.merge(
        selectedColor: activeColor ?? Theme.of(context).accentColor,
        child: ListTile(
          key: key,
          leading: Icon(Icons.unfold_more),
          title: title,
          trailing: SortBox(value: value, onChanged: onChanged),
          onTap: onChanged != null
              ? () {
                  if (value == SortState.sortAsc)
                    onChanged!(SortState.sortDesc);
                  if (value == SortState.sortDesc) onChanged!(SortState.noSort);
                  if (value == SortState.noSort) onChanged!(SortState.sortAsc);
                }
              : null,
        ),
      ),
    );
  }
}
