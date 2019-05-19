import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_list_tile_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';

class SortDialog extends StatefulWidget {
  const SortDialog({
    Key key,
    this.title,
    @required this.sortItems,
  })  : assert(sortItems != null),
        super(key: key);

  final Widget title;
  final List<SortListItem> sortItems;

  @override
  State<StatefulWidget> createState() => _SortDialogState();
}

class _SortDialogState extends State<SortDialog> {
  final String _tag = '$_SortDialogState';

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    final _listTiles = widget.sortItems
        .map((sortItem) => SortListTile(
              key: Key(sortItem.field),
              value: sortItem.value,
              title: Text(sortItem.title),
              onChanged: (SortState value) {
                setState(() {
                  Logger.log('${sortItem.field} $value');
                  sortItem.value = value;
                });
              },
            ))
        .toList();

    return AlertDialog(
      contentPadding: EdgeInsets.all(0.0),
      title: widget.title,
      content: Container(
        width: AppDimensions.sortDialogWidth,
        height: AppDimensions.sortDialogHeight,
        child: ReorderableListView(
          onReorder: _onReorder,
          children: _listTiles,
        ),
      ),
      actions: <Widget>[
        SimpleDialogOption(
          child: Text(CVLocalizations.of(context).sortDialogCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        SimpleDialogOption(
          child: Text(CVLocalizations.of(context).sortDialogConfirm),
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
