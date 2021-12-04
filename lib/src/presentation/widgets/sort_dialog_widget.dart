import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/presentation/commons/styles.dart';
import 'package:social_cv_client_flutter/src/presentation/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/presentation/utils/logger.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/sort_list_tile_widget.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({
    Key? key,
    this.title,
    required this.sortItems,
  }) : super(key: key);

  final Widget? title;
  final List<SortListItem> sortItems;

  @override
  State<StatefulWidget> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  final String _tag = '$_SortDialogState';

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    final _listTiles = widget.sortItems
        .map((sortItem) => SortListTile(
              key: Key(sortItem.field!),
              value: sortItem.value,
              title: Text(sortItem.title!),
              onChanged: (SortState? value) {
                setState(() {
                  Logger.log('${sortItem.field} $value');
                  sortItem.value = value;
                });
              },
            ))
        .toList();

    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      title: widget.title,
      content: Container(
        width: AppStyles.sortDialogWidth,
        height: AppStyles.sortDialogHeight,
        child: ReorderableListView(
          onReorder: _onReorder,
          children: _listTiles,
        ),
      ),
      actions: <Widget>[
        SimpleDialogOption(
          child: Text(CVLocalizations.of(context)!.sortDialogCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SimpleDialogOption(
          child: Text(CVLocalizations.of(context)!.sortDialogConfirm),
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
