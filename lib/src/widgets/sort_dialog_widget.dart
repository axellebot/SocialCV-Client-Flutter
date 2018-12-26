import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:cv/src/widgets/sort_box_widget.dart';
import 'package:cv/src/widgets/sort_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({Key key, this.title, this.sortItems}) : super(key: key);

  final Widget title;
  final List<SortListItem> sortItems;

  @override
  State<StatefulWidget> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  @override
  Widget build(BuildContext context) {
    final _listTiles = widget.sortItems
        .map((sortItem) => SortListTile(
              key: Key(sortItem.field),
              value: sortItem.value,
              title: Text(sortItem.title),
              onChanged: (SortState value) {
                setState(() {
                  logger.info("${sortItem.field} $value");
                  sortItem.value = value;
                });
              },
            ))
        .toList();

    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      title: widget.title,
      content: Container(
        width: kCVSortDialogWidth,
        height: kCVSortDialogHeight,
        child: ReorderableListView(
          onReorder: _onReorder,
          children: _listTiles,
        ),
      ),
      actions: <Widget>[
        SimpleDialogOption(
          child: Text(Localization.of(context).sortDialogCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SimpleDialogOption(
          child: Text(Localization.of(context).sortDialogConfirm),
          onPressed: null,
        ),
      ],
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final SortListItem item = widget.sortItems.removeAt(oldIndex);
      widget.sortItems.insert(newIndex, item);
    });
  }
}
